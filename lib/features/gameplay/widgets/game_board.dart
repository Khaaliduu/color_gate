import 'package:flutter/material.dart';
import '../models/game_ball.dart';
import '../models/game_level.dart';
import '../models/game_path.dart';
import 'game_ball_widget.dart';
import 'game_path_painter.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({
    super.key,
    required this.level,
    required this.ball,
    required this.progress,
    this.activePath,
  });
  final GameLevel level;
  final GameBall ball;
  final double progress;
  final GamePath? activePath;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    constraints: const BoxConstraints(minHeight: 300),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFF17172A),
      borderRadius: BorderRadius.circular(26),
      border: Border.all(color: const Color(0xFF34344D)),
    ),
    child: AspectRatio(
      aspectRatio: .82,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = Size(constraints.maxWidth, constraints.maxHeight);
          final point = activePath?.pointAt(progress) ?? const Offset(.5, .08);
          const exitColors = [
            Color(0xFF9B7CFF),
            Color(0xFF58E0C1),
            Color(0xFFFFA45B),
          ];
          const exitX = [.18, .50, .82];
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                child: CustomPaint(painter: GamePathPainter(level: level)),
              ),
              Positioned(
                left: size.width * .5 - 6,
                top: size.height * .27 - 6,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                left: size.width * point.dx - 15,
                top: size.height * point.dy - 15,
                child: GameBallWidget(ball: ball, size: 30),
              ),
              for (var i = 0; i < 3; i++)
                Positioned(
                  left: size.width * exitX[i] - 20,
                  top: size.height * .91 - 12,
                  child: Container(
                    width: 40,
                    height: 24,
                    decoration: BoxDecoration(
                      color: exitColors[i].withValues(alpha: .22),
                      border: Border.all(color: exitColors[i], width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    ),
  );
}
