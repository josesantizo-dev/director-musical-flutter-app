import 'package:director_musical_app/features/auth/domain/datasources/auth_datasource.dart';
import 'package:director_musical_app/features/auth/domain/entities/firebase_auth.dart';
import 'package:director_musical_app/features/auth/domain/entities/user_entity.dart';
import 'package:director_musical_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource _dataSource;

  AuthRepositoryImpl({required this._dataSource});

  @override
  Future<FirebaseAuthEntity> appleLogin() {
    return _dataSource.appleLogin();
  }

  @override
  Future<FirebaseAuthEntity> googleLogin() {
    return _dataSource.googleLogin();
  }

  @override
  Future<UserEntity> firebaseLogin({
    required String firebaseToken,
  }) async {
    final res = await _dataSource.firebaseLogin(firebaseToken: firebaseToken);
    return res;
  }
}
