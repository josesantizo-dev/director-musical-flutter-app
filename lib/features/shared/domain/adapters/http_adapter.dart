abstract class HttpAdapter {
  Future<T> get<T>({
    required String path,
    Map<String, dynamic>? queryParams,
    required String token,
  });
  Future<T> post<T>({
    required String path,
    Map<String, dynamic>? body,
    String? token,
  });
}
