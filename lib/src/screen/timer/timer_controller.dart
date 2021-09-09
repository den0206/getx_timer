import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:getx_timer/src/screen/home/home_sceen.dart';
import 'package:getx_timer/src/service/setting_service.dart';

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

class TimerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TimerController());
  }
}

class TimerController extends GetxController {
  final Rx<TimerState> currentState = TimerState.active.obs;
  final setting = SettingService.to;

  bool get isActive {
    return currentState.value == TimerState.active;
  }

  double get maxValue {
    if (isActive) {
      return setting.activeTime;
    } else {
      return setting.intervalTime;
    }
  }

  int get maxCount {
    return SettingService.to.setCount;
  }

  late Timer _intevalTimer;

  final RxDouble count = RxDouble(0);
  final RxBool isPause = false.obs;
  final RxInt currentSet = 1.obs;

  @override
  void onInit() {
    super.onInit();
    setCount();
    startCountDown();
  }

  @override
  void onClose() {
    _intevalTimer.cancel();
    super.onClose();
  }

  void setCount() {
    if (isActive) {
      count.value = setting.activeTime;
    } else {
      count.value = setting.intervalTime;
    }
  }

  void startCountDown() {
    _intevalTimer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        if (count > 1) {
          count.value--;
        } else if (count.value == 10) {
          print("10");
        } else {
          _intevalTimer.cancel();
          finishTimer();
        }
      },
    );
  }

  void finishTimer() {
    if (!isActive) currentSet.value++;

    if (currentSet.value <= maxCount) {
      toggleState();
      setCount();
      startCountDown();
    } else {
      Get.offAll(HomeScreen());
    }
  }

  void toggleState() {
    if (isActive) {
      currentState.value = TimerState.interval;
    } else {
      currentState.value = TimerState.active;
    }
  }

  void backRoot() {
    _intevalTimer.cancel();
    Get.offAll(HomeScreen());
  }

  void pause() {
    if (_intevalTimer.isActive) {
      isPause.value = true;
      _intevalTimer.cancel();
    } else {
      isPause.value = false;
      startCountDown();
    }
  }

  String setCountString() {
    return "$currentSet / $maxCount";
  }
}
