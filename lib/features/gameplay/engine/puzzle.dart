import 'dart:math';

class Puzzle {
  Puzzle(int level)
    : moves = max(3, 8 - level ~/ 4),
      sequence = List.generate(
        min(6, 3 + level ~/ 3),
        (i) => Random(level * 31 + 7 + i * 13).nextInt(3),
      );
  final int moves;
  final List<int> sequence;
  final List<int> answers = [];
  int get remaining => moves - answers.length;
  bool get done => answers.length == sequence.length;
  bool get failed => remaining <= 0 && !done;
  int get correct => [
    for (var i = 0; i < answers.length; i++)
      if (answers[i] == sequence[i]) 1,
  ].length;
  int get stars => correct == sequence.length
      ? 3
      : correct >= sequence.length - 1
      ? 2
      : 1;
  void add(int color) {
    if (!done && !failed) answers.add(color);
  }

  void undo() {
    if (answers.isNotEmpty) answers.removeLast();
  }

  void reset() => answers.clear();
}
