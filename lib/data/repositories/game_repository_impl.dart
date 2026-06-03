import '../../domain/entities/game_session.dart';
import '../../domain/repositories/game_repository.dart';
import '../datasources/isar_datasource.dart';

class GameRepositoryImpl implements GameRepository {
  final IsarDataSource _ds;

  GameRepositoryImpl(this._ds);

  @override
  Future<void> saveGame(GameSession session) => _ds.saveGame(session);

  @override
  Future<List<GameSession>> getHistory() => _ds.getAllSessions();

  @override
  Future<GameSession?> getGameById(String id) => _ds.getSessionById(id);

  @override
  Future<void> deleteGame(String id) => _ds.deleteSession(id);
}
