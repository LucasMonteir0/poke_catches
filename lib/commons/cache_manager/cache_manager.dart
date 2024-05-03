abstract class CacheManager {
  Future<void> init();

  Future<void> setMap(String key, Map<String, dynamic> value);

  Future<void> setInt(String key, int value);

  Future<void> setBool(String key, bool value);

  Future<void> setDouble(String key, double value);

  Future<void> setString(String key, String value);

  Future<void> setStringList(String key, List<String> value);

  Map<String, dynamic>? getMap(String key);

  int? getInt(String key);

  bool? getBool(String key);

  double? getDouble(String key);

  String? getString(String key);

  List<String>? getStringList(String key);

  Future<void> remove(String key);
}
