import 'package:director_musical_app/features/shared/domain/http_adapter.dart';
import 'package:dio/dio.dart';

class DioAdapter implements HttpAdapter {
  late final Dio _dio;
  String? baseUrl;

  DioAdapter({this.baseUrl})
    : _dio = Dio(BaseOptions(baseUrl: baseUrl ?? '', headers: {}));

  @override
  Future<Map<String, dynamic>> get({
    required String path,
    Map<String, dynamic>? queryParams,
    required String token,
  }) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> post({
    required String path,
    Map<String, dynamic>? body,
    String? token,
  }) async {
    final res = await _dio.post(path, data: body);
    return res.data;
  }
}
