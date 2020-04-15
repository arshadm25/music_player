import 'package:flutter/material.dart';

class NeumorphicRoundSliderThumbShape extends SliderComponentShape {
  /// Create a slider thumb that draws a circle.
  const NeumorphicRoundSliderThumbShape({
    this.enabledThumbRadius = 10.0,
    this.disabledThumbRadius,
  });

  /// The preferred radius of the round thumb shape when the slider is enabled.
  ///
  /// If it is not provided, then the material default of 10 is used.
  final double enabledThumbRadius;

  /// The preferred radius of the round thumb shape when the slider is disabled.
  ///
  /// If no disabledRadius is provided, then it is equal to the
  /// [enabledThumbRadius]
  final double disabledThumbRadius;
  double get _disabledThumbRadius =>  disabledThumbRadius ?? enabledThumbRadius;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(isEnabled == true ? enabledThumbRadius : _disabledThumbRadius);
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        Animation<double> activationAnimation,
        @required Animation<double> enableAnimation,
        bool isDiscrete,
        TextPainter labelPainter,
        RenderBox parentBox,
        @required SliderThemeData sliderTheme,
        TextDirection textDirection,
        double value,
      }) {
    assert(context != null);
    assert(center != null);
    assert(enableAnimation != null);
    assert(sliderTheme != null);
    assert(sliderTheme.disabledThumbColor != null);
    assert(sliderTheme.thumbColor != null);

    final Canvas canvas = context.canvas;
    final Tween<double> radiusTween = Tween<double>(
      begin: _disabledThumbRadius,
      end: enabledThumbRadius,

    );
    final Tween<double> radiusTween1 = Tween<double>(
      begin: _disabledThumbRadius+4,
      end: enabledThumbRadius+4,

    );
    final ColorTween colorTween = ColorTween(
      begin: sliderTheme.disabledThumbColor,
      end: sliderTheme.thumbColor,
    );
    final ColorTween colorTween2 = ColorTween(
      begin: Colors.white.withOpacity(0.2),
      end: Colors.white,
    );
    canvas.drawCircle(
      center,
      radiusTween1.evaluate(enableAnimation),
      Paint()..color = colorTween2.evaluate(enableAnimation),
    );
    canvas.drawCircle(
      center,
      radiusTween1.evaluate(enableAnimation),
      Paint()..color = colorTween2.evaluate(enableAnimation)..
        strokeWidth = 4
        ..style = PaintingStyle.stroke,

    );
    canvas.drawCircle(
      center,
      radiusTween.evaluate(enableAnimation),
      Paint()..color = colorTween.evaluate(enableAnimation),
    );
  }
}