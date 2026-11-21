import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../gameplay/providers/progress_controller.dart';
import '../../shared/widgets/screen_shell.dart';

class ThemeStoreScreen extends StatelessWidget {
  const ThemeStoreScreen({super.key, required this.progress});
  final ProgressController progress;

  static const themes = <(String, int, List<Color>)>[
    ('VIOLET DREAM', 0, [AppColors.purple, AppColors.mint, AppColors.orange]),
    (
      'MINT POP',
      120,
      [Color(0xFF2DD4BF), Color(0xFF86EFAC), Color(0xFFBEF264)],
    ),
    (
      'SUNSET GLOW',
      180,
      [Color(0xFFFF6B6B), Color(0xFFFFA94D), Color(0xFFFFD166)],
    ),
    (
      'OCEAN WAVE',
      220,
      [Color(0xFF38BDF8), Color(0xFF818CF8), Color(0xFF2DD4BF)],
    ),
  ];

  @override
  Widget build(BuildContext context) => ScreenShell(
    title: 'THEME STORE',
    progress: progress,
    child: Padding(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Make it yours.',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
          ),
          const Text(
            'Choose a color mood.',
            style: TextStyle(color: AppColors.muted),
          ),
          const SizedBox(height: 18),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1.12,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: themes.map((theme) {
                final name = theme.$1;
                final cost = theme.$2;
                final owned = progress.ownedThemes.contains(name);
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(17),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ...theme.$3.map(
                            (color) => Expanded(
                              child: Container(
                                height: 30,
                                margin: const EdgeInsets.only(right: 4),
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),

                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 6),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () async {
                            final ok = await progress.purchaseTheme(name, cost);
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  ok ? 'Theme selected' : 'Not enough coins',
                                ),
                              ),
                            );
                          },
                          child: Text(
                            progress.selectedTheme == name
                                ? 'SELECTED'
                                : owned
                                ? 'USE THEME'
                                : '$cost COINS',
                            style: const TextStyle(fontSize: 9),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    ),
  );
}
