import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../gameplay/providers/progress_controller.dart';
import '../../shared/widgets/screen_shell.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key, required this.progress});
  final ProgressController progress;

  @override
  Widget build(BuildContext context) => ScreenShell(
    title: 'REWARDS',
    progress: progress,
    child: ListView(
      padding: const EdgeInsets.all(22),
      children: [
        const Text(
          'Your rewards',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
        ),
        _reward('LEVELS COMPLETED', '${progress.completedLevels}', Icons.flag),
        _reward('TOTAL STARS', '${progress.totalStars}', Icons.star),
        _reward('COIN WALLET', '${progress.coins}', Icons.monetization_on),
        _reward('HINTS AVAILABLE', '${progress.hints}', Icons.lightbulb),
      ],
    ),
  );

  Widget _reward(String title, String value, IconData icon) => Card(
    color: AppColors.surface,
    child: ListTile(
      leading: Icon(icon, color: AppColors.orange),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 10,
          color: AppColors.lilac,
          fontWeight: FontWeight.w900,
        ),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
      ),
    ),
  );
}
