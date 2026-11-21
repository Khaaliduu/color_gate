import 'package:flutter/material.dart';

class GamePath {
  const GamePath({required this.gateIndex, required this.points});
  final int gateIndex;
  final List<Offset> points;

  Offset pointAt(double progress) {
    if (points.isEmpty) return Offset.zero;
    if (points.length == 1) return points.first;
    final value = progress.clamp(0.0, 1.0).toDouble() * (points.length - 1);
    final segment = value.floor().clamp(0, points.length - 2).toInt();
    return Offset.lerp(points[segment], points[segment + 1], value - segment)!;
  }
}
