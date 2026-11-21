import 'package:flutter/material.dart';
import '../models/game_gate.dart';

class GameGateWidget extends StatelessWidget {
  const GameGateWidget({
    super.key,
    required this.gate,
    required this.onTap,
    this.enabled = true,
  });
  final GameGate gate;
  final VoidCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) => Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          height: 76,
          decoration: BoxDecoration(
            color: gate.color.withValues(alpha: enabled ? .16 : .06),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: gate.color.withValues(alpha: enabled ? 1 : .3),
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.route, color: gate.color, size: 25),
              const SizedBox(height: 5),
              Text(
                gate.label,
                style: TextStyle(
                  color: gate.color,
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
