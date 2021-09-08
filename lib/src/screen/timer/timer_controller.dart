import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:getx_timer/src/screen/home/home_sceen.dart';

enum TimerState {
  active,
  interval,
}

extension TimerStateEXT on TimerState {
  Color get circleColor {
    switch (this) {
      case TimerState.active:
        return Colors.green;
      case TimerState.interval:
        return Colors.red;
    }
  }
}

class TimerController extends GetxController {
  final Rx<TimerState> currentState = TimerState.active.obs;

  bool get isActive {
    return currentState.value == TimerState.active;
  }

  @override
  void onInit() {
    super.onInit();
  }

  void toggleState() {
    if (isActive) {
      currentState.value = TimerState.interval;
    } else {
      currentState.value = TimerState.active;
    }
  }

  void backRoot() {
    Get.offAll(HomeScreen());
  }
}
