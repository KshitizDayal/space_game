import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';

import '../constants/assets.dart';
import '../constants/constants.dart';
import '../game/space_game.dart';

class Player extends SpriteComponent
    with HasGameRef<SpaceGame>, CollisionCallbacks {
  int score = 0;

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    sprite = await Sprite.load(Assets.spaceship);
    size = Vector2.all(Constants.playerheight);
    position = Vector2(75, gameRef.size.y / 2 - size.y / 2);
    anchor = Anchor.center;
    add(RectangleHitbox());
    angle = 1.5708;
  }

  void move(double delatY) {
    double newY = position.y + delatY;

    double minY = -(gameRef.size.y) + size.y / 2;
    double maxY = (gameRef.size.y) - size.y / 2;
    newY = newY.clamp(minY, maxY);

    position.y = newY;
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    // gameOver();
    gameRef.obstacleColumn.updateScore();
    FlameAudio.play(Assets.collisionAudio);
  }

  // void gameOver() {
  //   gameRef.pauseEngine();
  //   game.isHit = true;
  //   FlameAudio.play(Assets.collisionAudio);
  //   gameRef.overlays.add('gamePause');
  // }

  void resetPosition() {
    position = Vector2(75, gameRef.size.y / 2 - size.y / 2);
    score = 0;
    gameRef.resetObstacles = true;
  }
}
