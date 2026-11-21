import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/game_button.dart';
import '../../../shared/widgets/screen_shell.dart';

class HowToPlayScreen extends StatelessWidget {
  const HowToPlayScreen({super.key});

  @override
  Widget build(BuildContext context) => ScreenShell(
    title: 'HOW TO PLAY',
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Three moves. One perfect match.',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
          ),
          const Text(
            'The rules are simple. The challenge is yours.',
            style: TextStyle(color: AppColors.muted),
          ),
          const SizedBox(height: 24),
          _step('1', 'Tap a gate', 'Choose which color to send next.'),
          _step(
            '2',
            'Match the colors',
            'Send each ball through its matching gate.',
          ),
          _step('3', 'Earn your stars', 'Plan ahead and finish the sequence.'),
          const Spacer(),
          GameButton('GOT IT', onPressed: () => Navigator.pop(context)),
        ],
      ),
    ),
  );

  Widget _step(String number, String title, String description) => Card(
    color: AppColors.surface,
    child: ListTile(
      leading: CircleAvatar(
        backgroundColor: AppColors.purpleSoft,
        child: Text(number, style: const TextStyle(color: AppColors.lilac)),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
      subtitle: Text(
        description,
        style: const TextStyle(color: AppColors.muted, fontSize: 11),
      ),
    ),
  );
}
