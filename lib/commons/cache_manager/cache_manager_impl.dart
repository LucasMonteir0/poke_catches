import 'dart:convert';

import 'package:poke_caches/commons/cache_manager/cache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheManagerImpl implements CacheManager {
  static final CacheManagerImpl _singleton = CacheManagerImpl._internal();

  CacheManagerImpl._internal();

  static CacheManagerImpl get instance => _singleton;

  late SharedPreferences _prefs;

  SharedPreferences get prefs => _prefs;

  @override
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Write data
  @override
  Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  @override
  Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  @override
  Future<void> setDouble(String key, double value) async {
    await _prefs.setDouble(key, value);
  }

  @override
  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  @override
  Future<void> setStringList(String key, List<String> value) async {
    await _prefs.setStringList(key, value);
  }

  @override
  Future<void> setMap(String key, Map<String, dynamic> value) async {
    final String json = jsonEncode(value);
    await _prefs.setString(key, json);
  }

  // Read data
  @override
  Map<String, dynamic>? getMap(String key) {
    final String? json = _prefs.getString(key);
    return json != null ? jsonDecode(json) : null;
  }

  @override
  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  @override
  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  @override
  double? getDouble(String key) {
    return _prefs.getDouble(key);
  }

  @override
  String? getString(String key) {
    return _prefs.getString(key);
  }

  @override
  List<String>? getStringList(String key) {
    return _prefs.getStringList(key);
  }

  // Remove an entry
  @override
  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  Future<bool> clear() async {
    return await _prefs.clear();
  }
}