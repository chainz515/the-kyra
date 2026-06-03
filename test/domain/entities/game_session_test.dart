import 'package:billard_score/domain/entities/game_session.dart';
import 'package:billard_score/domain/entities/player.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final players = [
    const Player(id: 'p1', name: 'Alice', score: 20, turnOrder: 0),
    const Player(id: 'p2', name: 'Bob', score: 35, turnOrder: 1),
    const Player(
        id: 'p3',
        name: 'Charlie',
        score: 10,
        isEliminated: true,
        turnOrder: 2),
  ];

  late GameSession session;
  setUp(() {
    session = GameSession(
      id: 'test',
      players: players,
      remainingBalls: const [10, 11, 12, 13, 14, 15, 16, 17],
      actions: const [],
      isGameOver: false,
      startTime: DateTime(2024),
    );
  });

  test('allBallsPlayed est false quand des boules restent', () {
    expect(session.allBallsPlayed, false);
  });

  test('allBallsPlayed est true quand remainingBalls est vide', () {
    final done = session.copyWith(remainingBalls: []);
    expect(done.allBallsPlayed, true);
  });

  test('activePlayers exclut les joueurs éliminés', () {
    expect(session.activePlayers.length, 2);
    expect(session.activePlayers.any((p) => p.name == 'Charlie'), false);
  });

  test('leaderScore retourne le score le plus élevé parmi les actifs', () {
    expect(session.leaderScore, 35); // Bob
  });

  test('remainingPoints calcule la somme des boules restantes', () {
    // 10+11+12+13+14+15+16+17 = 108
    expect(session.remainingPoints, 108);
  });

  test('totalBallsPlayed retourne le nombre de boules jouées', () {
    // allBalls = 11, remaining = 8 → played = 3
    expect(session.totalBallsPlayed, 3);
  });

  test('rankings trie actifs d\'abord puis par score décroissant', () {
    final ranked = session.rankings;
    expect(ranked.first.name, 'Bob');
    expect(ranked[1].name, 'Alice');
    expect(ranked.last.name, 'Charlie');
  });

  test('gameDuration retourne la bonne durée', () {
    final s = GameSession(
      id: 'test',
      players: players,
      remainingBalls: const [],
      actions: const [],
      isGameOver: true,
      startTime: DateTime(2024, 1, 1, 10, 0),
      endTime: DateTime(2024, 1, 1, 10, 15),
    );
    expect(s.gameDuration.inMinutes, 15);
  });

  test('copyWith préserve previousState par défaut', () {
    final prev = session.copyWith(remainingBalls: [7, 8]);
    final withPrev = session.copyWith(previousState: prev);
    final copy = withPrev.copyWith(remainingBalls: [7]);
    expect(copy.previousState, prev);
  });

  test('clearPreviousState efface previousState', () {
    final prev = session.copyWith(remainingBalls: [7, 8]);
    final withPrev = session.copyWith(previousState: prev);
    final copy = withPrev.copyWith(clearPreviousState: true);
    expect(copy.previousState, null);
  });
}
