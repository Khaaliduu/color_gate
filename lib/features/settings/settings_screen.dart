import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/app_colors.dart';
import '../gameplay/providers/progress_controller.dart';
import '../gameplay/screens/how_to_play_screen.dart';
import '../../shared/widgets/screen_shell.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, required this.progress});
  final ProgressController progress;
  Future<void> _whatsapp() async {
    final uri = Uri.parse(
      'https://wa.me/?text=${Uri.encodeComponent('Hello, I am playing COLOR GATE!')}',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) => ScreenShell(
    title: 'SETTINGS',
    progress: progress,
    child: ListView(
      padding: const EdgeInsets.all(22),
      children: [
        const Text(
          'Your game, your way.',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
        ),
        _toggle(
          'Sound effects',
          'Game sounds and audio',
          progress.soundEnabled,
          progress.setSound,
        ),
        _toggle(
          'Vibration',
          'Haptic feedback',
          progress.vibrationEnabled,
          progress.setVibration,
        ),
        _toggle(
          'Reduce motion',
          'Use calmer visual effects',
          progress.reduceMotion,
          progress.setReduceMotion,
        ),
        const SizedBox(height: 20),
        const Text(
          'HELP & SUPPORT',
          style: TextStyle(color: AppColors.lilac, fontWeight: FontWeight.w900),
        ),
        Card(
          color: AppColors.surface,
          child: ListTile(
            leading: const Icon(Icons.help_outline, color: AppColors.mint),
            title: const Text('How to Play'),
            subtitle: const Text('Learn how to drag and match'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const HowToPlayScreen()),
            ),
          ),
        ),
        Card(
          color: AppColors.surface,
          child: ListTile(
            leading: const Icon(Icons.chat, color: AppColors.mint),
            title: const Text('WhatsApp'),
            subtitle: const Text('Share or contact through WhatsApp'),
            onTap: _whatsapp,
          ),
        ),
        Card(
          color: AppColors.surface,
          child: ListTile(
            leading: const Icon(Icons.share, color: AppColors.mint),
            title: const Text('Share COLOR GATE'),
            subtitle: const Text('Invite friends to play'),
            onTap: () => Share.share('COLOR GATE – Think, Match, Escape!'),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'ABOUT',
          style: TextStyle(color: AppColors.lilac, fontWeight: FontWeight.w900),
        ),
        const ListTile(
          title: Text('COLOR GATE'),
          subtitle: Text('Version 1.1.0'),
        ),
      ],
    ),
  );
  Widget _toggle(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) => Card(
    color: AppColors.surface,
    child: SwitchListTile(
      value: value,
      onChanged: onChanged,
      activeThumbColor: AppColors.mint,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: AppColors.muted, fontSize: 10),
      ),
    ),
  );
}
