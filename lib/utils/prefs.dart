import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:take_home_assessment/utils/setup_locator.dart';

abstract class Prefs {
  static SharedPreferences get _prefs => getIt<SharedPreferences>();

  static String getString(String key) => _prefs.getString(key) ?? '';

  static int getInt(String key) => _prefs.getInt(key) ?? -1;

  static bool getBool(String key) => _prefs.getBool(key) ?? false;

  static Future<void> setString(String key, String value) =>
      _prefs.setString(key, value);

  static Future<void> setInt(String key, int value) =>
      _prefs.setInt(key, value);

  // ignore: avoid_positional_boolean_parameters
  static Future<void> setBool(String key, bool value) =>
      _prefs.setBool(key, value);

  /// clear the share preferences
  static Future<void> clear() => _prefs.clear();

  static Map<String, dynamic> getMap(String key) {
    final data = getString(key);
    return data.isEmpty ? {} : jsonDecode(data) as Map<String, dynamic>;
  }

  static Future<void> setMap(String key, Map<String, dynamic> map) =>
      setString(key, jsonEncode(map));

  static Future<void> setListOfString(String key, List<String> list) =>
      setString(key, list.join(','));

  static List<String> getListOfString(String key) {
    final data = getString(key);
    return data.isEmpty ? [] : data.split(',');
  }
}
