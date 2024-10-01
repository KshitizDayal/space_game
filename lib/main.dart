import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'game/game_highscore.dart';
import 'game/space_game.dart';
import 'screens/game_pause_screen.dart';
import 'screens/game_start_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final game = SpaceGame();
  await SecureStorage.instance.checkUserHighScore();

  runApp(
    GameWidget(
      game: game,
      initialActiveOverlays: const [GameStartScreen.id],
      overlayBuilderMap: {
        'gameStart': (context, _) => GameStartScreen(game: game),
        'gamePause': (context, _) => GamePauseScreen(game: game),
      },
    ),
  );
}
