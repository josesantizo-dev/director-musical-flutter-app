import 'package:director_musical_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: OutlinedButton.icon(
          onPressed: () => {ref.read(authProvider.notifier).logOut()},
          label: const Text('LogOut'),
          icon: const Icon(Icons.logout, size: 28),
        ),
      ),
    );
  }
}
