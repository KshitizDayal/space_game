import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../game/game_highscore.dart';
import '../game/space_game.dart';

class GamePauseScreen extends StatelessWidget {
  final SpaceGame game;
  static const String id = "gamePause";
  const GamePauseScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black38,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Game Paused",
              style: TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
                fontFamily: "Game",
                color: ColorsAsset.primary,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Current Score: ${game.player.score}",
              style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Game",
                  color: ColorsAsset.tertiary),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: resumeGame,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsAsset.secondary,
              ),
              child: const Text(
                "Resume",
                style: TextStyle(fontSize: 20, color: ColorsAsset.text),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: restartGame,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsAsset.secondary,
              ),
              child: const Text(
                "Restart",
                style: TextStyle(fontSize: 20, color: ColorsAsset.text),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: homeScreen,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsAsset.secondary,
              ),
              child: const Text(
                "Home Screen",
                style: TextStyle(fontSize: 20, color: ColorsAsset.text),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void restartGame() async {
    if (int.parse(SecureStorage.instance.highestScore) < game.player.score) {
      SecureStorage.instance.storeHighScore(game.player.score.toString());
    }
    game.player.resetPosition();
    game.overlays.remove('gamePause');
    game.resumeEngine();
  }

  void homeScreen() {
    if (int.parse(SecureStorage.instance.highestScore) < game.player.score) {
      SecureStorage.instance.storeHighScore(game.player.score.toString());
    }
    game.overlays.remove('gamePause');
    game.player.resetPosition();
    game.overlays.add('gameStart');
  }

  void resumeGame() {
    game.overlays.remove('gamePause');
    game.resumeEngine();
  }
}
