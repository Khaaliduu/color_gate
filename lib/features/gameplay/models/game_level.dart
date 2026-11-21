import 'package:flutter/material.dart';

import 'game_ball.dart';
import 'game_gate.dart';
import 'game_path.dart';
import 'level_objective.dart';

class GameLevel {
  const GameLevel({
    required this.number,
    required this.sequence,
    required this.moves,
    required this.balls,
    required this.gates,
    required this.paths,
    required this.objective,
  });

  final int number;
  final List<int> sequence;
  final int moves;
  final List<GameBall> balls;
  final List<GameGate> gates;
  final List<GamePath> paths;
  final LevelObjective objective;

  factory GameLevel.create(int number) {
    final safeNumber = number < 1 ? 1 : number;

    const patterns = <List<int>>[
      [0, 1, 2],
      [1, 0, 2, 1],
      [2, 1, 0, 2, 1],
      [0, 2, 1, 0, 2, 1],
      [2, 0, 1, 2, 0, 1, 2],
    ];

    final pattern = patterns[(safeNumber - 1) % patterns.length];
    final extraBalls = (safeNumber - 1) ~/ patterns.length;
    final sequence = List<int>.generate(
      pattern.length + extraBalls,
      (index) => pattern[index % pattern.length],
    );

    final balls = List<GameBall>.generate(
      sequence.length,
      (index) => GameBall(id: index, colorIndex: sequence[index]),
    );

    const gates = <GameGate>[
      GameGate(id: 0, colorIndex: 0, label: 'PURPLE'),
      GameGate(id: 1, colorIndex: 1, label: 'MINT'),
      GameGate(id: 2, colorIndex: 2, label: 'ORANGE'),
    ];

    const paths = <GamePath>[
      GamePath(
        gateIndex: 0,
        points: [
          Offset(.50, .08),
          Offset(.50, .27),
          Offset(.35, .43),
          Offset(.18, .72),
          Offset(.18, .92),
        ],
      ),
      GamePath(
        gateIndex: 1,
        points: [
          Offset(.50, .08),
          Offset(.50, .27),
          Offset(.50, .45),
          Offset(.50, .72),
          Offset(.50, .92),
        ],
      ),
      GamePath(
        gateIndex: 2,
        points: [
          Offset(.50, .08),
          Offset(.50, .27),
          Offset(.65, .43),
          Offset(.82, .72),
          Offset(.82, .92),
        ],
      ),
    ];

    return GameLevel(
      number: safeNumber,
      sequence: sequence,
      moves: sequence.length + 2,
      balls: balls,
      gates: gates,
      paths: paths,
      objective: LevelObjective(
        description: 'Guide every ball into the matching color zone.',
        targetBalls: sequence.length,
      ),
    );
  }
}
