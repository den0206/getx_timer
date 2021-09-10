import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:getx_timer/src/screen/home/home_controller.dart';
import 'package:getx_timer/src/screen/widgets/backgroung_vide._screen.dart';
import 'package:sizer/sizer.dart';
import '../widgets/base_circle.dart';
import '../widgets/custom_button.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: GetBuilder<HomeController>(
          init: HomeController(),
          autoRemove: false,
          builder: (_) {
            return BaseScreen(
              child: SafeArea(
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "活動時間",
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      BaseCirlularSlider(
                        value: controller.setting.activeTime,
                        onEnd: (value) {
                          controller.setting.activeTime = value.ceilToDouble();
                        },
                      ),
                      Text(
                        "休憩時間",
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      BaseCirlularSlider(
                        value: controller.setting.intervalTime,
                        progressColor: Colors.red,
                        onEnd: (value) {
                          controller.setting.intervalTime =
                              value.ceilToDouble();
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomGradientButton(
                            mainColor: Colors.yellowAccent,
                            text: "${controller.setting.setCount} セット",
                            onPress: () {
                              controller.setCount();
                            },
                          ),
                          CustomGradientButton(
                            mainColor: Colors.green,
                            text: "スタート",
                            onPress: () {
                              controller.start();
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
