import 'package:director_musical_app/features/auth/presentation/screens/login_screen.dart';
import 'package:director_musical_app/features/home/presentation/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
  ],
);
