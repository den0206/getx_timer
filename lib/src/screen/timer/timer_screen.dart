import 'package:flutter/material.dart';
import 'package:getx_timer/src/screen/home/home_sceen.dart';
import 'package:getx_timer/src/screen/timer/timer_controller.dart';
import 'package:getx_timer/src/screen/widgets/base_circle.dart';
import 'package:getx_timer/src/screen/widgets/custom_button.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class TimerScreen extends GetView<TimerController> {
  const TimerScreen({Key? key}) : super(key: key);

  static const routeName = '/TimerScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "セット数 3 /3",
                style: TextStyle(fontSize: 15.sp),
              ),
              Obx(
                () => BaseCirlularSlider(
                  size: 70.w,
                  progressColor:
                      controller.isActive ? Colors.green : Colors.red,
                ),
              ),
              Text(
                "Do It !!",
                style: TextStyle(
                  fontSize: 35.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomGradientButton(
                    mainColor: Colors.yellow,
                    text: "Pause",
                    onPress: () {
                      controller.toggleState();
                    },
                  ),
                  CustomGradientButton(
                    mainColor: Colors.blueAccent,
                    text: "Finish",
                    onPress: () {
                      controller.backRoot();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
