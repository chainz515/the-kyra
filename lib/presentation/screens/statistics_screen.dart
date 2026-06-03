import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/game_session.dart';
import '../providers/game_providers.dart';

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(gameHistoryProvider);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('The Kyra — Statistiques'),
        leading: BackButton(onPressed: () => context.pop()),
      ),
      body: historyAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erreur: $e')),
        data: (history) {
          if (history.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.bar_chart_rounded,
                      size: 64, color: cs.outlineVariant),
                  const SizedBox(height: 16),
                  Text(
                    'Pas encore de statistiques',
                    style: GoogleFonts.outfit(
                        fontSize: 16, color: cs.outline),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Jouez des parties pour voir vos stats !',
                    style: GoogleFonts.outfit(
                        fontSize: 13, color: cs.outline),
                  ),
                ],
              ),
            );
          }

          final stats = _computeStats(history);

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _SectionTitle(title: "Vue d'ensemble").animate().fadeIn(),
              const SizedBox(height: 10),
              Row(
                children: [
                  _BigStat(
                    label: 'Parties jouées',
                    value: '${history.length}',
                    icon: Icons.sports_score_rounded,
                  ),
                  const SizedBox(width: 8),
                  _BigStat(
                    label: 'Joueurs différents',
                    value: '${stats.playerNames.length}',
                    icon: Icons.group_rounded,
                  ),
                  const SizedBox(width: 8),
                  _BigStat(
                    label: 'Points total',
                    value: '${stats.totalPointsScored}',
                    icon: Icons.stars_rounded,
                  ),
                ],
              ).animate().fadeIn(delay: 100.ms),
              const SizedBox(height: 24),
              _SectionTitle(title: 'Classement des joueurs')
                  .animate()
                  .fadeIn(delay: 200.ms),
              const SizedBox(height: 10),
              ...stats.playerRankings.asMap().entries.map((e) {
                return _PlayerStatRow(rank: e.key + 1, ps: e.value)
                    .animate(
                        delay:
                            Duration(milliseconds: 300 + e.key * 80))
                    .fadeIn()
                    .slideX(begin: 0.05);
              }),
              const SizedBox(height: 24),
              _SectionTitle(title: 'Meilleures performances')
                  .animate()
                  .fadeIn(delay: 600.ms),
              const SizedBox(height: 10),
              ...stats.topScores.asMap().entries.map((e) {
                return _TopScoreRow(rank: e.key + 1, ts: e.value)
                    .animate(
                        delay:
                            Duration(milliseconds: 700 + e.key * 60))
                    .fadeIn();
              }),
            ],
          );
        },
      ),
    );
  }

  _GameStats _computeStats(List<GameSession> history) {
    final wins = <String, int>{};
    final games = <String, int>{};
    final totalScore = <String, int>{};
    final bestScore = <String, int>{};
    final topScores = <_TopScore>[];
    var totalPoints = 0;

    for (final session in history) {
      for (final player in session.players) {
        final name = player.name;
        games[name] = (games[name] ?? 0) + 1;
        totalScore[name] = (totalScore[name] ?? 0) + player.score;
        totalPoints += player.score.clamp(0, 999);
        if (player.score > (bestScore[name] ?? -999999)) {
          bestScore[name] = player.score;
        }
        if (session.winnerId == player.id) {
          wins[name] = (wins[name] ?? 0) + 1;
        }
        topScores.add(_TopScore(
          playerName: name,
          score: player.score,
          date: session.startTime,
          won: session.winnerId == player.id,
        ));
      }
    }

    final rankings = games.keys
        .map((name) => _PlayerStats(
              name: name,
              games: games[name]!,
              wins: wins[name] ?? 0,
              totalScore: totalScore[name]!,
              bestScore: bestScore[name] ?? 0,
            ))
        .toList()
      ..sort((a, b) => b.wins.compareTo(a.wins));

    topScores.sort((a, b) => b.score.compareTo(a.score));

    return _GameStats(
      playerRankings: rankings,
      topScores: topScores.take(5).toList(),
      totalPointsScored: totalPoints,
      playerNames: games.keys.toSet(),
    );
  }
}

