import 'package:flutter/material.dart';
import '../../features/gameplay/providers/progress_controller.dart';
import 'coin_counter.dart';

class ScreenShell extends StatelessWidget {
  const ScreenShell({
    super.key,
    required this.title,
    required this.child,
    this.progress,
    this.showBack = true,
  });

  final String title;
  final Widget child;
  final ProgressController? progress;
  final bool showBack;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 20, 8),
            child: Row(
              children: [
                if (showBack)
                  IconButton(
                    onPressed: () => Navigator.maybePop(context),
                    icon: const Icon(Icons.arrow_back),
                  )
                else
                  const SizedBox(width: 48),
                Expanded(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ),
                  ),
                ),
                if (progress != null)
                  CoinCounter(coins: progress!.coins)
                else
                  const SizedBox(width: 48),
              ],
            ),
          ),
          Expanded(child: child),
        ],
      ),
    ),
  );
}
