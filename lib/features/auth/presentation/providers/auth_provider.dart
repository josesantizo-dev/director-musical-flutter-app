import 'package:director_musical_app/features/auth/domain/entities/firebase_auth.dart';
import 'package:director_musical_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:director_musical_app/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:director_musical_app/features/shared/domain/adapters/local_storage_adapter.dart';
import 'package:director_musical_app/features/shared/domain/custom_errors.dart';
import 'package:director_musical_app/features/shared/presentation/providers/local_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AuthStatus { checking, authenticated, unauthenticated }

final authProvider = NotifierProvider.autoDispose<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

class AuthNotifier extends Notifier<AuthState> {
  late final AuthRepository authRepository;
  late final LocalStorageAdapter _localStorageAdapter;

  @override
  AuthState build() {
    authRepository = ref.read(authRepositoryProvider);
    _localStorageAdapter = ref.read(localStorageProvider);
    checkStatus();
    return AuthState();
  }

  void checkStatus() async {
    try {
      final accessToken = await _localStorageAdapter.getValue<String>(
        'accessToken',
      );
      if (accessToken != null) {
        state = state.copyWith(authStatus: AuthStatus.authenticated);
      } else {
        state = state.copyWith(authStatus: AuthStatus.unauthenticated);
      }
    } catch (e) {}
  }

  Future<void> googleAuthentication() async {
    try {
      final FirebaseAuthEntity firebaseSession = await authRepository
          .googleLogin();

      final res = await authRepository.firebaseLogin(
        firebaseToken: firebaseSession.token,
      );

      _localStorageAdapter.setValue<String>('accessToken', res.accessToken);
      _localStorageAdapter.setValue<String>('refreshToken', res.refreshToken);

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
