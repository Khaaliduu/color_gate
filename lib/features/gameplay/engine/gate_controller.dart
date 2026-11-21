import '../models/game_gate.dart';
import '../models/game_level.dart';

class GateController {
  const GateController();

  GameGate gateForIndex(GameLevel level, int gateIndex) {
    return level.gates.firstWhere(
      (gate) => gate.id == gateIndex,
      orElse: () => throw RangeError('Unknown gate index: $gateIndex'),
    );
  }

  bool isMatching(GameLevel level, int ballIndex, int gateIndex) {
    if (ballIndex < 0 || ballIndex >= level.sequence.length) return false;
    return level.sequence[ballIndex] ==
        gateForIndex(level, gateIndex).colorIndex;
  }
}
