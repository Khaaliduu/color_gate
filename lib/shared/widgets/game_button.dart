import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class GameButton extends StatelessWidget {
  const GameButton(
    this.label, {
    super.key,
    required this.onPressed,
    this.secondary = false,
  });
  final String label;
  final VoidCallback onPressed;
  final bool secondary;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    height: 54,
    child: FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: secondary ? AppColors.surfaceAlt : AppColors.purple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17),
          side: secondary
              ? const BorderSide(color: AppColors.border)
              : BorderSide.none,
        ),
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w900)),
    ),
  );
}
