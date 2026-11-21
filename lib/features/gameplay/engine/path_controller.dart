import '../models/game_level.dart';
import '../models/game_path.dart';

class PathController {
  const PathController();

  GamePath pathForGate(GameLevel level, int gateIndex) {
    return level.paths.firstWhere(
      (path) => path.gateIndex == gateIndex,
      orElse: () => throw RangeError('Unknown gate index: $gateIndex'),
    );
  }
}
