import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../features/gameplay/providers/progress_controller.dart';
import '../../features/home/home_screen.dart';
import '../../shared/widgets/game_button.dart';
import '../../shared/widgets/game_logo.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key, required this.progress});
  final ProgressController progress;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Row(
              children: [
                GameLogo(size: 46),
                SizedBox(width: 10),
                Text(
                  'COLOR GATE',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ],
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(
                      3,
                      (i) => Container(
                        margin: const EdgeInsets.all(8),
                        width: 52,
                        height: [120.0, 90.0, 145.0][i],
                        decoration: BoxDecoration(
                          color: AppColors.gateColors[i],
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: AppColors.gateColors
                        .map(
                          (c) => Container(
                            margin: const EdgeInsets.all(10),
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: c,
                              shape: BoxShape.circle,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Your next favorite brain break',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 10),
            const Text(
              'Guide every color through the matching gate. Easy to start, satisfying to master.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.muted),
            ),
            const Spacer(),
            GameButton(
              "LET'S PLAY",
              onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => HomeScreen(progress: progress),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'NO WIFI NEEDED  •  JUST YOU & THE PUZZLE',
              style: TextStyle(fontSize: 9, color: AppColors.muted),
            ),
          ],
        ),
      ),
    ),
  );
}
