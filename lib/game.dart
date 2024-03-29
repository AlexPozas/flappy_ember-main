import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flappy_ember/box_stack.dart';
import 'package:flappy_ember/ground.dart';
import 'package:flappy_ember/player.dart';

import 'sky.dart';
import 'box_stack.dart';

class FlappyEmber extends FlameGame with TapDetector, HasCollisionDetection {
  late final Player player;
  double speed = 500;
  final random = Random();
  @override
  Future<void>? onLoad() async {
    player = Player();
    add(Sky());
    add(Ground());
    add(ScreenHitbox());
    add(player);
    return null;
  }

  void gameover() {
    pauseEngine();
  }

  double _timeSinceBox = 0;
  double _boxInterval = 1;
  @override
  void update(double dt) {
    super.update(dt);
    speed += 10 * dt;
    _timeSinceBox += dt;

    if (_timeSinceBox > _boxInterval) {
      add(BoxStack(isBottom: random.nextBool()));
      _timeSinceBox = 0;
    }
  }

  @override
  void onTap() {
    super.onTap();
    player.fly();
  }
}
