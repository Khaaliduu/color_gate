import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../shared/widgets/coin_counter.dart';
import '../../shared/widgets/game_button.dart';
import '../gameplay/providers/progress_controller.dart';
import '../gameplay/screens/daily_challenge_screen.dart';
import '../gameplay/screens/gameplay_screen.dart';
import '../gameplay/screens/how_to_play_screen.dart';
import '../levels/level_map_screen.dart';
import '../profile/profile_screen.dart';
import '../rewards/rewards_screen.dart';
import '../settings/settings_screen.dart';
import '../shop/theme_store_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.progress});
  final ProgressController progress;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tab = 0;

  void _open(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      _homeTab(),
      LevelMapScreen(progress: widget.progress),
      ProfileScreen(progress: widget.progress),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'COLOR GATE',
                      style: TextStyle(
                        fontSize: 17,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  CoinCounter(coins: widget.progress.coins),
                  const SizedBox(width: 8),
                  IconButton(
                    tooltip: 'Settings',
                    onPressed: () => _open(SettingsScreen(progress: widget.progress)),
                    icon: const Icon(Icons.settings_outlined, color: AppColors.lilac),
                  ),
                ],
              ),
            ),
            Expanded(child: IndexedStack(index: _tab, children: pages)),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (index) => setState(() => _tab = index),
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.purpleSoft,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.map_outlined),
            selectedIcon: Icon(Icons.map_rounded),
            label: 'Levels',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _homeTab() => ListView(
    padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
    children: [
      const Text(
        'READY, PUZZLE MASTER?',
        style: TextStyle(
          color: AppColors.lilac,
          fontSize: 10,
          letterSpacing: 1.5,
          fontWeight: FontWeight.w900,
        ),
      ),
      const SizedBox(height: 6),
      const Text(
        'Find the perfect path.',
        style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900),
      ),
      const Text(
        'Match every color before the moves run out.',
        style: TextStyle(color: AppColors.muted, fontSize: 12),
      ),
      const SizedBox(height: 22),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.purpleSoft, AppColors.surface],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(26),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.route_rounded, color: AppColors.mint),
                SizedBox(width: 8),
                Text(
                  'YOUR JOURNEY',
                  style: TextStyle(
                    color: AppColors.lilac,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'LEVEL ${widget.progress.unlockedLevel.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                minHeight: 7,
                value: (widget.progress.completedLevels / 30).clamp(0.0, 1.0),
                color: AppColors.mint,
                backgroundColor: AppColors.surfaceAlt,
              ),
            ),
            const SizedBox(height: 18),
            GameButton(
              'PLAY NOW',
              onPressed: () => _open(GameplayScreen(
                progress: widget.progress,
                level: widget.progress.unlockedLevel,
              )),
            ),
          ],
        ),
      ),
      const SizedBox(height: 18),
      const Text(
        'QUICK ACCESS',
        style: TextStyle(
          color: AppColors.lilac,
          fontSize: 10,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.3,
        ),
      ),
      const SizedBox(height: 10),
      Row(
        children: [
          Expanded(
            child: _quickAction(
              icon: Icons.calendar_today_rounded,
              title: 'Daily',
              onTap: () => _open(DailyChallengeScreen(progress: widget.progress)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _quickAction(
              icon: Icons.emoji_events_outlined,
              title: 'Rewards',
              onTap: () => _open(RewardsScreen(progress: widget.progress)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _quickAction(
              icon: Icons.palette_outlined,
              title: 'Themes',
              onTap: () => _open(ThemeStoreScreen(progress: widget.progress)),
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      Card(
        color: AppColors.surface,
        child: ListTile(
          leading: const Icon(Icons.lightbulb_outline, color: AppColors.mint),
          title: const Text('How to play', style: TextStyle(fontWeight: FontWeight.w800)),
          subtitle: const Text('Learn the rules and controls', style: TextStyle(color: AppColors.muted, fontSize: 11)),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _open(const HowToPlayScreen()),
        ),
      ),
    ],
  );

  Widget _quickAction({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) => Material(
    color: AppColors.surface,
    borderRadius: BorderRadius.circular(18),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 8),
        child: Column(
          children: [
            Icon(icon, color: AppColors.mint, size: 23),
            const SizedBox(height: 7),
            Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800)),
          ],
        ),
      ),
    ),
  );
}
