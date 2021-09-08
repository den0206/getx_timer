import 'package:flutter/material.dart';
import 'package:getx_timer/src/utils/hex_color.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class BaseCirlularSlider extends StatelessWidget {
  BaseCirlularSlider({
    Key? key,
    this.progressColor = Colors.green,
    this.size,
  }) : super(key: key);

  final Color progressColor;
  double? size;

  @override
  Widget build(BuildContext context) {
    String percentageModifier(double value) {
      final roundedValue = value.ceil().toInt().toString();
      return '$roundedValue';
    }

    return SleekCircularSlider(
      appearance: CircularSliderAppearance(
        customWidths: CustomSliderWidths(trackWidth: 22, progressBarWidth: 30),
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
      ),
      min: 0,
      max: 100,
      initialValue: 10,
      onChange: (value) {},
      onChangeStart: (value) {},
      onChangeEnd: (value) {},
    );
  }
}
