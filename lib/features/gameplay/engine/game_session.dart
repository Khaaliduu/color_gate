import '../models/game_level.dart';
import 'gate_controller.dart';

class GameSession {
  GameSession(this.level) : _answers = <int>[];

  final GameLevel level;
  final List<int> _answers;
  final GateController _gateController = const GateController();

  List<int> get answers => List.unmodifiable(_answers);
  int get currentBallIndex => _answers.length;
  int get movesLeft => level.moves - _answers.length;

  bool get isComplete =>
      _answers.length == level.sequence.length &&
      _answers.asMap().entries.every(
        (entry) => entry.value == level.sequence[entry.key],
      );

  bool get isFailed =>
      _answers.isNotEmpty &&
      _answers.last != level.sequence[_answers.length - 1];

  bool get canPlay => !isComplete && !isFailed && movesLeft > 0;

  bool chooseGate(int gateIndex) {
    if (!canPlay || gateIndex < 0 || gateIndex > 2) return false;
    _answers.add(gateIndex);
    return _gateController.isMatching(level, _answers.length - 1, gateIndex);
  }

  void undo() {
    if (_answers.isNotEmpty && !isComplete) _answers.removeLast();
  }

  void reset() => _answers.clear();

  int get correctCount => _answers
      .asMap()
      .entries
      .where((entry) => entry.value == level.sequence[entry.key])
      .length;

  int get earnedStars {
    if (!isComplete) return 0;
    if (movesLeft >= 2) return 3;
    if (movesLeft >= 1) return 2;
    return 1;
  }
}
