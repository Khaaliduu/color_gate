import 'package:flutter/material.dart';

class GameBall {
  const GameBall({required this.id, required this.colorIndex});
  final int id;
  final int colorIndex;

  Color get color => const [
    Color(0xFF9B7CFF),
    Color(0xFF58E0C1),
    Color(0xFFFFA45B),
  ][colorIndex.clamp(0, 2).toInt()];
}
