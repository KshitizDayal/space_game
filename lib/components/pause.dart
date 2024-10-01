import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';

import '../constants/assets.dart';
import '../game/space_game.dart';

class Pause extends SpriteComponent with HasGameRef<SpaceGame>, TapCallbacks {
  @override
  FutureOr<void> onLoad() async {
    final background = await Flame.images.load(Assets.pause);
    size = Vector2(30, 30);
    position = Vector2(gameRef.size.x / 2 * 1.6, gameRef.size.y / 2 * 0.17);
    sprite = Sprite(background);
    return super.onLoad();
  }

  void onPauseGame() {
    gameRef.pauseEngine();
    gameRef.overlays.add('gamePause');
  }

  @override
  void onTapUp(TapUpEvent event) {
    onPauseGame();
  }
}
