import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../data/datasources/isar_datasource.dart';
import '../../data/repositories/game_repository_impl.dart';
import '../../domain/entities/game_session.dart';
import '../../domain/repositories/game_repository.dart';
import 'game_notifier.dart';

// ─── Infrastructure ──────────────────────────────────────────────────────────

/// Provided from main.dart with the opened Isar instance
final isarProvider = Provider<Isar>((_) => throw UnimplementedError());

final isarDataSourceProvider = Provider<IsarDataSource>((ref) {
  return IsarDataSource(ref.watch(isarProvider));
});

final gameRepositoryProvider = Provider<GameRepository>((ref) {
  return GameRepositoryImpl(ref.watch(isarDataSourceProvider));
});

// ─── Game state ───────────────────────────────────────────────────────────────

final gameNotifierProvider =
    NotifierProvider<GameNotifier, GameSession?>(() => GameNotifier());

// ─── Async data ───────────────────────────────────────────────────────────────

final gameHistoryProvider = FutureProvider<List<GameSession>>((ref) {
  return ref.watch(gameRepositoryProvider).getHistory();
});

// ─── Sélection en cours sur l'écran de jeu ────────────────────────────────────

final selectedPlayerIdProvider = StateProvider<String?>((ref) => null);
final selectedBallProvider = StateProvider<int?>((ref) => null);

// ─── UI prefs ─────────────────────────────────────────────────────────────────

final themeModeProvider =
    StateProvider<ThemeMode>((ref) => ThemeMode.system);
