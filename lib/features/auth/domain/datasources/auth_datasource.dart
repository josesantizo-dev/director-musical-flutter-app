import 'package:director_musical_app/features/auth/domain/entities/firebase_auth.dart';

abstract class AuthDatasource {
  Future<FirebaseAuthEntity> googleLogin();
  Future<FirebaseAuthEntity> appleLogin();
}
