import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/player.dart';

class PlayerCardWidget extends StatelessWidget {
  final Player player;
  final bool isCurrent;
  final int rank;
  final int remainingPoints;

  const PlayerCardWidget({
    super.key,
    required this.player,
    required this.isCurrent,
    required this.rank,
    required this.remainingPoints,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isElim = player.isEliminated;
    final maxAchievable = player.maxAchievable(remainingPoints);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      margin: const EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: isCurrent
            ? Border.all(color: Colors.amber, width: 2.5)
            : Border.all(color: Colors.transparent, width: 2.5),
        color: isElim
            ? cs.surfaceContainerHighest.withValues(alpha: 0.5)
            : (isCurrent
                ? cs.primaryContainer.withValues(alpha: 0.8)
                : cs.surfaceContainer),
        boxShadow: isCurrent
            ? [
                BoxShadow(
                  color: Colors.amber.withValues(alpha: 0.3),
                  blurRadius: 8,
                  spreadRadius: 1,
                )
              ]
            : null,
      ),
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Row(
          children: [
            SizedBox(
              width: 28,
              child: Text(
                '#$rank',
                style: GoogleFonts.outfit(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isElim ? cs.outline : cs.primary,
                ),
              ),
            ),
            const SizedBox(width: 8),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: isCurrent
                  ? const Icon(Icons.sports_cricket,
                      size: 18, color: Colors.amber)
                  : const SizedBox(width: 18),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    player.name,
                    style: GoogleFonts.outfit(
                      fontSize: 15,
                      fontWeight:
                          isCurrent ? FontWeight.w700 : FontWeight.w500,
                      color: isElim ? cs.outline : cs.onSurface,
                      decoration:
                          isElim ? TextDecoration.lineThrough : null,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (!isElim)
                    Text(
                      'Max atteignable : $maxAchievable pts',
                      style: GoogleFonts.outfit(
                          fontSize: 11, color: cs.outline),
                    ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${player.score}',
                  style: GoogleFonts.outfit(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: isElim
                        ? cs.outline
                        : (isCurrent ? cs.primary : cs.onSurface),
                  ),
                ),
                Text(
                  'pts',
                  style: GoogleFonts.outfit(
                      fontSize: 11, color: cs.outline),
                ),
              ],
            ),
            const SizedBox(width: 8),
            _StatusBadge(isEliminated: isElim),
          ],
        ),
      ),
    )
        .animate(
            key: ValueKey(
                '${player.id}_${player.score}_${player.isEliminated}'))
        .fadeIn(duration: 250.ms)
        .slideX(begin: 0.05, end: 0, duration: 250.ms);
  }
}

class _StatusBadge extends StatelessWidget {
  final bool isEliminated;
  const _StatusBadge({required this.isEliminated});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isEliminated ? cs.errorContainer : cs.primaryContainer,
      ),
      child: Text(
        isEliminated ? 'Éliminé' : 'Actif',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: isEliminated
              ? cs.onErrorContainer
              : cs.onPrimaryContainer,
        ),
      ),
    );
  }
}
