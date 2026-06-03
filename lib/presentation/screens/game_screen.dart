import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/game_action.dart';
import '../../domain/entities/game_session.dart';
import '../../domain/entities/player.dart';
import '../providers/game_providers.dart';
import '../widgets/ball_widget.dart';

class GameScreen extends ConsumerWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(gameNotifierProvider);

    if (session == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => context.go('/'));
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    ref.listen<GameSession?>(gameNotifierProvider, (prev, next) {
      if (next?.isGameOver == true && prev?.isGameOver != true) {
        _saveAndNavigate(context, ref, next!);
      }
    });

    final cs = Theme.of(context).colorScheme;
    final canUndo = session.previousState != null;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        title: Text(
          '${session.totalBallsPlayed}/11 boules · ${session.remainingPoints} pts restants',
          style: GoogleFonts.outfit(fontWeight: FontWeight.w700, fontSize: 15),
        ),
        leading: IconButton(
          icon: const Icon(Icons.home_rounded),
          onPressed: () => _confirmExit(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.undo_rounded,
                color: canUndo ? null : cs.onSurface.withValues(alpha: 0.3)),
            onPressed: canUndo
                ? () {
                    ref.read(gameNotifierProvider.notifier).undo();
                    ref.read(selectedPlayerIdProvider.notifier).state = null;
                    ref.read(selectedBallProvider.notifier).state = null;
                  }
                : null,
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Scores en temps réel ────────────────────────────────────────
          _ScoreBoard(session: session),
          const Divider(height: 1),
          // ── Boules sur la table ─────────────────────────────────────────
          Expanded(child: _BallGrid(session: session)),
          const Divider(height: 1),
          // ── Boutons d'action ────────────────────────────────────────────
          _ActionBar(session: session),
        ],
      ),
    );
  }

  Future<void> _saveAndNavigate(
      BuildContext context, WidgetRef ref, GameSession session) async {
    try {
      await ref.read(gameRepositoryProvider).saveGame(session);
      ref.invalidate(gameHistoryProvider);
    } catch (_) {}
    if (context.mounted) context.go('/game-over');
  }

  void _confirmExit(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Quitter ?'),
        content: const Text('La partie ne sera pas sauvegardée.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Continuer')),
          FilledButton(
              onPressed: () {
                Navigator.pop(ctx);
                context.go('/');
              },
              child: const Text('Quitter')),
        ],
      ),
    );
  }
}

// ─── Tableau des scores ───────────────────────────────────────────────────────

class _ScoreBoard extends ConsumerWidget {
  final GameSession session;
  const _ScoreBoard({required this.session});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final selectedId = ref.watch(selectedPlayerIdProvider);
    final ranked = session.rankings;

    return Container(
      color: cs.surfaceContainer,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          children: ranked.map((player) {
            final isSelected = player.id == selectedId;
            final isElim = player.isEliminated;

            return GestureDetector(
              onTap: isElim
                  ? null
                  : () {
                      HapticFeedback.selectionClick();
                      final notifier =
                          ref.read(selectedPlayerIdProvider.notifier);
                      notifier.state =
                          isSelected ? null : player.id;
                    },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: isSelected
                      ? cs.primary
                      : isElim
                          ? cs.surfaceContainerHighest.withValues(alpha: 0.5)
                          : cs.surface,
                  border: Border.all(
                    color: isSelected
                        ? cs.primary
                        : cs.outlineVariant,
                    width: isSelected ? 2 : 1,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: cs.primary.withValues(alpha: 0.4),
                            blurRadius: 8,
                          )
                        ]
                      : null,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      player.name,
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? cs.onPrimary
                            : isElim
                                ? cs.outline
                                : cs.onSurface,
                        decoration: isElim
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    const SizedBox(height: 2),
                    // Score avec animation
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      style: GoogleFonts.outfit(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: isSelected
                            ? cs.onPrimary
                            : isElim
                                ? cs.outline
                                : cs.primary,
                      ),
                      child: Text('${player.score}'),
                    ),
                    if (isElim)
                      Text(
                        'Éliminé',
                        style: GoogleFonts.outfit(
                            fontSize: 9, color: cs.error),
                      )
                    else
                      Text(
                        'max ${player.maxAchievable(session.remainingPoints)}',
                        style: GoogleFonts.outfit(
                          fontSize: 9,
                          color: isSelected
                              ? cs.onPrimary.withValues(alpha: 0.8)
                              : cs.outline,
                        ),
                      ),
                  ],
                ),
              )
                  .animate(
                      key: ValueKey(
                          '${player.id}_${player.score}_${player.isEliminated}'))
                  .fadeIn(duration: 200.ms),
            );
          }).toList(),
        ),
      ),
    );
  }
}

