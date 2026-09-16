import 'package:director_musical_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:director_musical_app/features/auth/presentation/screens/check_auth_status_screen.dart';
import 'package:director_musical_app/features/auth/presentation/screens/login_screen.dart';
import 'package:director_musical_app/features/home/presentation/screens/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    initialLocation: '/loading',
    routes: [
      GoRoute(
        path: '/loading',
        builder: (context, state) => CheckAuthStatusScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
    ],
    redirect: (context, state) {
      final authStatus = ref.read(authProvider).authStatus;
      final destination = state.matchedLocation;

      if (authStatus == AuthStatus.checking) {
        return destination == '/loading' ? null : '/loading';
      }

      if (authStatus == AuthStatus.authenticated) {
        if (destination == '/' || destination == '/loading') return '/home';
        return null;
      }

      if (authStatus == AuthStatus.unauthenticated) {
        if (destination != '/' || destination == '/loading') return '/';
        return null;
      }

      return null;
    },
  );

  ref.listen(authProvider, (previous, next) => router.refresh());
  ref.onDispose(router.dispose);

  return router;
});
