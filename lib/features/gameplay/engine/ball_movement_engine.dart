import '../models/game_level.dart';
import '../models/game_path.dart';
import 'path_controller.dart';

class BallMovementEngine {
  const BallMovementEngine();
  final PathController _pathController = const PathController();

  GamePath routeFor(GameLevel level, int gateIndex) =>
      _pathController.pathForGate(level, gateIndex);
}
