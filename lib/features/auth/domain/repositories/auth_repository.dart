import 'package:director_musical_app/features/auth/domain/entities/firebase_auth.dart';

abstract class AuthRepository {
  Future<FirebaseAuthEntity> googleLogin();
  Future<FirebaseAuthEntity> appleLogin();
  Future<Map<String, dynamic>> firebaseLogin({required String firebaseToken});
}
