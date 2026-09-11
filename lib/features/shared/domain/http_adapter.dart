abstract class HttpAdapter {
  Future<Map<String, dynamic>> get({
    required String path,
    Map<String, dynamic>? queryParams,
    required String token,
  });
  Future<Map<String, dynamic>> post({
    required String path,
    Map<String, dynamic>? body,
    String? token,
  });
}
