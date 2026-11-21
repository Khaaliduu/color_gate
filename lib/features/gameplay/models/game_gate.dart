import 'package:flutter/material.dart';

class GameGate {
  const GameGate({
    required this.id,
    required this.colorIndex,
    required this.label,
  });
  final int id;
  final int colorIndex;
  final String label;

  Color get color => const [
    Color(0xFF9B7CFF),
    Color(0xFF58E0C1),
    Color(0xFFFFA45B),
  ][colorIndex.clamp(0, 2).toInt()];
}
