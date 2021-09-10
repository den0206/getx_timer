import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:getx_timer/src/screen/home/home_sceen.dart';
import 'package:getx_timer/src/screen/widgets/custom_dialog.dart';
import 'package:getx_timer/src/service/audio_managet.dart';
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
  final Rx<TimerState> timerState = TimerState.active.obs;
  final setting = SettingService.to;

  final _audio = AudioManager.to;

  bool get isActive {
    return timerState.value == TimerState.active;
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

  bool get isLastSet {
    return currentSet.value == maxCount;
  }

  RxString get intervalText {
    if (isActive) {
      return "Do It !!".obs;
    } else {
      return "Take a break".obs;
    }
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
    _audio.stopAudio();
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
      (timer) async {
        switch (count.round()) {
          case 11:
            if (timerState.value == TimerState.active)
              await _audio.playSound("boxing2.mp3");
            count.value -= 1;
            break;

          case 4:
            await _audio.playSound("start-sound.mp3");
            count.value -= 1;
            break;
          case 1:
            _intevalTimer.cancel();
            finishTimer();
            break;

          default:
            count.value -= 1;
        }
      },
    );
  }

  void finishTimer() {
    if (isLastSet) {
      currentSet.value++;
    } else if (!isActive) currentSet.value++;

    if (currentSet.value <= maxCount) {
      toggleState();
      setCount();

      /// finish sound
      startCountDown();
    } else {
      /// show AD
      backRoot();
    }
  }

  void toggleState() {
    if (isActive) {
      timerState.value = TimerState.interval;
    } else {
      timerState.value = TimerState.active;
    }
  }

  void backRoot() {
    _intevalTimer.cancel();
    Get.offAll(HomeScreen());
  }

  void confirmFinish() async {
    _audio.stopAudio();
    _intevalTimer.cancel();
    await Get.dialog(CustomDialog(
      title: "確認",
      descripon: "終了しても宜しいでしょうか？",
      mainColor: Colors.redAccent,
      onSuceed: backRoot,
      onCancel: () {
        startCountDown();
      },
      icon: Icons.cancel,
    ));
  }

  void pause() {
    _audio.stopAudio();
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

  Color progressColor() {
    if (isPause.value) {
      return Colors.blue.withOpacity(0.8);
    }
    if (isActive) {
      return Colors.green.withOpacity(0.7);
    } else {
      return Colors.red.withOpacity(0.7);
    }
  }
}
