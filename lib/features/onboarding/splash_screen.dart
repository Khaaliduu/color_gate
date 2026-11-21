import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../features/gameplay/providers/progress_controller.dart';
import '../../shared/widgets/game_logo.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final progress = ProgressController();

  @override
  void initState() {
    super.initState();
    _start();
  }

  Future<void> _start() async {
    await progress.load();
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => WelcomeScreen(progress: progress)),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          SizedBox(height: 20),
          Column(
            children: [
              GameLogo(),
              SizedBox(height: 16),
              Text(
                'COLOR GATE',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 8),
              Text(
                'THINK  •  MATCH  •  ESCAPE',
                style: TextStyle(color: AppColors.lilac, fontSize: 10),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 38),
            child: Column(
              children: [
                Text(
                  'A little puzzle. A big brain break.',
                  style: TextStyle(color: AppColors.muted),
                ),
                SizedBox(height: 18),
                CircularProgressIndicator(
                  color: AppColors.mint,
                  strokeWidth: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
