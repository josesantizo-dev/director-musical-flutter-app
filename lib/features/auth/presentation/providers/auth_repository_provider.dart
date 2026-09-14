import 'package:director_musical_app/config/constants/environment.dart';
import 'package:director_musical_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:director_musical_app/features/auth/infrastructure/datasources/auth_datasource_impl.dart';
import 'package:director_musical_app/features/auth/infrastructure/repositories/auth_repository_impl.dart';
import 'package:director_musical_app/features/shared/domain/adapters/http_adapter.dart';
import 'package:director_musical_app/features/shared/infrastructure/adapters/dio_adapter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final HttpAdapter httpAdapter = DioAdapter(
    baseUrl: '${Environment.apiUrl}/auth',
  );

  return AuthRepositoryImpl(
    dataSource: AuthDatasourceImpl(httpAdapter: httpAdapter),
  );
});
