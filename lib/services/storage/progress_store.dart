import 'package:shared_preferences/shared_preferences.dart';

class ProgressStore {
  static const _coinsKey = 'cg_coins';
  static const _unlockedKey = 'cg_unlocked';
  static const _completedKey = 'cg_completed';
  static const _starsKey = 'cg_stars';
  static const _hintsKey = 'cg_hints';
  static const _soundKey = 'cg_sound';
  static const _vibrationKey = 'cg_vibration';
  static const _motionKey = 'cg_reduce_motion';
  static const _themeKey = 'cg_theme';
  static const _ownedKey = 'cg_owned';

  Future<Map<String, Object>> load() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'coins': prefs.getInt(_coinsKey) ?? 240,
      'unlocked': prefs.getInt(_unlockedKey) ?? 1,
      'completed': prefs.getInt(_completedKey) ?? 0,
      'stars': prefs.getInt(_starsKey) ?? 0,
      'hints': prefs.getInt(_hintsKey) ?? 3,
      'sound': prefs.getBool(_soundKey) ?? true,
      'vibration': prefs.getBool(_vibrationKey) ?? true,
      'reduceMotion': prefs.getBool(_motionKey) ?? false,
      'theme': prefs.getString(_themeKey) ?? 'VIOLET DREAM',
      'owned': prefs.getStringList(_ownedKey) ?? <String>['VIOLET DREAM'],
    };
  }

  Future<void> save(Map<String, Object> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_coinsKey, data['coins'] as int);
    await prefs.setInt(_unlockedKey, data['unlocked'] as int);
    await prefs.setInt(_completedKey, data['completed'] as int);
    await prefs.setInt(_starsKey, data['stars'] as int);
    await prefs.setInt(_hintsKey, data['hints'] as int);
    await prefs.setBool(_soundKey, data['sound'] as bool);
    await prefs.setBool(_vibrationKey, data['vibration'] as bool);
    await prefs.setBool(_motionKey, data['reduceMotion'] as bool);
    await prefs.setString(_themeKey, data['theme'] as String);
    await prefs.setStringList(
      _ownedKey,
      (data['owned'] as List).cast<String>(),
    );
  }
}
