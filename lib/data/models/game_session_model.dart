import 'package:isar/isar.dart';

part 'game_session_model.g.dart';

@Collection()
class GameSessionModel {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String gameId;

  late DateTime startTime;
  DateTime? endTime;
  String? winnerId;
  bool isGameOver = false;

  late List<PlayerRecord> players;
  late List<ActionRecord> actions;
}

@Embedded()
class PlayerRecord {
  late String playerId;
  late String name;
  int score = 0;
  bool isEliminated = false;
  int turnOrder = 0;
}

@Embedded()
class ActionRecord {
  late String actionId;
  late String playerId;
  late String playerName;
  late String actionType;
  int expectedBallValue = 0;
  int? wrongBallValue;
  int scoreDelta = 0;
  int ballIndexBefore = 0;
  late DateTime timestamp;
}
