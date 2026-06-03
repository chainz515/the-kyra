enum ActionType {
  scored,    // + : joueur marque (score += ballValue)
  fault,     // − : faute/blanche (score -= ballValue)
  ballWhite, // ⚡: boule + blanche (score += 0, boule retirée)
}

extension ActionTypeX on ActionType {
  String get label {
    switch (this) {
      case ActionType.scored:    return 'Boule réussie';
      case ActionType.fault:     return 'Faute / Blanche';
      case ActionType.ballWhite: return 'Boule + Blanche';
    }
  }

  String get shortLabel {
    switch (this) {
      case ActionType.scored:    return '+';
      case ActionType.fault:     return '−';
      case ActionType.ballWhite: return '⚡';
    }
  }
}

class GameAction {
  final String id;
  final String playerId;
  final String playerName;
  final ActionType type;
  final int ballValue;   // quelle boule était impliquée
  final int scoreDelta;  // +ballValue, -ballValue, ou 0
  final DateTime timestamp;

  const GameAction({
    required this.id,
    required this.playerId,
    required this.playerName,
    required this.type,
    required this.ballValue,
    required this.scoreDelta,
    required this.timestamp,
  });
}
