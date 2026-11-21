import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../gameplay/providers/progress_controller.dart';
import '../gameplay/screens/gameplay_screen.dart';
import '../gameplay/screens/daily_challenge_screen.dart';
import '../gameplay/screens/how_to_play_screen.dart';
import '../levels/level_map_screen.dart';
import '../rewards/rewards_screen.dart';
import '../shop/theme_store_screen.dart';
import '../settings/settings_screen.dart';
import '../profile/profile_screen.dart';
import '../../shared/widgets/game_button.dart';
import '../../shared/widgets/screen_shell.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.progress});
  final ProgressController progress;

  @override
  Widget build(BuildContext context) => ScreenShell(
    title: 'COLOR GATE',
    showBack: false,
    progress: progress,
    child: ListView(
      padding: const EdgeInsets.all(22),
      children: [
        const Text(
          'Hey, puzzle master!',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
        ),
        const Text(
          'Ready for one more level?',
          style: TextStyle(color: AppColors.muted),
        ),
        const SizedBox(height: 22),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'YOUR JOURNEY',
                style: TextStyle(
                  color: AppColors.lilac,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                'LEVEL ${progress.unlockedLevel.toString().padLeft(2, '0')}',
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'One move closer to the perfect path.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 14),
              LinearProgressIndicator(
                value: (progress.completedLevels / 30).clamp(0, 1),
                color: AppColors.mint,
                backgroundColor: AppColors.surfaceAlt,
              ),
              const SizedBox(height: 16),
              GameButton(
                'PLAY LEVEL ${progress.unlockedLevel}',
                onPressed: () => _open(
                  context,
                  GameplayScreen(
                    progress: progress,
                    level: progress.unlockedLevel,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _item(
          context,
          'LEVEL MAP',
          'Explore unlocked puzzles',
          Icons.grid_view,
          LevelMapScreen(progress: progress),
        ),
        _item(
          context,
          'DAILY CHALLENGE',
          'A bonus puzzle awaits',
          Icons.auto_awesome,
          DailyChallengeScreen(progress: progress),
        ),
        _item(
          context,
          'REWARDS',
          'Your stars and progress',
          Icons.emoji_events,
          RewardsScreen(progress: progress),
        ),
        _item(
          context,
          'THEME STORE',
          'Choose your colors',
          Icons.palette,
          ThemeStoreScreen(progress: progress),
        ),
        _item(
          context,
          'PROFILE & STATS',
          'See your achievements',
          Icons.person,
          ProfileScreen(progress: progress),
        ),
        _item(
          context,
          'HOW TO PLAY',
          'Learn the puzzle rules',
          Icons.help_outline,
          const HowToPlayScreen(),
        ),
        _item(
          context,
          'SETTINGS',
          'Make the game yours',
          Icons.settings,
          SettingsScreen(progress: progress),
        ),
      ],
    ),
  );

  static void _open(BuildContext context, Widget page) =>
      Navigator.push(context, MaterialPageRoute(builder: (_) => page));

  Widget _item(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Widget page,
  ) => Card(
    color: AppColors.surface,
    child: ListTile(
      leading: Icon(icon, color: AppColors.mint),
      title: Text(
        title,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 11, color: AppColors.muted),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _open(context, page),
    ),
  );
}
