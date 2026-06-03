import 'package:uuid/uuid.dart';

import '../entities/game_session.dart';
import '../entities/player.dart';

const _uuid = Uuid();

class CreateGameUseCase {
  GameSession call(List<String> playerNames) {
    assert(playerNames.length >= 2 && playerNames.length <= 6);

    final players = playerNames
        .asMap()
        .entries
        .map((e) => Player(
              id: _uuid.v4(),
              name: e.value.trim(),
              turnOrder: e.key,
            ))
        .toList();

    return GameSession(
      id: _uuid.v4(),
      players: players,
      remainingBalls: List.from(GameSession.allBalls),
      actions: const [],
      isGameOver: false,
      startTime: DateTime.now(),
    );
  }
}
