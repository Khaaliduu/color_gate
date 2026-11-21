import 'package:flutter/material.dart';
import '../models/game_ball.dart';

class GameBallWidget extends StatelessWidget {
  const GameBallWidget({super.key, required this.ball, this.size = 28});
  final GameBall ball;
  final double size;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: ball.color,
      boxShadow: [
        BoxShadow(
          color: ball.color.withValues(alpha: .55),
          blurRadius: 18,
          spreadRadius: 2,
        ),
      ],
      border: Border.all(color: Colors.white.withValues(alpha: .8), width: 2),
    ),
  );
}
