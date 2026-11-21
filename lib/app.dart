import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/onboarding/splash_screen.dart';

class ColorGateApp extends StatelessWidget {
  const ColorGateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COLOR GATE',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const SplashScreen(),
    );
  }
}
