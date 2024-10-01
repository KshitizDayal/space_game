import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../constants/constants.dart';
import '../game/space_game.dart';
import '../constants/assets.dart';

class Obstacles extends Component with HasGameRef<SpaceGame> {
  final double stoneSize = 100.0;
  final int totalStones = 5;
  final int emptySpots = 4;
  final _random = Random();

  Obstacles();

  @override
  FutureOr<void> onLoad() {
    final heightMinusGround = gameRef.size.y -
        Constants.topHeight; // Subtract 100 from the total height
    final spacing =
        (heightMinusGround - (stoneSize * totalStones)) / (totalStones + 1);

    // Generate two random empty positions
    final List<int> emptyPositions = [];
    while (emptyPositions.length < emptySpots) {
      int randomPosition = _random.nextInt(totalStones);
      if (!emptyPositions.contains(randomPosition)) {
        emptyPositions.add(randomPosition);
      }
    }

    // Add stones at positions where there are no gaps
    for (int i = 0; i < totalStones; i++) {
      if (!emptyPositions.contains(i)) {
        // final double yPosition = (i + 1) * spacing + i * stoneSize;
        final double yPosition =
            Constants.topHeight + spacing + (i * (stoneSize + spacing));
        final ObstacleStone obstacleStone =
            ObstacleStone(y: yPosition, stoneSize: stoneSize);
        add(obstacleStone);
      }
    }

    return super.onLoad();
  }
}

class ObstacleStone extends SpriteComponent with HasGameRef<SpaceGame> {
  @override
  final double y;
  final double stoneSize;

  ObstacleStone({required this.y, required this.stoneSize})
      : super(size: Vector2.all(stoneSize));

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load(Assets.obstacle);
    super.onLoad();

    position = Vector2(gameRef.size.x, y);
    add(CircleHitbox());
  }
}
