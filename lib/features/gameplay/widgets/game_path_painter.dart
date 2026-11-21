import 'package:flutter/material.dart';
import '../models/game_level.dart';

class GamePathPainter extends CustomPainter {
  const GamePathPainter({required this.level});
  final GameLevel level;

  @override
  void paint(Canvas canvas, Size size) {
    const colors = [Color(0xFF9B7CFF), Color(0xFF58E0C1), Color(0xFFFFA45B)];
    for (final route in level.paths) {
      if (route.points.isEmpty) continue;
      final path = Path();
      final first = route.points.first;
      path.moveTo(first.dx * size.width, first.dy * size.height);
      for (final point in route.points.skip(1)) {
        path.lineTo(point.dx * size.width, point.dy * size.height);
      }
      canvas.drawPath(
        path,
        Paint()
          ..color = colors[route.gateIndex].withValues(alpha: .42)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 7
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round,
      );
    }
    canvas.drawCircle(
      Offset(size.width * .5, size.height * .27),
      12,
      Paint()
        ..color = Colors.white.withValues(alpha: .65)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
  }

  @override
  bool shouldRepaint(covariant GamePathPainter oldDelegate) =>
      oldDelegate.level != level;
}
