import 'package:flutter/foundation.dart';
import '../../../services/storage/progress_store.dart';

class ProgressController extends ChangeNotifier {
  ProgressController({ProgressStore? store})
    : _store = store ?? ProgressStore();

  final ProgressStore _store;
  int coins = 240;
  int unlockedLevel = 1;
  int completedLevels = 0;
  int totalStars = 0;
  int hints = 3;
  bool soundEnabled = true;
  bool vibrationEnabled = true;
  bool reduceMotion = false;
  String selectedTheme = 'VIOLET DREAM';
  List<String> ownedThemes = <String>['VIOLET DREAM'];

  Future<void> load() async {
    final data = await _store.load();
    coins = data['coins'] as int;
    unlockedLevel = data['unlocked'] as int;
    completedLevels = data['completed'] as int;
    totalStars = data['stars'] as int;
    hints = data['hints'] as int;
    soundEnabled = data['sound'] as bool;
    vibrationEnabled = data['vibration'] as bool;
    reduceMotion = data['reduceMotion'] as bool;
    selectedTheme = data['theme'] as String;
    ownedThemes = (data['owned'] as List).cast<String>();
    notifyListeners();
  }

  Future<void> _save() async {
    await _store.save({
      'coins': coins,
      'unlocked': unlockedLevel,
      'completed': completedLevels,
      'stars': totalStars,
      'hints': hints,
      'sound': soundEnabled,
      'vibration': vibrationEnabled,
      'reduceMotion': reduceMotion,
      'theme': selectedTheme,
      'owned': ownedThemes,
    });
    notifyListeners();
  }

  Future<void> completeLevel(int level, int stars) async {
    if (level > completedLevels) completedLevels = level;
    if (unlockedLevel <= level) unlockedLevel = level + 1;
    totalStars += stars;
    coins += 25 + stars * 5;
    await _save();
  }

  Future<bool> purchaseTheme(String name, int cost) async {
    if (ownedThemes.contains(name)) {
      selectedTheme = name;
      await _save();
      return true;
    }
    if (coins < cost) return false;
    coins -= cost;
    ownedThemes.add(name);
    selectedTheme = name;
    await _save();
    return true;
  }

  Future<void> setSound(bool value) async {
    soundEnabled = value;
    await _save();
  }

  Future<void> setVibration(bool value) async {
    vibrationEnabled = value;
    await _save();
  }

  Future<void> setReduceMotion(bool value) async {
    reduceMotion = value;
    await _save();
  }

  Future<void> useHint() async {
    if (hints > 0) {
      hints--;
      await _save();
    }
  }
}
