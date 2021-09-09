import 'dart:async';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';
import 'package:getx_timer/src/screen/timer/timer_screen.dart';

class PrepareBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PrepareController());
  }
}

class PrepareController extends GetxController {
  var count = 3.obs;

  late Timer _timer;

  @override
  void onInit() {
    super.onInit();
    startContDown();
  }

  @override
  void onClose() {
    super.onClose();
    _timer.cancel();
  }

  void startContDown() {
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        if (count > 1) {
          count--;
        } else {
          _timer.cancel();
          Get.toNamed(TimerScreen.routeName);
        }
      },
    );
  }
}
