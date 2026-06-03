import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BallWidget extends StatelessWidget {
  final int number;
  final double size;
  final bool isActive;
  final bool isPlayed;

  const BallWidget({
    super.key,
    required this.number,
    this.size = 48,
    this.isActive = false,
    this.isPlayed = false,
  });

  static Color colorOf(int n) {
    switch (n) {
      case 7:  return const Color(0xFF8B1A1A);
      case 8:  return const Color(0xFF212121);
      case 9:  return const Color(0xFFFFD600);
      case 10: return const Color(0xFF1565C0);
      case 11: return const Color(0xFFC62828);
      case 12: return const Color(0xFF6A1B9A);
      case 13: return const Color(0xFFE65100);
      case 14: return const Color(0xFF2E7D32);
      case 15: return const Color(0xFF4E342E);
      case 16: return const Color(0xFF880E4F);
      case 17: return const Color(0xFF37474F);
      default: return const Color(0xFF757575);
    }
  }

  static bool isStripe(int n) => n >= 9 && n <= 15;

  @override
  Widget build(BuildContext context) {
    final color = colorOf(number);
    final stripe = isStripe(number);
    final textColor = number == 9 ? Colors.black87 : Colors.white;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isPlayed
            ? Colors.grey.withValues(alpha: 0.3)
            : (stripe ? Colors.white : color),
        border: Border.all(
          color: isActive
              ? Colors.amber
              : (isPlayed
                  ? Colors.grey.withValues(alpha: 0.4)
                  : color),
          width: isActive ? 3 : 1.5,
        ),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: Colors.amber.withValues(alpha: 0.6),
                  blurRadius: 12,
                  spreadRadius: 2,
                )
              ]
            : null,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (stripe && !isPlayed)
            Positioned.fill(
              child: ClipOval(
                child: Center(
                  child: Container(height: size * 0.5, color: color),
                ),
              ),
            ),
          Text(
            '$number',
            style: GoogleFonts.outfit(
              fontSize: size * 0.36,
              fontWeight: FontWeight.w800,
              color: isPlayed
                  ? Colors.grey
                  : (stripe ? Colors.white : textColor),
              shadows: const [
                Shadow(
                  color: Colors.black45,
                  blurRadius: 2,
                  offset: Offset(0, 1),
                )
              ],
            ),
          ),
          if (isPlayed)
            Icon(Icons.check, size: size * 0.45, color: Colors.green),
        ],
      ),
    );
  }
}

class BallSequenceWidget extends StatelessWidget {
  final int currentBallIndex;
  final List<int> removedBalls;

  const BallSequenceWidget({
    super.key,
    required this.currentBallIndex,
    required this.removedBalls,
  });

  @override
  Widget build(BuildContext context) {
    const balls = [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: balls.asMap().entries.map((e) {
          final idx = e.key;
          final ball = e.value;
          final isPlayed =
              idx < currentBallIndex || removedBalls.contains(ball);
          final isActive =
              idx == currentBallIndex && !removedBalls.contains(ball);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: BallWidget(
              number: ball,
              size: 40,
              isActive: isActive,
              isPlayed: isPlayed,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class CurrentBallDisplay extends StatelessWidget {
  final int? ballNumber;

  const CurrentBallDisplay({super.key, this.ballNumber});

  @override
  Widget build(BuildContext context) {
    if (ballNumber == null) {
      return const SizedBox(
        height: 96,
        child: Center(
          child: Icon(Icons.check_circle, size: 60, color: Colors.green),
        ),
      );
    }
    return Center(
      child: Column(
        children: [
          BallWidget(number: ballNumber!, size: 80, isActive: true),
          const SizedBox(height: 6),
          Text(
            'Boule en jeu',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
        ],
      ),
    );
  }
}
