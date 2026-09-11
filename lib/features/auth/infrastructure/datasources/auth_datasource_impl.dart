import 'package:dio/dio.dart';
import 'package:director_musical_app/config/constants/environment.dart';
import 'package:director_musical_app/features/auth/domain/datasources/auth_datasource.dart';
import 'package:director_musical_app/features/auth/domain/entities/firebase_auth.dart';
import 'package:director_musical_app/features/shared/domain/custom_errors.dart';
import 'package:director_musical_app/features/shared/infrastructure/dio_adapter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthDatasourceImpl extends AuthDatasource {
  @override
  Future<FirebaseAuthEntity> appleLogin() async {
    throw UnimplementedError();
  }

  final DioAdapter _dioAdapter;

  AuthDatasourceImpl()
    : _dioAdapter = DioAdapter(baseUrl: '${Environment.apiUrl}/auth');

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

      final String? idToken = await authSession.user?.getIdToken();

      return FirebaseAuthEntity(
        token: idToken ?? '',
        deviceInfo: '',
      );
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        throw GoogleLoginCancelled();
      }
      throw CustomError('Error al iniciar sessión con google: ${e.code}');
    } on FirebaseAuthException catch (e) {
      throw CustomError('Error de autenticación con firebase: ${e.code}');
    } catch (e) {
      throw CustomError('Error de autenticación con firebase o google');
    }
  }

  @override
  Future<Map<String, dynamic>> firebaseLogin({
    required String firebaseToken,
  }) async {
    try {
      final res = await _dioAdapter.post(
        path: '/firebase-login',
        body: {'token': firebaseToken},
      );

      return res;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw InvalidCredentials();
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw ConnectionError();
      }

      throw CustomError('Error inesperado del servidor');
    }
  }
}
