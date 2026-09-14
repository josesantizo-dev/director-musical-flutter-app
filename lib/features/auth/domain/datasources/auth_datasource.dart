import 'package:director_musical_app/features/auth/domain/entities/firebase_auth.dart';
import 'package:director_musical_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthDatasource {
  Future<FirebaseAuthEntity> googleLogin();
  Future<FirebaseAuthEntity> appleLogin();
  Future<UserEntity> firebaseLogin({required String firebaseToken});
}
