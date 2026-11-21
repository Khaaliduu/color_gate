import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/app_colors.dart';
import '../gameplay/providers/progress_controller.dart';
import '../gameplay/screens/gameplay_screen.dart';
import '../gameplay/screens/how_to_play_screen.dart';
import '../levels/level_map_screen.dart';
import '../profile/profile_screen.dart';
import '../settings/settings_screen.dart';
import '../rewards/rewards_screen.dart';
import '../shop/theme_store_screen.dart';
import '../../shared/widgets/game_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.progress});
  final ProgressController progress;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int tab = 0;
  void open(Widget page) =>
      Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  Future<void> whatsapp() async {
    final uri = Uri.parse(
      'https://wa.me/?text=${Uri.encodeComponent('Try COLOR GATE! A fun color puzzle game.')}',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> share() async =>
      Share.share('COLOR GATE – Think, Match, Escape! Try the game.');

  @override
  Widget build(BuildContext context) {
    final pages = [
      _homeBody(),
      LevelMapScreen(progress: widget.progress),
      ProfileScreen(progress: widget.progress),
      SettingsScreen(progress: widget.progress),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'COLOR GATE',
          style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.2),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            tooltip: 'Share',
            onPressed: share,
            icon: const Icon(Icons.share_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: IndexedStack(index: tab, children: pages),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (v) => setState(() => tab = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_rounded), label: 'Home'),
          NavigationDestination(
            icon: Icon(Icons.grid_view_rounded),
            label: 'Levels',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_rounded),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _homeBody() => ListView(
    padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
    children: [
      const Text(
        'READY TO PLAY?',
        style: TextStyle(
          color: AppColors.lilac,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.5,
        ),
      ),
      const SizedBox(height: 5),
      const Text(
        'Guide the colors. Beat the clock.',
        style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900),
      ),
      const SizedBox(height: 18),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.purpleSoft, AppColors.surface],
          ),
          borderRadius: BorderRadius.circular(26),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.bolt_rounded, color: AppColors.orange),
                const SizedBox(width: 6),
                const Text(
                  'YOUR JOURNEY',
                  style: TextStyle(
                    color: AppColors.lilac,
                    fontWeight: FontWeight.w900,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'LEVEL ${widget.progress.unlockedLevel.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 27, fontWeight: FontWeight.w900),
            ),
            Text(
              '${widget.progress.completedLevels} levels completed  •  ${widget.progress.totalStars} stars',
              style: const TextStyle(color: AppColors.muted, fontSize: 11),
            ),
            const SizedBox(height: 18),
            GameButton(
              'PLAY NOW',
              onPressed: () => open(
                GameplayScreen(
                  progress: widget.progress,
                  level: widget.progress.unlockedLevel,
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 18),
      const Text(
        'EXPLORE',
        style: TextStyle(
          color: AppColors.lilac,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.2,
        ),
      ),
      const SizedBox(height: 8),
      _tile(
        Icons.help_outline_rounded,
        'How to Play',
        'Learn the drag controls',
        () => open(const HowToPlayScreen()),
      ),
      _tile(
        Icons.emoji_events_rounded,
        'Rewards',
        'Your stars and achievements',
        () => open(RewardsScreen(progress: widget.progress)),
      ),
      _tile(
        Icons.palette_rounded,
        'Theme Store',
        'Customize your game',
        () => open(ThemeStoreScreen(progress: widget.progress)),
      ),
      _tile(
        Icons.grid_view_rounded,
        'Level Map',
        'Choose an unlocked level',
        () => setState(() => tab = 1),
      ),
      const SizedBox(height: 12),
      Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: whatsapp,
              icon: const Icon(Icons.chat_rounded),
              label: const Text('WHATSAPP'),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: share,
              icon: const Icon(Icons.share_rounded),
              label: const Text('SHARE'),
            ),
          ),
        ],
      ),
    ],
  );

  Widget _tile(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback action,
  ) => Card(
    color: AppColors.surface,
    child: ListTile(
      onTap: action,
      leading: Icon(icon, color: AppColors.mint),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: AppColors.muted, fontSize: 11),
      ),
      trailing: const Icon(Icons.chevron_right_rounded),
    ),
  );
}
