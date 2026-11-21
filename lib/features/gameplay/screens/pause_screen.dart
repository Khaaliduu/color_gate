import 'package:flutter/material.dart';
import '../../../shared/widgets/game_button.dart';
import '../../../shared/widgets/screen_shell.dart';
import '../providers/progress_controller.dart';
import '../../levels/level_map_screen.dart';
import 'gameplay_screen.dart';

class PauseScreen extends StatelessWidget {
  const PauseScreen({super.key, required this.progress, required this.level});
  final ProgressController progress;
  final int level;

  @override
  Widget build(BuildContext context) => ScreenShell(
    title: 'PAUSED',
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Take a breath.',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
          ),
          const Text(
            'Your puzzle is waiting.',
            style: TextStyle(color: Colors.white60),
          ),
          const SizedBox(height: 35),
          const Text('🟣   🟢   🟠', style: TextStyle(fontSize: 34)),
          const SizedBox(height: 35),
          GameButton('RESUME', onPressed: () => Navigator.pop(context)),
          const SizedBox(height: 12),
          GameButton(
            'RESTART LEVEL',
            secondary: true,
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    GameplayScreen(progress: progress, level: level),
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => LevelMapScreen(progress: progress),
              ),
            ),
            child: const Text('LEVEL MAP'),
          ),
        ],
      ),
    ),
  );
}
