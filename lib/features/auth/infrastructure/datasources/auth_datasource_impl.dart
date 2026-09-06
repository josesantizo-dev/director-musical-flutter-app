import 'package:director_musical_app/features/auth/domain/datasources/auth_datasource.dart';
import 'package:director_musical_app/features/auth/domain/entities/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthDatasourceImpl extends AuthDatasource {
  @override
  Future<FirebaseAuthEntity> appleLogin() async {
    throw UnimplementedError();
  }

  @override
  Future<FirebaseAuthEntity> googleLogin() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn.instance
          .authenticate();

      // 2. Obtener los detalles dxe autenticación de la solicitud
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      // 3. Crear una nueva credencial para Firebase
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // 4. Una vez iniciada la sesión, devolver el UserCredential
      final UserCredential authSession = await FirebaseAuth.instance
          .signInWithCredential(
            credential,
          );

      return FirebaseAuthEntity(
        token: authSession.credential?.accessToken ?? '',
        deviceInfo: '',
      );
    } catch (e) {
      throw UnimplementedError();
    }
  }
}
