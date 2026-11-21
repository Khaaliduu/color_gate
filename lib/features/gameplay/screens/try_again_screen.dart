import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/game_button.dart';
import '../../../shared/widgets/screen_shell.dart';
import '../providers/progress_controller.dart';
import '../../levels/level_map_screen.dart';
import 'gameplay_screen.dart';

class TryAgainScreen extends StatelessWidget {
  const TryAgainScreen({
    super.key,
    required this.progress,
    required this.level,
  });
  final ProgressController progress;
  final int level;

  @override
  Widget build(BuildContext context) => ScreenShell(
    title: 'TRY AGAIN',
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.refresh, size: 80, color: AppColors.orange),
          const Text(
            'Not quite there!',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
          ),
          const Text(
            'Every puzzle is a chance to improve.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.muted),
          ),
          const SizedBox(height: 30),
          GameButton(
            'TRY AGAIN',
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    GameplayScreen(progress: progress, level: level),
              ),
            ),
          ),
          const SizedBox(height: 10),
          GameButton(
            'LEVEL MAP',
            secondary: true,
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => LevelMapScreen(progress: progress),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
