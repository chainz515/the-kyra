import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/game_action.dart';
import '../../domain/entities/game_session.dart';
import '../../domain/usecases/create_game_usecase.dart';
import '../../domain/usecases/perform_action_usecase.dart';

class GameNotifier extends Notifier<GameSession?> {
  late final PerformActionUseCase _useCase;
  late final CreateGameUseCase _create;

  @override
  GameSession? build() {
    _useCase = PerformActionUseCase();
    _create = CreateGameUseCase();
    return null;
  }

  void startGame(List<String> playerNames) {
    state = _create(playerNames);
  }

  void clearGame() => state = null;

  /// Applique une action : joueur + boule + opération
  void applyAction(String playerId, int ball, ActionType type) {
    final s = state;
    if (s == null || s.isGameOver) return;
    state = _useCase.apply(s, playerId, ball, type);
  }

  void undo() {
    final s = state;
    if (s == null) return;
    final prev = _useCase.undo(s);
    if (prev != null) state = prev;
  }
}
