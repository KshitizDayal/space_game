import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../game/space_game.dart';
import '../game/game_highscore.dart';

class GameStartScreen extends StatelessWidget {
  final SpaceGame game;
  static const String id = "gameStart";

  const GameStartScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    game.pauseEngine();
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 40),
              const Text(
                "Spaceship Game",
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Game",
                  color: ColorsAsset.primary,
                ),
              ),
              const SizedBox(height: 40),
              Image.asset(
                "assets/images/spaceship.png",
                height: 200,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: startGame,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsAsset.secondary,
                ),
                child: const Text(
                  "Press here to start the game",
                  style: TextStyle(fontSize: 20, color: ColorsAsset.text),
                ),
              ),
              const SizedBox(height: 60),
              Text(
                "Highest Score: ${SecureStorage.instance.highestScore}",
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: ColorsAsset.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void startGame() {
    game.overlays.remove("gameStart");
    game.resumeEngine();
  }
}
