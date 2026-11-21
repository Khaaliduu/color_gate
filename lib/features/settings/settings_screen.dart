import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../gameplay/providers/progress_controller.dart';
import '../../shared/widgets/screen_shell.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, required this.progress});

  final ProgressController progress;

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
          'LANGUAGE',
          style: TextStyle(color: AppColors.lilac, fontWeight: FontWeight.w900),
        ),
        const ListTile(
          title: Text('English'),
          subtitle: Text('More languages can be added later'),
        ),
        const SizedBox(height: 10),
        const Text(
          'ABOUT',
          style: TextStyle(color: AppColors.lilac, fontWeight: FontWeight.w900),
        ),
        const ListTile(
          title: Text('COLOR GATE'),
          subtitle: Text('Version 1.0.0'),
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