class _GameStats {
  final List<_PlayerStats> playerRankings;
  final List<_TopScore> topScores;
  final int totalPointsScored;
  final Set<String> playerNames;
  _GameStats({
    required this.playerRankings,
    required this.topScores,
    required this.totalPointsScored,
    required this.playerNames,
  });
}

class _PlayerStats {
  final String name;
  final int games;
  final int wins;
  final int totalScore;
  final int bestScore;
  double get winRate => games > 0 ? wins / games : 0;
  double get avgScore => games > 0 ? totalScore / games : 0;
  _PlayerStats({
    required this.name,
    required this.games,
    required this.wins,
    required this.totalScore,
    required this.bestScore,
  });
}

class _TopScore {
  final String playerName;
  final int score;
  final DateTime date;
  final bool won;
  _TopScore(
      {required this.playerName,
      required this.score,
      required this.date,
      required this.won});
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style:
            GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w700));
  }
}

class _BigStat extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  const _BigStat(
      {required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: cs.primaryContainer.withValues(alpha: 0.4),
        ),
        child: Column(
          children: [
            Icon(icon, size: 22, color: cs.primary),
            const SizedBox(height: 6),
            Text(value,
                style: GoogleFonts.outfit(
                    fontSize: 20, fontWeight: FontWeight.w800)),
            Text(label,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                    fontSize: 10, color: cs.outline, height: 1.3)),
          ],
        ),
      ),
    );
  }
}

class _PlayerStatRow extends StatelessWidget {
  final int rank;
  final _PlayerStats ps;
  const _PlayerStatRow({required this.rank, required this.ps});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: cs.surfaceContainer,
      ),
      child: Row(
        children: [
          Text('$rank',
              style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: cs.primary)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ps.name,
                    style: GoogleFonts.outfit(
                        fontSize: 14, fontWeight: FontWeight.w600)),
                Text(
                  '${ps.games} partie${ps.games > 1 ? 's' : ''} · moy ${ps.avgScore.toStringAsFixed(1)} pts',
                  style: GoogleFonts.outfit(
                      fontSize: 11, color: cs.outline),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  const Text('🏆', style: TextStyle(fontSize: 14)),
                  const SizedBox(width: 4),
                  Text(
                      '${ps.wins} victoire${ps.wins > 1 ? 's' : ''}',
                      style: GoogleFonts.outfit(
                          fontSize: 13, fontWeight: FontWeight.w700)),
                ],
              ),
              Text(
                '${(ps.winRate * 100).toStringAsFixed(0)}% win rate',
                style: GoogleFonts.outfit(
                    fontSize: 11, color: cs.outline),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TopScoreRow extends StatelessWidget {
  final int rank;
  final _TopScore ts;
  const _TopScoreRow({required this.rank, required this.ts});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ts.won
            ? const Color(0xFFFFD600).withValues(alpha: 0.12)
            : cs.surfaceContainer,
      ),
      child: Row(
        children: [
          Text('$rank.',
              style:
                  GoogleFonts.outfit(fontSize: 13, color: cs.outline)),
          const SizedBox(width: 10),
          if (ts.won) const Text('🏆', style: TextStyle(fontSize: 14)),
          if (!ts.won) Icon(Icons.person, size: 16, color: cs.outline),
          const SizedBox(width: 6),
          Expanded(
            child: Text(ts.playerName,
                style: GoogleFonts.outfit(
                    fontSize: 13, fontWeight: FontWeight.w600)),
          ),
          Text(
            '${ts.score} pts',
            style: GoogleFonts.outfit(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: cs.primary),
          ),
        ],
      ),
    );
  }
}
