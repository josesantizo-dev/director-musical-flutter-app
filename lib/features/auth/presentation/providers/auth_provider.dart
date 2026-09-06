import 'package:director_musical_app/features/auth/domain/entities/firebase_auth.dart';
import 'package:director_musical_app/features/auth/infrastructure/repositories/auth_repository_impl.dart';
import 'package:director_musical_app/features/auth/presentation/providers/auth_repository_provider.dart';
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

      if (firebaseSession.token.isNotEmpty) {
        state = state.copyWith(authStatus: AuthStatus.authenticated);
      }
    } catch (e) {}
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
