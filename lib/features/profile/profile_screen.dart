import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../gameplay/providers/progress_controller.dart';
import '../../shared/widgets/screen_shell.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.progress});
  final ProgressController progress;

  @override
  Widget build(BuildContext context) => ScreenShell(
    title: 'PLAYER PROFILE',
    progress: progress,
    child: ListView(
      padding: const EdgeInsets.all(22),
      children: [
        const CircleAvatar(
          radius: 42,
          backgroundColor: AppColors.purpleSoft,
          child: Icon(Icons.person, size: 48, color: AppColors.lilac),
        ),
        const SizedBox(height: 12),
        const Center(
          child: Text(
            'PUZZLE EXPLORER',
            style: TextStyle(
              color: AppColors.lilac,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const Center(
          child: Text(
            'Your progress looks bright.',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
          ),
        ),
        const SizedBox(height: 22),
        Row(
          children: [
            _stat('LEVEL', '${progress.unlockedLevel}'),
            _stat('STARS', '${progress.totalStars}'),
            _stat('COMPLETED', '${progress.completedLevels}'),
          ],
        ),
        const SizedBox(height: 20),
        const Text(
          'ACHIEVEMENTS',
          style: TextStyle(color: AppColors.lilac, fontWeight: FontWeight.w900),
        ),
        _achievement(
          'First steps',
          'Complete 5 levels',
          progress.completedLevels >= 5,
        ),
        _achievement(
          'Star collector',
          'Earn 25 stars',
          progress.totalStars >= 25,
        ),
        _achievement(
          'Puzzle explorer',
          'Unlock level 10',
          progress.unlockedLevel >= 10,
        ),
      ],
    ),
  );

  Widget _stat(String label, String value) => Expanded(
    child: Card(
      color: AppColors.surface,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 9, color: AppColors.muted),
            ),
          ],
        ),
      ),
    ),
  );

  Widget _achievement(String title, String detail, bool done) => Card(
    color: AppColors.surface,
    child: ListTile(
      leading: Icon(
        Icons.workspace_premium,
        color: done ? AppColors.orange : AppColors.muted,
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
      subtitle: Text(
        detail,
        style: const TextStyle(color: AppColors.muted, fontSize: 10),
      ),
      trailing: Text(
        done ? 'DONE' : 'LOCKED',
        style: const TextStyle(fontSize: 9, color: AppColors.mint),
      ),
    ),
  );
}
