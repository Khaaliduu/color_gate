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
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'DRAG. MATCH. WIN.',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
          ),
          const Text(
            'Follow these simple steps to clear each level.',
            style: TextStyle(color: AppColors.muted),
          ),
          const SizedBox(height: 20),
          _step(
            '1',
            'Touch the ball',
            'Place your finger on the glowing ball at the top.',
          ),
          _step(
            '2',
            'Drag along a lane',
            'Keep holding and drag the ball down toward one of the three gates.',
          ),
          _step(
            '3',
            'Match its color',
            'Release inside the bottom gate with the same color as the ball.',
          ),
          _step(
            '4',
            'Beat the timer',
            'Finish every ball before the countdown reaches zero. Levels get harder.',
          ),
          const Spacer(),
          GameButton('GOT IT', onPressed: () => Navigator.pop(context)),
        ],
      ),
    ),
  );
  Widget _step(String n, String title, String desc) => Card(
    color: AppColors.surface,
    child: ListTile(
      leading: CircleAvatar(
        backgroundColor: AppColors.purpleSoft,
        child: Text(
          n,
          style: const TextStyle(
            color: AppColors.lilac,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
      subtitle: Text(
        desc,
        style: const TextStyle(color: AppColors.muted, fontSize: 11),
      ),
    ),
  );
}
