import 'package:uuid/uuid.dart';

import '../entities/game_action.dart';
import '../entities/game_session.dart';
import '../entities/player.dart';

const _uuid = Uuid();

class PerformActionUseCase {
  /// Action principale : joueur + boule + opération
  GameSession apply(
    GameSession session,
    String playerId,
    int ball,
    ActionType type,
  ) {
    final player =
        session.players.firstWhere((p) => p.id == playerId);

    final delta = switch (type) {
      ActionType.scored    => ball,
      ActionType.fault     => -ball,
      ActionType.ballWhite => 0,
    };

    final action = GameAction(
      id: _uuid.v4(),
      playerId: playerId,
      playerName: player.name,
      type: type,
      ballValue: ball,
      scoreDelta: delta,
      timestamp: DateTime.now(),
    );

    final updatedPlayers =
        _applyDelta(session.players, playerId, delta);

    // La boule est retirée SEULEMENT si scored (+) ou ballWhite (⚡)
    // Pour une faute (-) la boule reste sur la table
    final newRemaining = (type == ActionType.scored || type == ActionType.ballWhite)
        ? session.remainingBalls.where((b) => b != ball).toList()
        : session.remainingBalls;

    var next = session.copyWith(
      players: updatedPlayers,
      remainingBalls: newRemaining,
      actions: [...session.actions, action],
      previousState: _snapshot(session),
    );

    next = _checkEliminations(next);
    next = _checkGameOver(next);
    return next;
  }

  /// Undo une action (un niveau)
  GameSession? undo(GameSession session) => session.previousState;

  // ─── Helpers ───────────────────────────────────────────────────────────────

  List<Player> _applyDelta(
          List<Player> players, String playerId, int delta) =>
      players
          .map((p) =>
              p.id == playerId ? p.copyWith(score: p.score + delta) : p)
          .toList();

  GameSession _checkEliminations(GameSession s) {
    final active = s.activePlayers;
    if (active.length <= 1) return s;

    final leaderScore = s.leaderScore;
    final remaining = s.remainingPoints;

    final updated = s.players.map((p) {
      if (p.isEliminated) return p;
      if (p.score + remaining <= leaderScore && p.score < leaderScore) {
        return p.copyWith(isEliminated: true);
      }
      return p;
    }).toList();

    if (updated.every((p) => p.isEliminated)) return s;
    return s.copyWith(players: updated);
  }

  GameSession _checkGameOver(GameSession s) {
    if (s.allBallsPlayed || s.activePlayers.length <= 1) {
      return _endGame(s);
    }
    return s;
  }

  GameSession _endGame(GameSession s) {
    final candidates =
        s.activePlayers.isNotEmpty ? s.activePlayers : s.players;
    final winner =
        candidates.reduce((a, b) => a.score >= b.score ? a : b);
    return s.copyWith(
      isGameOver: true,
      winnerId: winner.id,
      endTime: DateTime.now(),
    );
  }

  GameSession _snapshot(GameSession s) =>
      s.copyWith(clearPreviousState: true);
}
