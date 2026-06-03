import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/game_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      ref.read(themeModeProvider.notifier).state =
                          themeMode == ThemeMode.dark
                              ? ThemeMode.light
                              : ThemeMode.dark;
                    },
                    icon: Icon(
                      themeMode == ThemeMode.dark
                          ? Icons.wb_sunny_rounded
                          : Icons.dark_mode_rounded,
                    ),
                    tooltip: 'Changer le thème',
                  ),
                ],
              ),
              const Spacer(flex: 1),
              _Logo().animate().fadeIn(delay: 100.ms).slideY(begin: -0.1),
              const SizedBox(height: 10),
              Text(
                'The Kyra',
                style: GoogleFonts.outfit(
                  fontSize: 42,
                  fontWeight: FontWeight.w900,
                  color: cs.primary,
                  height: 1.0,
                ),
              ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.05),
              const SizedBox(height: 6),
              Text(
                'Compteur de score billard',
                style: GoogleFonts.outfit(
                  fontSize: 15,
                  color: cs.outline,
                  height: 1.5,
                ),
              ).animate().fadeIn(delay: 300.ms),
              const Spacer(flex: 2),
              _HomeButton(
                label: 'Nouvelle partie',
                icon: Icons.add_circle_rounded,
                isPrimary: true,
                onTap: () => context.push('/new-game'),
              ).animate().fadeIn(delay: 400.ms).slideX(begin: 0.1),
              const SizedBox(height: 12),
              _HomeButton(
                label: 'Historique',
                icon: Icons.history_rounded,
                onTap: () => context.push('/history'),
              ).animate().fadeIn(delay: 500.ms).slideX(begin: 0.1),
              const SizedBox(height: 12),
              _HomeButton(
                label: 'Statistiques',
                icon: Icons.bar_chart_rounded,
                onTap: () => context.push('/statistics'),
              ).animate().fadeIn(delay: 600.ms).slideX(begin: 0.1),
              const Spacer(flex: 1),
              // Crédit
              Center(
                child: Text(
                  'Créé par Héros Ileko',
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    color: cs.outline,
                    fontStyle: FontStyle.italic,
                  ),
                ).animate().fadeIn(delay: 800.ms),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: const Center(
        child: Text('🎱', style: TextStyle(fontSize: 38)),
      ),
    );
  }
}

class _HomeButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool isPrimary;

  const _HomeButton({
    required this.label,
    required this.icon,
    required this.onTap,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    if (isPrimary) {
      return SizedBox(
        width: double.infinity,
        child: FilledButton.icon(
          onPressed: onTap,
          icon: Icon(icon, size: 22),
          label: Text(label),
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle:
                GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
      );
    }
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 20),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          foregroundColor: cs.primary,
          side: BorderSide(color: cs.outline.withValues(alpha: 0.5)),
          textStyle:
              GoogleFonts.outfit(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
