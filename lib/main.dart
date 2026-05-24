import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'views/splash/splash_page.dart';
import 'utils/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const RotaUniApp());
}

class RotaUniApp extends StatelessWidget {
  const RotaUniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RotaUni',

      // Apenas UM tema (sem dark mode)
      theme: AppThemes.lightTheme,

      home: const SplashPage(),
    );
  }
}