// ─── Grille des boules ────────────────────────────────────────────────────────

class _BallGrid extends ConsumerWidget {
  final GameSession session;
  const _BallGrid({required this.session});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final selectedBall = ref.watch(selectedBallProvider);
    final selectedPlayerId = ref.watch(selectedPlayerIdProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Icon(Icons.touch_app_rounded, size: 14, color: cs.outline),
              const SizedBox(width: 6),
              Text(
                selectedPlayerId == null
                    ? '1. Sélectionnez un joueur'
                    : selectedBall == null
                        ? '2. Sélectionnez la boule jouée'
                        : '3. Choisissez l\'action  +  −  ⚡',
                style: GoogleFonts.outfit(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: cs.primary),
              ),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            itemCount: GameSession.allBalls.length,
            itemBuilder: (_, i) {
              final ball = GameSession.allBalls[i];
              final isRemaining = session.remainingBalls.contains(ball);
              final isSelected = selectedBall == ball;

              return GestureDetector(
                onTap: isRemaining
                    ? () {
                        HapticFeedback.selectionClick();
                        final notifier =
                            ref.read(selectedBallProvider.notifier);
                        notifier.state = isSelected ? null : ball;
                      }
                    : null,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: Colors.amber.withValues(alpha: 0.7),
                              blurRadius: 14,
                              spreadRadius: 3,
                            )
                          ]
                        : null,
                  ),
                  child: BallWidget(
                    number: ball,
                    size: 64,
                    isActive: isSelected,
                    isPlayed: !isRemaining,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ─── Barre d'actions ──────────────────────────────────────────────────────────

class _ActionBar extends ConsumerWidget {
  final GameSession session;
  const _ActionBar({required this.session});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final selectedId = ref.watch(selectedPlayerIdProvider);
    final selectedBall = ref.watch(selectedBallProvider);

    final player = selectedId != null
        ? session.players.where((p) => p.id == selectedId).firstOrNull
        : null;

    final enabled = selectedId != null && selectedBall != null && player != null;

    void applyAndReset(ActionType type) {
      if (!enabled) return;
      HapticFeedback.mediumImpact();
      ref.read(gameNotifierProvider.notifier)
          .applyAction(selectedId!, selectedBall!, type);
      ref.read(selectedPlayerIdProvider.notifier).state = null;
      ref.read(selectedBallProvider.notifier).state = null;

      // Snackbar : résumé de l'action
      final delta = switch (type) {
        ActionType.scored    => '+$selectedBall',
        ActionType.fault     => '−$selectedBall',
        ActionType.ballWhite => '0',
      };
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          '${player!.name}  $delta pts  (boule $selectedBall)',
          style: GoogleFonts.outfit(fontWeight: FontWeight.w600),
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: switch (type) {
          ActionType.scored    => const Color(0xFF2E7D32),
          ActionType.fault     => cs.error,
          ActionType.ballWhite => const Color(0xFFF57C00),
        },
      ));
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      color: cs.surfaceContainer,
      child: Row(
        children: [
          // Indication sélection
          Expanded(
            child: Text(
              enabled
                  ? '${player!.name}  ·  boule $selectedBall'
                  : 'Sélectionnez joueur + boule',
              style: GoogleFonts.outfit(
                fontSize: 13,
                color: enabled ? cs.primary : cs.outline,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          // + Scored
          _ActionBtn(
            label: '+',
            color: const Color(0xFF2E7D32),
            enabled: enabled,
            onTap: () => applyAndReset(ActionType.scored),
          ),
          const SizedBox(width: 8),
          // − Fault
          _ActionBtn(
            label: '−',
            color: const Color(0xFFC62828),
            enabled: enabled,
            onTap: () => applyAndReset(ActionType.fault),
          ),
          const SizedBox(width: 8),
          // ⚡ Ball + White
          _ActionBtn(
            label: '⚡',
            color: const Color(0xFFF57C00),
            enabled: enabled,
            onTap: () => applyAndReset(ActionType.ballWhite),
            isEmoji: true,
          ),
        ],
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final String label;
  final Color color;
  final bool enabled;
  final bool isEmoji;
  final VoidCallback onTap;

  const _ActionBtn({
    required this.label,
    required this.color,
    required this.enabled,
    required this.onTap,
    this.isEmoji = false,
  });

  @override
  Widget build(BuildContext context) {
    final effective = enabled ? color : Colors.grey;
    return Material(
      color: enabled
          ? color.withValues(alpha: 0.12)
          : Colors.grey.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: enabled ? onTap : null,
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: effective.withValues(alpha: enabled ? 0.6 : 0.2),
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: isEmoji
                  ? const TextStyle(fontSize: 24)
                  : GoogleFonts.outfit(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: enabled ? color : Colors.grey,
                      height: 1,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
