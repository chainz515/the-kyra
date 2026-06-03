import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_constants.dart';
import '../providers/game_providers.dart';

class NewGameScreen extends ConsumerStatefulWidget {
  const NewGameScreen({super.key});

  @override
  ConsumerState<NewGameScreen> createState() => _NewGameScreenState();
}

class _NewGameScreenState extends ConsumerState<NewGameScreen> {
  int _playerCount = 2;
  final List<TextEditingController> _controllers = List.generate(
    6,
    (i) => TextEditingController(text: 'Joueur ${i + 1}'),
  );
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _startGame() {
    if (!_formKey.currentState!.validate()) return;
    final names =
        _controllers.take(_playerCount).map((c) => c.text.trim()).toList();
    ref.read(gameNotifierProvider.notifier).startGame(names);
    context.go('/game');
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('The Kyra — Nouvelle partie'),
        leading: BackButton(onPressed: () => context.pop()),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Nombre de joueurs',
              style: GoogleFonts.outfit(
                  fontSize: 15, fontWeight: FontWeight.w600),
            ).animate().fadeIn(),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (i) {
                final count = i + 2;
                final selected = _playerCount == count;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: GestureDetector(
                    onTap: () => setState(() => _playerCount = count),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selected
                            ? cs.primary
                            : cs.surfaceContainerHighest,
                        border: selected
                            ? Border.all(color: cs.primary, width: 3)
                            : null,
                        boxShadow: selected
                            ? [
                                BoxShadow(
                                    color: cs.primary.withValues(alpha: 0.4),
                                    blurRadius: 8)
                              ]
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          '$count',
                          style: GoogleFonts.outfit(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: selected ? Colors.white : cs.onSurface,
                          ),
                        ),
                      ),
                    ),
                  ).animate(key: ValueKey(count)).fadeIn(delay: (i * 60).ms),
                );
              }),
            ),
            const SizedBox(height: 28),
            Text(
              'Noms des joueurs',
              style: GoogleFonts.outfit(
                  fontSize: 15, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            ...List.generate(_playerCount, (i) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: TextFormField(
                  controller: _controllers[i],
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: 'Joueur ${i + 1}',
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'Le nom est requis';
                    }
                    return null;
                  },
                ).animate(key: ValueKey(i))
                    .fadeIn(delay: (i * 80 + 200).ms)
                    .slideX(begin: 0.05),
              );
            }),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: cs.primaryContainer.withValues(alpha: 0.5),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 18, color: cs.primary),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Les boules 7 à 17 seront jouées dans l'ordre.\nTotal disponible : ${AppConstants.totalPoints} points.",
                      style: GoogleFonts.outfit(
                          fontSize: 12, color: cs.onPrimaryContainer),
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 500.ms),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _startGame,
                icon: const Icon(Icons.play_circle_filled_rounded),
                label: const Text('Lancer la partie'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: GoogleFonts.outfit(
                      fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1),
            ),
          ],
        ),
      ),
    );
  }
}
