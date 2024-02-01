// ignore_for_file: cascade_invocations

import 'package:audioplayers/audioplayers.dart';
import 'package:flame/extensions.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_flutter_gg_challenge_24/game/game.dart';
import 'package:very_good_flutter_gg_challenge_24/l10n/l10n.dart';

class _MockAppLocalizations extends Mock implements AppLocalizations {}

class _MockAudioPlayer extends Mock implements AudioPlayer {}

class _VeryGoodFlutterGgChallenge24 extends VeryGoodFlutterGgChallenge24 {
  _VeryGoodFlutterGgChallenge24({
    required super.l10n,
    required super.effectPlayer,
    required super.textStyle,
  });

  @override
  Future<void> onLoad() async {}
}

void main() {
  final l10n = _MockAppLocalizations();
  _VeryGoodFlutterGgChallenge24 createFlameGame() {
    return _VeryGoodFlutterGgChallenge24(
      l10n: l10n,
      effectPlayer: _MockAudioPlayer(),
      textStyle: const TextStyle(),
    );
  }

  group('$CounterComponent', () {
    setUp(() {
      when(() => l10n.counterText(any())).thenAnswer(
        (invocation) => 'counterText: ${invocation.positionalArguments[0]}',
      );
    });

    testWithGame(
      'has all components',
      createFlameGame,
      (game) async {
        final component = CounterComponent(position: Vector2.all(1));
        await game.ensureAdd(component);

        expect(component.text, isNotNull);
      },
    );

    testWithGame(
      'changes text count correctly',
      createFlameGame,
      (game) async {
        final component = CounterComponent(position: Vector2.all(1));
        await game.ensureAdd(component);

        expect(component.text.text, equals(''));
        game.counter = 1;
        game.update(0.1);
        expect(component.text.text, equals('counterText: 1'));

        game.counter = 2;
        game.update(0.1);
        expect(component.text.text, equals('counterText: 2'));
      },
    );
  });
}
