import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/game_button.dart';
import '../../../shared/widgets/screen_shell.dart';
import '../providers/progress_controller.dart';
import 'gameplay_screen.dart';

class DailyChallengeScreen extends StatelessWidget {
  const DailyChallengeScreen({super.key, required this.progress});
  final ProgressController progress;

  @override
  Widget build(BuildContext context) => ScreenShell(
    title: 'DAILY CHALLENGE',
    progress: progress,
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.calendar_month, size: 76, color: AppColors.mint),
          const Text(
            'A fresh puzzle awaits.',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900),
          ),
          const Text(
            'Try a bonus level and keep practicing.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.muted),
          ),
          const SizedBox(height: 25),
          GameButton(
            'PLAY DAILY PUZZLE',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => GameplayScreen(
                  progress: progress,
                  level: progress.unlockedLevel + 2,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
