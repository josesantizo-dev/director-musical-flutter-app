import 'package:director_musical_app/features/auth/infrastructure/datasources/auth_datasource_impl.dart';
import 'package:director_musical_app/features/auth/infrastructure/repositories/auth_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepositoryImpl>((ref) {
  return AuthRepositoryImpl(dataSource: AuthDatasourceImpl());
});
