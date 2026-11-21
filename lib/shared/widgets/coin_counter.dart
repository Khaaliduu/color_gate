import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class CoinCounter extends StatelessWidget {
  const CoinCounter({super.key, required this.coins});
  final int coins;
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Icon(Icons.monetization_on, color: AppColors.orange, size: 18),
      const SizedBox(width: 5),
      Text('$coins', style: const TextStyle(fontWeight: FontWeight.w900)),
    ],
  );
}
