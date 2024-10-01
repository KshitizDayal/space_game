import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';

import '../constants/assets.dart';
import '../game/space_game.dart';

class Background extends SpriteComponent with HasGameRef<SpaceGame> {
  Background();

  @override
  FutureOr<void> onLoad() async {
    final background = await Flame.images.load(Assets.background);
    size = gameRef.size;
    sprite = Sprite(background);
    return super.onLoad();
  }
}
