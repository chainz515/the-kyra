import 'package:isar/isar.dart';

import '../../domain/entities/game_action.dart';
import '../../domain/entities/game_session.dart';
import '../../domain/entities/player.dart';
import '../models/game_session_model.dart';

class IsarDataSource {
  final Isar _isar;

  IsarDataSource(this._isar);

  Future<void> saveGame(GameSession session) async {
    final model = _toModel(session);
    await _isar.writeTxn(() => _isar.gameSessionModels.put(model));
  }

  Future<List<GameSession>> getAllSessions() async {
    final models = await _isar.gameSessionModels.where().findAll();
    final sessions = models.map(_fromModel).toList();
    sessions.sort((a, b) => b.startTime.compareTo(a.startTime));
    return sessions;
  }

  Future<GameSession?> getSessionById(String gameId) async {
    final model = await _isar.gameSessionModels
        .filter()
        .gameIdEqualTo(gameId)
        .findFirst();
    return model != null ? _fromModel(model) : null;
  }

  Future<void> deleteSession(String gameId) async {
    await _isar.writeTxn(() async {
      final id = await _isar.gameSessionModels
          .filter()
          .gameIdEqualTo(gameId)
          .isarIdProperty()
          .findFirst();
      if (id != null) await _isar.gameSessionModels.delete(id);
    });
  }

  // ─── Mapping ───────────────────────────────────────────────────────────────

  GameSessionModel _toModel(GameSession s) => GameSessionModel()
    ..gameId = s.id
    ..startTime = s.startTime
    ..endTime = s.endTime
    ..winnerId = s.winnerId
    ..isGameOver = s.isGameOver
    ..players = s.players
        .map((p) => PlayerRecord()
          ..playerId = p.id
          ..name = p.name
          ..score = p.score
          ..isEliminated = p.isEliminated
          ..turnOrder = p.turnOrder)
        .toList()
    ..actions = s.actions
        .map((a) => ActionRecord()
          ..actionId = a.id
          ..playerId = a.playerId
          ..playerName = a.playerName
          ..actionType = a.type.name
          ..expectedBallValue = a.ballValue
          ..scoreDelta = a.scoreDelta
          ..ballIndexBefore = 0
          ..timestamp = a.timestamp)
        .toList();

  GameSession _fromModel(GameSessionModel m) {
    final players = (m.players.toList()
          ..sort((a, b) => a.turnOrder.compareTo(b.turnOrder)))
        .map((p) => Player(
              id: p.playerId,
              name: p.name,
              score: p.score,
              isEliminated: p.isEliminated,
              turnOrder: p.turnOrder,
            ))
        .toList();

    final actions = (m.actions.toList()
          ..sort((a, b) => a.timestamp.compareTo(b.timestamp)))
        .map((a) => GameAction(
              id: a.actionId,
              playerId: a.playerId,
              playerName: a.playerName,
              type: ActionType.values.firstWhere(
                (t) => t.name == a.actionType,
                orElse: () => ActionType.scored,
              ),
              ballValue: a.expectedBallValue,
              scoreDelta: a.scoreDelta,
              timestamp: a.timestamp,
            ))
        .toList();

    return GameSession(
      id: m.gameId,
      players: players,
      remainingBalls: const [],   // partie terminée
      actions: actions,
      isGameOver: m.isGameOver,
      winnerId: m.winnerId,
      startTime: m.startTime,
      endTime: m.endTime,
    );
  }
}
