import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/game_button.dart';
import '../../../shared/widgets/screen_shell.dart';
import '../providers/progress_controller.dart';
import '../../levels/level_map_screen.dart';
import 'gameplay_screen.dart';

class LevelCompleteScreen extends StatefulWidget {
  const LevelCompleteScreen({
    super.key,
    required this.progress,
    required this.level,
    required this.stars,
  });
  final ProgressController progress;
  final int level;
  final int stars;

  @override
  State<LevelCompleteScreen> createState() => _LevelCompleteScreenState();
}

class _LevelCompleteScreenState extends State<LevelCompleteScreen> {
  @override
  void initState() {
    super.initState();
    widget.progress.completeLevel(widget.level, widget.stars);
  }

  @override
  Widget build(BuildContext context) => ScreenShell(
    title: 'LEVEL CLEARED',
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.emoji_events, size: 88, color: AppColors.orange),
          const SizedBox(height: 12),
          const Text(
            'Brilliantly done!',
            style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900),
          ),
          const Text(
            'You found the perfect path.',
            style: TextStyle(color: AppColors.muted),
          ),
          const SizedBox(height: 20),
          Text('⭐' * widget.stars, style: const TextStyle(fontSize: 34)),
          Text(
            '+${25 + widget.stars * 5} COINS',
            style: const TextStyle(
              color: AppColors.mint,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 28),
          GameButton(
            'NEXT LEVEL',
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => GameplayScreen(
                  progress: widget.progress,
                  level: widget.level + 1,
                ),
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
                builder: (_) => LevelMapScreen(progress: widget.progress),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
