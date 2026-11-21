import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/screen_shell.dart';
import '../models/game_level.dart';
import '../providers/progress_controller.dart';
import 'level_complete_screen.dart';
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
    with TickerProviderStateMixin {
  late GameLevel level;
  late AnimationController pulse;
  final AudioPlayer audio = AudioPlayer();
  Timer? clock;
  int secondsLeft = 35;
  int ballIndex = 0;
  int? targetGate;
  Offset ballPosition = const Offset(.5, .12);
  bool dragging = false;
  bool ended = false;
  bool paused = false;
  String message = 'FARTA KU JIJI KUBADDA ILAA MIDABKEEDA';
  int get timeLimit => (42 - (widget.level ~/ 3)).clamp(18, 42).toInt();

  @override
  void initState() {
    super.initState();
    level = GameLevel.create(widget.level);
    secondsLeft = timeLimit;
    pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
      lowerBound: .94,
      upperBound: 1,
    )..repeat(reverse: true);
    clock = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted || ended || paused) return;
      setState(() => secondsLeft--);
      if (secondsLeft <= 0) _finish(false, 'WAQTIGII WAA DHAMMAADAY');
    });
  }

  @override
  void dispose() {
    clock?.cancel();
    pulse.dispose();
    audio.dispose();
    super.dispose();
  }

  Future<void> _sound(String file) async {
    if (!widget.progress.soundEnabled) return;
    try {
      await audio.stop();
      await audio.play(AssetSource('sounds/$file.wav'));
    } catch (_) {}
  }

  void _dragUpdate(DragUpdateDetails d, Size size) {
    if (ended || paused) return;
    final local = d.localPosition;
    setState(() {
      dragging = true;
      ballPosition = Offset(
        (local.dx / size.width).clamp(.06, .94).toDouble(),
        (local.dy / size.height).clamp(.05, .94).toDouble(),
      );
    });
  }

  void _dragEnd(Size size) {
    if (!dragging || ended) return;
    final x = ballPosition.dx;
    final gate = x < .34 ? 0 : (x < .66 ? 1 : 2);
    if (ballPosition.dy < .72) {
      setState(() {
        dragging = false;
        ballPosition = const Offset(.5, .12);
        message = 'KUBADDA GAARSII IRIDDA HOOSE';
      });
      return;
    }
    setState(() {
      dragging = false;
      targetGate = gate;
    });
    if (gate != level.sequence[ballIndex]) {
      _sound('wrong');
      _finish(false, 'MIDABKA AAD DOORATAY WAA KHALDAN');
      return;
    }
    _sound('correct');
    if (ballIndex + 1 >= level.sequence.length) {
      _sound('level_complete');
      _finish(true, 'HEERKA WAAD DHAMMEYSAY');
    } else {
      setState(() {
        ballIndex++;
        targetGate = null;
        ballPosition = const Offset(.5, .12);
        secondsLeft = (secondsLeft + 2).clamp(0, timeLimit).toInt();
        message = 'SAX! KUBADDA XIGTA';
      });
    }
  }

  void _finish(bool won, String text) {
    if (ended) return;
    ended = true;
    clock?.cancel();
    setState(() => message = text);
    Future.delayed(const Duration(milliseconds: 450), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => won
              ? LevelCompleteScreen(
                  progress: widget.progress,
                  level: widget.level,
                  stars: secondsLeft > timeLimit * .55
                      ? 3
                      : (secondsLeft > 5 ? 2 : 1),
                )
              : TryAgainScreen(progress: widget.progress, level: widget.level),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = AppColors.gateColors[level.sequence[ballIndex]];
    return ScreenShell(
      title: 'LEVEL ${widget.level.toString().padLeft(2, '0')}',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: Column(
          children: [
            Row(
              children: [
                _stat(
                  'TIME',
                  '${secondsLeft}s',
                  secondsLeft <= 8 ? AppColors.danger : AppColors.mint,
                ),
                const Spacer(),
                _stat(
                  'BALL',
                  '${ballIndex + 1}/${level.sequence.length}',
                  AppColors.lilac,
                ),
                IconButton(
                  onPressed: () => setState(() => paused = !paused),
                  icon: Icon(
                    paused ? Icons.play_arrow_rounded : Icons.pause_rounded,
                    color: AppColors.lilac,
                    size: 30,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: (ballIndex / level.sequence.length).clamp(0, 1).toDouble(),
              color: AppColors.mint,
              backgroundColor: AppColors.surfaceAlt,
            ),
            const SizedBox(height: 12),
            Text(
              'DRAG THE BALL TO ITS MATCHING GATE',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 12,
                letterSpacing: .7,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: LayoutBuilder(
                builder: (context, c) {
                  final size = Size(c.maxWidth, c.maxHeight);
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onPanStart: (_) {
                      if (!paused && !ended) {
                        _sound('whoosh');
                        setState(() => dragging = true);
                      }
                    },
                    onPanUpdate: (d) => _dragUpdate(d, size),
                    onPanEnd: (_) => _dragEnd(size),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: CustomPaint(painter: _LanePainter()),
                          ),
                          Positioned(
                            left: size.width * .5 - 20,
                            top: size.height * .10 - 20,
                            child: ScaleTransition(
                              scale: pulse,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: color.withValues(alpha: .5),
                                      blurRadius: 18,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: size.width * ballPosition.dx - 16,
                            top: size.height * ballPosition.dy - 16,
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: color.withValues(alpha: .65),
                                    blurRadius: 15,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          for (int i = 0; i < 3; i++)
                            Positioned(
                              left: size.width * [.18, .5, .82][i] - 34,
                              bottom: 24,
                              child: Container(
                                width: 68,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: AppColors.gateColors[i].withValues(
                                    alpha: .17,
                                  ),
                                  border: Border.all(
                                    color: AppColors.gateColors[i],
                                    width: 2.5,
                                  ),
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                child: Center(
                                  child: Text(
                                    ['PURPLE', 'MINT', 'ORANGE'][i],
                                    style: TextStyle(
                                      color: AppColors.gateColors[i],
                                      fontSize: 9,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          if (paused)
                            Positioned.fill(
                              child: Container(
                                color: Colors.black87,
                                child: const Center(
                                  child: Text(
                                    'PAUSED',
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.muted,
                fontSize: 10,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                for (int i = 0; i < level.sequence.length; i++)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: i < ballIndex
                          ? AppColors.success
                          : (i == ballIndex ? color : AppColors.border),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _stat(String title, String value, Color color) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          color: AppColors.muted,
          fontSize: 9,
          fontWeight: FontWeight.w900,
        ),
      ),
      Text(
        value,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w900,
          fontSize: 20,
        ),
      ),
    ],
  );
}

class _LanePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;
    final xs = [.18, .5, .82];
    for (int i = 0; i < 3; i++) {
      paint.color = AppColors.gateColors[i].withValues(alpha: .32);
      final path = Path()
        ..moveTo(size.width * .5, size.height * .12)
        ..cubicTo(
          size.width * .5,
          size.height * .35,
          size.width * xs[i],
          size.height * .55,
          size.width * xs[i],
          size.height * .88,
        );
      canvas.drawPath(path, paint);
      final thin = Paint()
        ..color = AppColors.gateColors[i].withValues(alpha: .8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawPath(path, thin);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
