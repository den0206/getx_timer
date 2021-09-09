import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:getx_timer/src/screen/home/home_controller.dart';

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
            return SafeArea(
              child: Container(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("稼働時間"),
                    BaseCirlularSlider(
                      value: controller.setting.activeTime,
                      onEnd: (value) {
                        controller.setting.activeTime = value.ceilToDouble();
                      },
                    ),
                    Text("休憩時間"),
                    BaseCirlularSlider(
                      value: controller.setting.intervalTime,
                      progressColor: Colors.red,
                      onEnd: (value) {
                        controller.setting.intervalTime = value.ceilToDouble();
                      },
                    ),
                    CustomGradientButton(
                      mainColor: Colors.deepPurple,
                      text: "${controller.setting.setCount} セット",
                      onPress: () {
                        controller.setCount();
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomGradientButton(
                          mainColor: Colors.yellow,
                          text: "Save",
                          onPress: () {},
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
            );
          },
        ));
  }
}
