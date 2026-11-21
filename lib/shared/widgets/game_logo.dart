import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class GameLogo extends StatelessWidget {
  const GameLogo({super.key, this.size = 76});
  final double size;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: AppColors.purpleSoft,
      borderRadius: BorderRadius.circular(size * .28),
    ),
    child: Center(
      child: Container(
        width: size * .55,
        height: size * .55,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.lilac, width: 4),
        ),
        child: Align(
          alignment: Alignment.topRight,
          child: Container(
            width: size * .16,
            height: size * .16,
            decoration: const BoxDecoration(
              color: AppColors.mint,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    ),
  );
}
