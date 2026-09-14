import 'package:shared_preferences/shared_preferences.dart';

import 'package:director_musical_app/features/shared/domain/adapters/local_storage_adapter.dart';

class LocalStorageImpl extends LocalStorageAdapter {
  Future<SharedPreferences> getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<T?> getValue<T>(String key) async {
    final prefs = await getSharedPreferences();

    switch (T) {
      case int:
        return prefs.getInt(key) as T?;
      case String:
        return prefs.getString(key) as T?;
      default:
        throw UnimplementedError();
    }
  }

  @override
  Future<bool> removeKey(String key) async {
    final prefs = await getSharedPreferences();
    return await prefs.remove(key);
  }

  @override
  Future<void> setValue<T>(String key, T value) async {
    final prefs = await getSharedPreferences();

    switch (T) {
      case int:
        await prefs.setInt(key, value as int);
        break;
      case String:
        await prefs.setString(key, value as String);
        break;
      default:
        throw UnimplementedError();
    }
  }
}
