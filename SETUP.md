# Billard Score 7-17 — Guide de démarrage

## 1. Prérequis
- Flutter 3.x installé (`flutter --version`)
- Un émulateur Android / iOS ou un appareil physique

## 2. Installation des dépendances

```bash
cd "the kira"
flutter pub get
```

## 3. Génération du code Isar (OBLIGATOIRE)

```bash
dart run build_runner build --delete-conflicting-outputs
```

Cela génère le fichier `lib/data/models/game_session_model.g.dart`
qui est requis pour la base de données locale.

## 4. Lancer l'application

```bash
flutter run
```

## 5. Lancer les tests

```bash
flutter test
```

---

## Architecture

```
lib/
├── core/               ← Constantes, thème, extensions
├── domain/             ← Entités, repository abstrait, use cases (pur Dart)
│   ├── entities/
│   ├── repositories/
│   └── usecases/
├── data/               ← Modèles Isar, implémentations
│   ├── models/         ← game_session_model.dart + .g.dart (généré)
│   ├── datasources/
│   └── repositories/
└── presentation/       ← Riverpod, écrans, widgets, router
    ├── providers/
    ├── screens/
    ├── widgets/
    └── router/
```

## Règles du jeu implémentées

| Action | Effet sur le score | Boule suivante |
|---|---|---|
| Boule réussie | +valeur boule | Oui |
| Mauvaise boule | -valeur mauvaise boule | Non |
| Blanche entrée | -valeur boule attendue | Non |
| Boule + blanche | 0 | Oui |
| Joueur suivant | 0 | Non |

**Élimination automatique** : si `score + points_restants <= score_leader`
