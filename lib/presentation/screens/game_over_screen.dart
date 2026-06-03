import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/game_action.dart';
import '../../domain/entities/game_session.dart';
import '../../domain/entities/player.dart';
import '../providers/game_providers.dart';
import '../widgets/ball_widget.dart';

class GameOverScreen extends ConsumerWidget {
  const GameOverScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(gameNotifierProvider);

    if (session == null || !session.isGameOver) {
      WidgetsBinding.instance.addPostFrameCallback((_) => context.go('/'));
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final winner =
        session.players.where((p) => p.id == session.winnerId).firstOrNull;
    final ranked = session.rankings;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          children: [
            _TrophyHeader(winner: winner, session: session)
                .animate()
                .fadeIn(duration: 500.ms)
                .scale(begin: const Offset(0.8, 0.8)),
            const SizedBox(height: 24),
            Text(
              'Classement final',
              style:
                  GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w700),
            ).animate().fadeIn(delay: 300.ms),
            const SizedBox(height: 10),
            ...ranked.asMap().entries.map((e) {
              return _RankRow(
                rank: e.key + 1,
                player: e.value,
                isWinner: e.value.id == session.winnerId,
              ).animate(delay: Duration(milliseconds: 400 + e.key * 80));
            }),
            const SizedBox(height: 24),
            _GameStats(session: session).animate().fadeIn(delay: 700.ms),
            const SizedBox(height: 24),
            Text(
              'Historique des actions',
              style:
                  GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w700),
            ).animate().fadeIn(delay: 800.ms),
            const SizedBox(height: 8),
            _ActionHistory(session: session).animate().fadeIn(delay: 900.ms),
            const SizedBox(height: 28),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      ref.read(gameNotifierProvider.notifier).clearGame();
                      context.go('/');
                    },
                    icon: const Icon(Icons.home_rounded),
                    label: const Text('Accueil'),
                    style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      ref.read(gameNotifierProvider.notifier).clearGame();
                      context.go('/new-game');
                    },
                    icon: const Icon(Icons.add_circle_rounded),
                    label: const Text('Nouvelle partie'),
                    style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14)),
                  ),
                ),
              ],
            ).animate().fadeIn(delay: 1000.ms),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _TrophyHeader extends StatelessWidget {
  final Player? winner;
  final GameSession session;
  const _TrophyHeader({this.winner, required this.session});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            const Color(0xFFFFD600).withValues(alpha: 0.3),
            cs.primaryContainer.withValues(alpha: 0.5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border:
            Border.all(color: const Color(0xFFFFD600).withValues(alpha: 0.5)),
      ),
      child: Column(
        children: [
          const Text('🏆', style: TextStyle(fontSize: 52)),
          const SizedBox(height: 8),
          Text(
            'Partie terminée !',
            style: GoogleFonts.outfit(
                fontSize: 22, fontWeight: FontWeight.w800),
          ),
          if (winner != null) ...[
            const SizedBox(height: 4),
            Text(
              '🎉 ${winner!.name} remporte la partie',
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: cs.primary,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'avec ${winner!.score} points',
              style: GoogleFonts.outfit(fontSize: 14, color: cs.outline),
            ),
          ],
        ],
      ),
    );
  }
}

