import 'package:billard_score/domain/entities/game_action.dart';
import 'package:billard_score/domain/entities/game_session.dart';
import 'package:billard_score/domain/entities/player.dart';
import 'package:billard_score/domain/usecases/perform_action_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

GameSession _makeSession({List<Player>? players}) {
  final ps = players ??
      [
        const Player(id: 'p1', name: 'Alice', turnOrder: 0),
        const Player(id: 'p2', name: 'Bob', turnOrder: 1),
      ];
  return GameSession(
    id: 'test',
    players: ps,
    remainingBalls: List.from(GameSession.allBalls),
    actions: const [],
    isGameOver: false,
    startTime: DateTime(2024),
  );
}

void main() {
  late PerformActionUseCase useCase;
  setUp(() => useCase = PerformActionUseCase());

  group('scored (+)', () {
    test('ajoute la valeur de la boule au score', () {
      final s = _makeSession();
      final r = useCase.apply(s, 'p1', 9, ActionType.scored);
      expect(r.players.first.score, 9);
    });

    test('retire la boule des remainingBalls', () {
      final s = _makeSession();
      final r = useCase.apply(s, 'p1', 9, ActionType.scored);
      expect(r.remainingBalls, isNot(contains(9)));
    });

    test('ne touche pas au score des autres joueurs', () {
      final s = _makeSession();
      final r = useCase.apply(s, 'p1', 9, ActionType.scored);
      expect(r.players.last.score, 0);
    });
  });

  group('fault (−)', () {
    test('soustrait la valeur de la boule', () {
      final s = _makeSession();
      final r = useCase.apply(s, 'p1', 12, ActionType.fault);
      expect(r.players.first.score, -12);
    });

    test('la boule RESTE sur la table (boule non jouée)', () {
      final s = _makeSession();
      final r = useCase.apply(s, 'p1', 12, ActionType.fault);
      // La faute ne retire pas la boule — elle reste disponible
      expect(r.remainingBalls, contains(12));
    });
  });

  group('ballWhite (⚡)', () {
    test('ne change pas le score', () {
      final s = _makeSession();
      final r = useCase.apply(s, 'p1', 10, ActionType.ballWhite);
      expect(r.players.first.score, 0);
    });

    test('retire la boule des remainingBalls', () {
      final s = _makeSession();
      final r = useCase.apply(s, 'p1', 10, ActionType.ballWhite);
      expect(r.remainingBalls, isNot(contains(10)));
    });
  });

  group('ballWhite (⚡)', () {
    test('ne change pas le score', () {
      final s = _makeSession();
      final r = useCase.apply(s, 'p1', 10, ActionType.ballWhite);
      expect(r.players.first.score, 0);
    });

    test('retire la boule des remainingBalls', () {
      final s = _makeSession();
      final r = useCase.apply(s, 'p1', 10, ActionType.ballWhite);
      expect(r.remainingBalls, isNot(contains(10)));
    });
  });

  group('undo', () {
    test('restaure l\'état précédent', () {
      final s = _makeSession();
      final after = useCase.apply(s, 'p1', 9, ActionType.scored);
      final undone = useCase.undo(after);
      expect(undone?.players.first.score, 0);
      expect(undone?.remainingBalls, contains(9));
    });

    test('retourne null sans état précédent', () {
      final s = _makeSession();
      expect(useCase.undo(s), null);
    });
  });

  group('élimination', () {
    test('élimine si maxAchievable <= leaderScore', () {
      // Alice: 100, Bob: 0, seule boule 17 reste (17 pts)
      // maxAchievable[Bob] = 0 + 17 = 17 <= 100 → éliminé
      final players = [
        const Player(id: 'p1', name: 'Alice', score: 100, turnOrder: 0),
        const Player(id: 'p2', name: 'Bob', score: 0, turnOrder: 1),
      ];
      final s = GameSession(
        id: 'test',
        players: players,
        remainingBalls: const [17],
        actions: const [],
        isGameOver: false,
        startTime: DateTime(2024),
      );
      // Alice joue la 17 → remaining = 0 → Bob maxAchievable = 0 ≤ 117
      // Même sans action, l'élimination est recalculée sur la partie avec 17 seulement
      // Bob: 0 + 17 = 17 <= 100 → éliminé
      final r = useCase.apply(s, 'p2', 17, ActionType.fault); // -17, Bob = -17
      // Avec remaining = 0, game over → vérifier
      expect(r.isGameOver, true);
    });

    test('ne pas éliminer si le joueur peut encore dépasser', () {
      final players = [
        const Player(id: 'p1', name: 'Alice', score: 50, turnOrder: 0),
        const Player(id: 'p2', name: 'Bob', score: 30, turnOrder: 1),
      ];
      final s = _makeSession(players: players);
      // remaining = 132, Bob.max = 162 > 50 → pas éliminé
      final r = useCase.apply(s, 'p1', 7, ActionType.scored);
      expect(r.players.last.isEliminated, false);
    });
  });

  group('fin de partie', () {
    test('fin quand toutes les boules jouées', () {
      // Ne reste que la 17
      final s = GameSession(
        id: 'test',
        players: [
          const Player(id: 'p1', name: 'Alice', score: 50, turnOrder: 0),
          const Player(id: 'p2', name: 'Bob', score: 30, turnOrder: 1),
        ],
        remainingBalls: const [17],
        actions: const [],
        isGameOver: false,
        startTime: DateTime(2024),
      );
      final r = useCase.apply(s, 'p1', 17, ActionType.scored);
      expect(r.isGameOver, true);
      expect(r.winnerId, 'p1'); // Alice: 67 pts > Bob: 30 pts
    });
  });

  group('remainingPoints', () {
    test('calcule le total des boules restantes', () {
      final s = _makeSession();
      expect(s.remainingPoints, 132); // 7+8+…+17
    });

    test('diminue quand une boule est jouée', () {
      final s = _makeSession();
      final r = useCase.apply(s, 'p1', 9, ActionType.scored);
      expect(r.remainingPoints, 123); // 132 - 9
    });
  });
}
