import '../entities/game_session.dart';

abstract class GameRepository {
  Future<void> saveGame(GameSession session);
  Future<List<GameSession>> getHistory();
  Future<GameSession?> getGameById(String id);
  Future<void> deleteGame(String id);
}
