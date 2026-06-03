class Player {
  final String id;
  final String name;
  final int score;
  final bool isEliminated;
  final int turnOrder;

  const Player({
    required this.id,
    required this.name,
    this.score = 0,
    this.isEliminated = false,
    required this.turnOrder,
  });

  Player copyWith({
    String? id,
    String? name,
    int? score,
    bool? isEliminated,
    int? turnOrder,
  }) =>
      Player(
        id: id ?? this.id,
        name: name ?? this.name,
        score: score ?? this.score,
        isEliminated: isEliminated ?? this.isEliminated,
        turnOrder: turnOrder ?? this.turnOrder,
      );

  int maxAchievable(int remainingPoints) => score + remainingPoints;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Player && id == other.id);

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Player($name, score: $score, eliminated: $isEliminated)';
}
