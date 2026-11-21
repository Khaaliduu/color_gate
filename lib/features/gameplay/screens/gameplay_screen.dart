import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/screen_shell.dart';
import '../engine/ball_movement_engine.dart';
import '../engine/game_session.dart';
import '../models/game_level.dart';
import '../providers/progress_controller.dart';
import '../widgets/game_board.dart';
import '../widgets/game_gate_widget.dart';
import 'level_complete_screen.dart';
import 'pause_screen.dart';
import 'try_again_screen.dart';

class GameplayScreen extends StatefulWidget {
  const GameplayScreen({
    super.key,
    required this.progress,
    required this.level,
  });

  final ProgressController progress;
  final int level;

  @override
  State<GameplayScreen> createState() => _GameplayScreenState();
}

class _GameplayScreenState extends State<GameplayScreen>
    with SingleTickerProviderStateMixin {
  late final GameLevel gameLevel;
  late final GameSession session;
  late final AnimationController movementController;

  final BallMovementEngine movementEngine = const BallMovementEngine();

  int? selectedGate;
  bool isMoving = false;
  bool resultOpened = false;

  @override
  void initState() {
    super.initState();
    gameLevel = GameLevel.create(widget.level);
    session = GameSession(gameLevel);
    movementController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..addStatusListener(_onMovementFinished);
  }

  @override
  void dispose() {
    movementController
      ..removeStatusListener(_onMovementFinished)
      ..dispose();
    super.dispose();
  }

  void _onMovementFinished(AnimationStatus status) {
    if (status != AnimationStatus.completed || !mounted) return;

    setState(() => isMoving = false);

    if (session.isComplete || session.isFailed) {
      _openResult();
    } else {
      setState(() {
        selectedGate = null;
        movementController.value = 0;
      });
    }
  }

  void _selectGate(int gateIndex) {
    if (!session.canPlay || isMoving) return;

    setState(() {
      selectedGate = gateIndex;
      isMoving = true;
      session.chooseGate(gateIndex);
    });

    movementController.forward(from: 0);
  }

  void _openResult() {
    if (resultOpened || !mounted) return;
    resultOpened = true;

    final page = session.isComplete
        ? LevelCompleteScreen(
            progress: widget.progress,
            level: widget.level,
            stars: session.earnedStars,
          )
        : TryAgainScreen(progress: widget.progress, level: widget.level);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
  }

  void _resetRound() {
    setState(() {
      session.reset();
      selectedGate = null;
      isMoving = false;
      resultOpened = false;
      movementController.value = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ballIndex = session.currentBallIndex
        .clamp(0, gameLevel.balls.length - 1)
        .toInt();
    final ball = gameLevel.balls[ballIndex];

    return ScreenShell(
      title: 'LEVEL ${widget.level.toString().padLeft(2, '0')}',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 14),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'BALLS  ${session.currentBallIndex}/${gameLevel.balls.length}',
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                const Spacer(),
                Text(
                  'MOVES  ${session.movesLeft}',
                  style: const TextStyle(
                    color: AppColors.lilac,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                IconButton(
                  onPressed: isMoving
                      ? null
                      : () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PauseScreen(
                              progress: widget.progress,
                              level: widget.level,
                            ),
                          ),
                        ),
                  icon: const Icon(
                    Icons.pause_circle,
                    color: AppColors.lilac,
                    size: 30,
                  ),
                ),
              ],
            ),
            Text(
              gameLevel.objective.description,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.muted, fontSize: 12),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: AnimatedBuilder(
                animation: movementController,
                builder: (context, child) => GameBoard(
                  level: gameLevel,
                  ball: ball,
                  progress: movementController.value,
                  activePath: selectedGate == null
                      ? null
                      : movementEngine.routeFor(gameLevel, selectedGate!),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'TAP A GATE TO GUIDE THE BALL',
              style: TextStyle(
                color: AppColors.muted,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: gameLevel.gates
                  .map(
                    (gate) => GameGateWidget(
                      gate: gate,
                      enabled: !isMoving && session.canPlay,
                      onTap: () => _selectGate(gate.id),
                    ),
                  )
                  .toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: !isMoving && session.answers.isNotEmpty
                      ? () => setState(session.undo)
                      : null,
                  child: const Text('UNDO'),
                ),
                TextButton(
                  onPressed:
                      !isMoving && widget.progress.hints > 0 && session.canPlay
                      ? () async {
                          final answer =
                              gameLevel.sequence[session.currentBallIndex];
                          final messenger = ScaffoldMessenger.of(context);
                          await widget.progress.useHint();
                          if (!mounted) return;
                          messenger.showSnackBar(
                            SnackBar(
                              content: Text(
                                'HINT: ${gameLevel.gates[answer].label}',
                              ),
                            ),
                          );
                        }
                      : null,
                  child: Text('HINT ${widget.progress.hints}'),
                ),
                TextButton(
                  onPressed: !isMoving ? _resetRound : null,
                  child: const Text('RESET'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
