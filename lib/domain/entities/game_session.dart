import 'dart:math';

import 'game_action.dart';
import 'player.dart';

class GameSession {
  static const List<int> allBalls = [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17];

  final String id;
  final List<Player> players;
  final List<int> remainingBalls;   // boules encore sur la table
  final List<GameAction> actions;
  final bool isGameOver;
  final String? winnerId;
  final DateTime startTime;
  final DateTime? endTime;
  final GameSession? previousState; // pour undo

  const GameSession({
    required this.id,
    required this.players,
    required this.remainingBalls,
    required this.actions,
    required this.isGameOver,
    this.winnerId,
    required this.startTime,
    this.endTime,
    this.previousState,
  });

  // ─── Computed ──────────────────────────────────────────────────────────────

  bool get allBallsPlayed => remainingBalls.isEmpty;

  int get remainingPoints =>
      remainingBalls.fold<int>(0, (sum, b) => sum + b);

  int get totalBallsPlayed =>
      allBalls.length - remainingBalls.length;

  List<Player> get activePlayers =>
      players.where((p) => !p.isEliminated).toList();

  int get leaderScore {
    final active = activePlayers;
    if (active.isEmpty) return 0;
    return active.map((p) => p.score).reduce(max);
  }

  /// Joueurs triés : actifs d'abord, puis par score décroissant
  List<Player> get rankings {
    final sorted = [...players];
    sorted.sort((a, b) {
      if (!a.isEliminated && b.isEliminated) return -1;
      if (a.isEliminated && !b.isEliminated) return 1;
      return b.score.compareTo(a.score);
    });
    return sorted;
  }

  Duration get gameDuration {
    final end = endTime ?? DateTime.now();
    return end.difference(startTime);
  }

  // ─── copyWith ──────────────────────────────────────────────────────────────

  GameSession copyWith({
    String? id,
    List<Player>? players,
    List<int>? remainingBalls,
    List<GameAction>? actions,
    bool? isGameOver,
    String? winnerId,
    DateTime? startTime,
    DateTime? endTime,
    GameSession? previousState,
    bool clearPreviousState = false,
  }) =>
      GameSession(
        id: id ?? this.id,
        players: players ?? this.players,
        remainingBalls: remainingBalls ?? this.remainingBalls,
        actions: actions ?? this.actions,
        isGameOver: isGameOver ?? this.isGameOver,
        winnerId: winnerId ?? this.winnerId,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        previousState: clearPreviousState
            ? null
            : (previousState ?? this.previousState),
      );
}
