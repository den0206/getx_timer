import 'package:flutter/material.dart';
import 'package:getx_timer/src/utils/hex_color.dart';
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
  double? size;
  double? min;
  double? max;
  double? value;
  Function(double value)? onEnd;
  Widget Function(double)? innerWidget;

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
              trackWidth: trackWidth, progressBarWidth: trackWidth + 8),
          customColors: CustomSliderColors(
            progressBarColor: progressColor,
            trackColors: [
              Colors.transparent,
              Colors.white,
            ],
            trackGradientStartAngle: 0,
            trackGradientEndAngle: 180,
            hideShadow: true,
          ),
          infoProperties: InfoProperties(
              bottomLabelStyle: TextStyle(
                  color: HexColor('#6DA100'),
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
              bottomLabelText: '秒',
              mainLabelStyle: TextStyle(
                  color: HexColor('#54826D'),
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
