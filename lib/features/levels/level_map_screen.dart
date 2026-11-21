import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../gameplay/providers/progress_controller.dart';
import '../gameplay/screens/gameplay_screen.dart';
import '../../shared/widgets/game_button.dart';
import '../../shared/widgets/screen_shell.dart';

class LevelMapScreen extends StatelessWidget {
  const LevelMapScreen({super.key, required this.progress});
  final ProgressController progress;

  @override
  Widget build(BuildContext context) => ScreenShell(
    title: 'WORLD 01',
    progress: progress,
    child: Padding(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'The Color Grove',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
          ),
          const Text(
            'WORLD 01  •  THE GARDEN',
            style: TextStyle(color: AppColors.lilac, fontSize: 10),
          ),
          const SizedBox(height: 14),
          LinearProgressIndicator(
            value: (progress.completedLevels / 30).clamp(0, 1),
            color: AppColors.mint,
          ),
          const SizedBox(height: 15),
          Expanded(
            child: GridView.builder(
              itemCount: 30,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final level = index + 1;
                final open = level <= progress.unlockedLevel;
                return InkWell(
                  onTap: open
                      ? () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => GameplayScreen(
                              progress: progress,
                              level: level,
                            ),
                          ),
                        )
                      : null,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          open ? Icons.circle_outlined : Icons.lock,
                          color: open ? AppColors.lilac : AppColors.muted,
                        ),
                        Text(
                          '$level',
                          style: const TextStyle(fontWeight: FontWeight.w900),
                        ),
                        if (level <= progress.completedLevels)
                          const Icon(
                            Icons.star,
                            color: AppColors.orange,
                            size: 13,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          GameButton(
            'START LEVEL ${progress.unlockedLevel}',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => GameplayScreen(
                  progress: progress,
                  level: progress.unlockedLevel,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
