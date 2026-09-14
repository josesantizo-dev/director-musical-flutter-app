abstract class LocalStorageAdapter {
  Future<void> setValue<T>(String key, T value);
  Future<T?> getValue<T>(String key);
  Future<bool> removeKey(String key);
}
