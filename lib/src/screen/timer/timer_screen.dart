import 'package:flutter/material.dart';
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
              Obx(() => Text(
                    controller.setCountString(),
                    style: TextStyle(fontSize: 15.sp),
                  )),
              Obx(
                () => BaseCirlularSlider(
                  size: 70.w,
                  trackWidth: 35,
                  animationEnable: false,
                  dragEnable: false,
                  useDot: false,
                  progressColor:
                      controller.isActive ? Colors.green : Colors.red,
                  min: 0,
                  max: controller.maxValue,
                  value: controller.count.value,
                  innerWidget: (value) {
                    return Center(
                        child: Text(
                      "${controller.count.value.ceil()} 秒",
                      style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ));
                  },
                ),
              ),
              Obx(() => Text(
                    controller.intervalText.value,
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Obx(
                    () => CustomGradientButton(
                      mainColor: controller.isPause.value
                          ? Colors.blueAccent
                          : Colors.green,
                      text: controller.isPause.value ? "Restart" : "Pause",
                      onPress: () {
                        controller.pause();
                      },
                    ),
                  ),
                  CustomGradientButton(
                    mainColor: Colors.redAccent,
                    text: "Finish",
                    onPress: () {
                      controller.confirmFinish();
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
