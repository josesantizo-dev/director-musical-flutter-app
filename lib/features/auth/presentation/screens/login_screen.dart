import 'package:director_musical_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;

    ref.listen(authProvider, (previous, next) {
      if (next.authStatus == AuthStatus.authenticated) {
        context.go('/home');
      }
    });

    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,
              'Director musical',
              style: TextStyle(
                color: colors.primary,
                fontSize: size.width * 0.1,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                const Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'Continúa con',
                    style: TextStyle(color: colors.outline),
                  ),
                ),
                const Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () =>
                    ref.read(authProvider.notifier).googleAuthentication(),
                icon: const Icon(Icons.g_mobiledata, size: 28),
                label: const Text('Continuar con Google'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  // TODO: iniciar sesión con Apple
                },
                icon: const Icon(Icons.apple, size: 24),
                label: const Text('Continuar con Apple'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
