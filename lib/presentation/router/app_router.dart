import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../screens/game_over_screen.dart';
import '../screens/game_screen.dart';
import '../screens/history_screen.dart';
import '../screens/home_screen.dart';
import '../screens/new_game_screen.dart';
import '../screens/statistics_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (_, __) => const HomeScreen(),
      ),
      GoRoute(
        path: '/new-game',
        name: 'new-game',
        builder: (_, __) => const NewGameScreen(),
      ),
      GoRoute(
        path: '/game',
        name: 'game',
        builder: (_, __) => const GameScreen(),
      ),
      GoRoute(
        path: '/game-over',
        name: 'game-over',
        builder: (_, __) => const GameOverScreen(),
      ),
      GoRoute(
        path: '/history',
        name: 'history',
        builder: (_, __) => const HistoryScreen(),
      ),
      GoRoute(
        path: '/statistics',
        name: 'statistics',
        builder: (_, __) => const StatisticsScreen(),
      ),
    ],
  );
});
