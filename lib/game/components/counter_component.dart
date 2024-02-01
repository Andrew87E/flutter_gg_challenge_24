import 'package:flame/components.dart';
import 'package:very_good_flutter_gg_challenge_24/game/game.dart';

class CounterComponent extends PositionComponent
    with HasGameRef<VeryGoodFlutterGgChallenge24> {
  CounterComponent({
    required super.position,
  }) : super(anchor: Anchor.center);

  late final TextComponent text;

  @override
  Future<void> onLoad() async {
    await add(
      text = TextComponent(
        anchor: Anchor.center,
        textRenderer: TextPaint(
          style: game.textStyle,
        ),
      ),
    );
  }

  @override
  void update(double dt) {
    text.text = gameRef.l10n.counterText(gameRef.counter);
  }
}
