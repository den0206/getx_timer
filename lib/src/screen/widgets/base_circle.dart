import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class BaseCirlularSlider extends StatelessWidget {
  BaseCirlularSlider({
    Key? key,
    this.progressColor = Colors.green,
    this.dragEnable = true,
    this.trackWidth = 22,
    this.animationEnable = true,
    this.useDot = true,
    this.showTrack = true,
    this.size,
    this.min,
    this.max,
    this.value,
    this.onEnd,
    this.innerWidget,
  }) : super(key: key);

  final Color progressColor;
  final bool dragEnable;
  final double trackWidth;
  final bool animationEnable;
  final bool useDot;
  final bool showTrack;
  double? size;
  double? min;
  double? max;
  double? value;
  Function(double value)? onEnd;
  Widget Function(double value)? innerWidget;

  @override
  Widget build(BuildContext context) {
    String percentageModifier(double value) {
      final roundedValue = value.ceil().toString();
      return '$roundedValue';
    }

    return AbsorbPointer(
      absorbing: !dragEnable,
      child: SleekCircularSlider(
        appearance: CircularSliderAppearance(
          customWidths: CustomSliderWidths(
            trackWidth: trackWidth,
            progressBarWidth: trackWidth + 8,
          ),
          customColors: CustomSliderColors(
            progressBarColor: progressColor,
            trackColors: showTrack
                ? [
                    Colors.transparent,
                    Colors.white,
                  ]
                : [Colors.transparent, Colors.transparent],
            dotColor: useDot ? Colors.white : Colors.transparent,
            trackGradientStartAngle: 0,
            trackGradientEndAngle: 180,
            hideShadow: true,
          ),
          infoProperties: InfoProperties(
              bottomLabelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
              bottomLabelText: '秒',
              mainLabelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w600),
              modifier: percentageModifier),
          size: size ?? 135.sp,
          startAngle: 270,
          angleRange: 360,
          animationEnabled: animationEnable,
        ),
        min: min ?? 10,
        max: max ?? 100,
        initialValue: value ?? 20,
        onChange: (value) {},
        onChangeStart: (value) {},
        onChangeEnd: onEnd,
        innerWidget: innerWidget,
      ),
    );
  }
}
