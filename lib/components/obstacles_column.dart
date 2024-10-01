import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../constants/constants.dart';
import '../game/space_game.dart';

import 'obstacles.dart';

class ObstacleColumn extends PositionComponent
    with HasGameRef<SpaceGame>, CollisionCallbacks {
  ObstacleColumn();

  @override
  Future<void> onLoad() async {
    position.x = gameRef.size.x;

    addAll([
      Obstacles(),
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= Constants.gameSpeed * dt;

    if (gameRef.isHit == true) {
      removeFromParent();
      gameRef.isHit = false;
    }

    if (position.x < -gameRef.size.x - Constants.obstacleSize) {
      removeFromParent();
    }

    if (gameRef.resetObstacles) {
      removeFromParent();
      gameRef.resetObstacles = false;
    }
  }

  void updateScore() {
    gameRef.isHit = true;
    gameRef.player.score += 1;

    // FlameAudio.play(Assets.pointAudio);
  }
}
