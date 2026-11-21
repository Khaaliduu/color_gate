import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Progress extends ChangeNotifier {
  int coins = 240,
      unlocked = 1,
      completed = 0,
      stars = 0,
      streak = 1,
      hints = 3;
  bool sound = true, vibration = true, reminders = false, reduceMotion = false;
  String theme = 'VIOLET DREAM';
  List<String> owned = ['VIOLET DREAM'];
  Future<void> load() async {
    final p = await SharedPreferences.getInstance();
    coins = p.getInt('coins') ?? 240;
    unlocked = p.getInt('unlocked') ?? 1;
    completed = p.getInt('completed') ?? 0;
    stars = p.getInt('stars') ?? 0;
    streak = p.getInt('streak') ?? 1;
    hints = p.getInt('hints') ?? 3;
    theme = p.getString('theme') ?? 'VIOLET DREAM';
    owned = p.getStringList('owned') ?? ['VIOLET DREAM'];
    sound = p.getBool('sound') ?? true;
    vibration = p.getBool('vibration') ?? true;
    reminders = p.getBool('reminders') ?? false;
    reduceMotion = p.getBool('reduceMotion') ?? false;
    notifyListeners();
  }

  Future<void> save() async {
    final p = await SharedPreferences.getInstance();
    await p.setInt('coins', coins);
    await p.setInt('unlocked', unlocked);
    await p.setInt('completed', completed);
    await p.setInt('stars', stars);
    await p.setInt('streak', streak);
    await p.setInt('hints', hints);
    await p.setString('theme', theme);
    await p.setStringList('owned', owned);
    await p.setBool('sound', sound);
    await p.setBool('vibration', vibration);
    await p.setBool('reminders', reminders);
    await p.setBool('reduceMotion', reduceMotion);
    notifyListeners();
  }

  void win(int level, int earnedStars) {
    if (completed < level) completed = level;
    if (unlocked < level + 1) unlocked = level + 1;
    stars += earnedStars;
    coins += 25 + earnedStars * 5;
    save();
  }

  bool buy(String name, int cost) {
    if (owned.contains(name)) {
      theme = name;
      save();
      return true;
    }
    if (coins < cost) return false;
    coins -= cost;
    owned.add(name);
    theme = name;
    save();
    return true;
  }
}
