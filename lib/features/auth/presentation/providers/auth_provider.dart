import 'package:director_musical_app/features/auth/domain/entities/firebase_auth.dart';
import 'package:director_musical_app/features/auth/infrastructure/repositories/auth_repository_impl.dart';
import 'package:director_musical_app/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:director_musical_app/features/shared/domain/custom_errors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AuthStatus { checking, authenticated, unauthenticated }

final authProvider = NotifierProvider.autoDispose<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

class AuthNotifier extends Notifier<AuthState> {
  late final AuthRepositoryImpl authRepository;

  @override
  AuthState build() {
    authRepository = ref.read(authRepositoryProvider);
    return AuthState();
  }

  Future<void> googleAuthentication() async {
    try {
      final FirebaseAuthEntity firebaseSession = await authRepository
          .googleLogin();

      await authRepository.firebaseLogin(
        firebaseToken: firebaseSession.token,
      );

      if (firebaseSession.token.isNotEmpty) {
        state = state.copyWith(authStatus: AuthStatus.authenticated);
      }
    } on InvalidCredentials {
      state = state.copyWith(
        authStatus: AuthStatus.unauthenticated,
        errorMessage: 'Token inválido',
      );
    } on ConnectionError {
      state = state.copyWith(
        authStatus: AuthStatus.unauthenticated,
        errorMessage: 'Revisa tu conexión a internet',
      );
    } on GoogleLoginCancelled {
      state = state.copyWith(
        authStatus: AuthStatus.unauthenticated,
        errorMessage: 'Se cancelo el proceso',
      );
    } on CustomError catch (e) {
      state = state.copyWith(
        authStatus: AuthStatus.unauthenticated,
        errorMessage: e.message,
      );
    } catch (e) {
      state = state.copyWith(
        authStatus: AuthStatus.unauthenticated,
        errorMessage: 'Error inesperado',
      );
    }
  }
}

class AuthState {
  final AuthStatus authStatus;
  final String errorMessage;

  AuthState({
    this.authStatus = AuthStatus.unauthenticated,
    this.errorMessage = '',
  });

  AuthState copyWith({AuthStatus? authStatus, String? errorMessage}) =>
      AuthState(
        authStatus: authStatus ?? this.authStatus,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
