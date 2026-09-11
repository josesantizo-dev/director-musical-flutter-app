import 'package:director_musical_app/config/constants/environment.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:director_musical_app/config/firebase/firebase_config.dart';
import 'package:director_musical_app/config/theme/app_theme.dart';
import 'package:director_musical_app/config/router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Environment.initEnvironment();

  await FirebaseConfig.initializeFirebase();
  await GoogleSignIn.instance.initialize();

  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      title: 'Flutter Demo',
      routerConfig: router,
    );
  }
}
