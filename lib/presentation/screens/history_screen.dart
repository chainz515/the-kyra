import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/game_session.dart';
import '../providers/game_providers.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(gameHistoryProvider);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('The Kyra — Historique'),
        leading: BackButton(onPressed: () => context.pop()),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => ref.invalidate(gameHistoryProvider),
            tooltip: 'Actualiser',
          ),
        ],
      ),
      body: historyAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, size: 48, color: cs.error),
              const SizedBox(height: 12),
              Text('Erreur de chargement',
                  style: TextStyle(color: cs.error)),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => ref.invalidate(gameHistoryProvider),
                child: const Text('Réessayer'),
              ),
            ],
          ),
        ),
        data: (history) => history.isEmpty
            ? _EmptyState()
            : ListView.builder(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                itemCount: history.length,
                itemBuilder: (_, i) => _HistoryCard(
                  session: history[i],
                  onDelete: () async {
                    await ref
                        .read(gameRepositoryProvider)
                        .deleteGame(history[i].id);
                    ref.invalidate(gameHistoryProvider);
                  },
                )
                    .animate(
                        delay: Duration(milliseconds: i * 60))
                    .fadeIn()
                    .slideY(begin: 0.05),
              ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.history_rounded, size: 64, color: cs.outlineVariant),
          const SizedBox(height: 16),
          Text(
            'Aucune partie enregistrée',
            style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: cs.outline),
          ),
          const SizedBox(height: 8),
          Text(
            'Les parties terminées apparaîtront ici.',
            style: GoogleFonts.outfit(fontSize: 13, color: cs.outline),
          ),
        ],
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final GameSession session;
  final VoidCallback onDelete;
  const _HistoryCard({required this.session, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final winner = session.players
        .where((p) => p.id == session.winnerId)
        .firstOrNull;
    final duration = session.gameDuration;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onLongPress: () => _confirmDelete(context),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('🏆', style: TextStyle(fontSize: 18)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      winner != null
                          ? '${winner.name} a gagné'
                          : 'Partie terminée',
                      style: GoogleFonts.outfit(
                          fontSize: 15, fontWeight: FontWeight.w700),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete_outline,
                        size: 20, color: cs.error),
                    onPressed: () => _confirmDelete(context),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                        minWidth: 36, minHeight: 36),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                DateFormat('dd/MM/yyyy · HH:mm')
                    .format(session.startTime),
                style:
                    GoogleFonts.outfit(fontSize: 12, color: cs.outline),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: session.rankings.map((p) {
                  final isWinner = p.id == session.winnerId;
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: isWinner
                          ? const Color(0xFFFFD600).withValues(alpha: 0.25)
                          : cs.surfaceContainerHighest,
                    ),
                    child: Text(
                      '${p.name} · ${p.score}',
                      style: GoogleFonts.outfit(
                        fontSize: 11,
                        fontWeight: isWinner
                            ? FontWeight.w700
                            : FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.timer_outlined, size: 14, color: cs.outline),
                  const SizedBox(width: 4),
                  Text(
                    '${duration.inMinutes}min ${duration.inSeconds % 60}s',
                    style: GoogleFonts.outfit(
                        fontSize: 12, color: cs.outline),
                  ),
                  const SizedBox(width: 14),
                  Icon(Icons.sports_score_rounded,
                      size: 14, color: cs.outline),
                  const SizedBox(width: 4),
                  Text(
                    '${session.actions.length} actions',
                    style: GoogleFonts.outfit(
                        fontSize: 12, color: cs.outline),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Supprimer ?'),
        content: const Text(
            'Cette partie sera supprimée définitivement.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Annuler')),
          FilledButton(
            style: FilledButton.styleFrom(
                backgroundColor: Theme.of(ctx).colorScheme.error),
            onPressed: () {
              Navigator.pop(ctx);
              onDelete();
            },
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
  }
}