class _RankRow extends StatelessWidget {
  final int rank;
  final Player player;
  final bool isWinner;
  const _RankRow(
      {required this.rank, required this.player, required this.isWinner});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isWinner
            ? const Color(0xFFFFD600).withValues(alpha: 0.15)
            : cs.surfaceContainer,
        border: isWinner
            ? Border.all(
                color: const Color(0xFFFFD600).withValues(alpha: 0.5))
            : null,
      ),
      child: Row(
        children: [
          _medal(rank),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              player.name,
              style: GoogleFonts.outfit(
                fontSize: 15,
                fontWeight: isWinner ? FontWeight.w700 : FontWeight.w500,
                decoration: player.isEliminated
                    ? TextDecoration.lineThrough
                    : null,
                color: player.isEliminated ? cs.outline : cs.onSurface,
              ),
            ),
          ),
          if (player.isEliminated)
            Container(
              margin: const EdgeInsets.only(right: 8),
              padding:
                  const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: cs.errorContainer,
              ),
              child: Text('Éliminé',
                  style: TextStyle(
                      fontSize: 10, color: cs.onErrorContainer)),
            ),
          Text(
            '${player.score} pts',
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: isWinner ? const Color(0xFFE65100) : cs.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _medal(int rank) {
    switch (rank) {
      case 1:
        return const Text('🥇', style: TextStyle(fontSize: 26));
      case 2:
        return const Text('🥈', style: TextStyle(fontSize: 26));
      case 3:
        return const Text('🥉', style: TextStyle(fontSize: 26));
      default:
        return SizedBox(
          width: 26,
          child: Center(
            child: Text('$rank',
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 14)),
          ),
        );
    }
  }
}

class _GameStats extends StatelessWidget {
  final GameSession session;
  const _GameStats({required this.session});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final duration = session.gameDuration;
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: cs.surfaceContainer,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Statistiques de la partie',
              style: GoogleFonts.outfit(
                  fontSize: 14, fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          Row(
            children: [
              _StatChip(
                  label: 'Durée',
                  value: '${minutes}min ${seconds}s',
                  icon: Icons.timer_outlined),
              const SizedBox(width: 8),
              _StatChip(
                  label: 'Boules jouées',
                  value: '${session.totalBallsPlayed}/11',
                  icon: Icons.sports_score_rounded),
              const SizedBox(width: 8),
              _StatChip(
                  label: 'Actions',
                  value: '${session.actions.length}',
                  icon: Icons.list_alt_rounded),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Le ${DateFormat('dd/MM/yyyy à HH:mm').format(session.startTime)}',
            style: GoogleFonts.outfit(fontSize: 12, color: cs.outline),
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  const _StatChip(
      {required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: cs.primaryContainer.withValues(alpha: 0.4),
        ),
        child: Column(
          children: [
            Icon(icon, size: 18, color: cs.primary),
            const SizedBox(height: 4),
            Text(value,
                style: GoogleFonts.outfit(
                    fontSize: 14, fontWeight: FontWeight.w700)),
            Text(label,
                style: GoogleFonts.outfit(
                    fontSize: 10, color: cs.outline)),
          ],
        ),
      ),
    );
  }
}

class _ActionHistory extends StatelessWidget {
  final GameSession session;
  const _ActionHistory({required this.session});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final actions = session.actions.reversed.toList();

    if (actions.isEmpty) {
      return Text('Aucune action enregistrée.',
          style: TextStyle(color: cs.outline));
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: cs.surfaceContainerHighest,
      ),
      child: Column(
        children: actions.asMap().entries.map((e) {
          return _ActionRow(
              action: e.value, isLast: e.key == actions.length - 1);
        }).toList(),
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  final GameAction action;
  final bool isLast;
  const _ActionRow({required this.action, required this.isLast});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isPositive = action.scoreDelta > 0;
    final isNeutral = action.scoreDelta == 0;
    final deltaColor = isNeutral
        ? cs.outline
        : (isPositive ? const Color(0xFF2E7D32) : cs.error);
    final deltaText =
        isNeutral ? '±0' : (isPositive ? '+${action.scoreDelta}' : '${action.scoreDelta}');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(bottom: BorderSide(color: cs.outlineVariant)),
      ),
      child: Row(
        children: [
          BallWidget(number: action.ballValue, size: 30),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(action.playerName,
                    style: GoogleFonts.outfit(
                        fontSize: 13, fontWeight: FontWeight.w600)),
                Text(action.type.label,
                    style:
                        GoogleFonts.outfit(fontSize: 11, color: cs.outline)),
              ],
            ),
          ),
          Text(
            deltaText,
            style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: deltaColor),
          ),
        ],
      ),
    );
  }
}
