import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:getx_timer/src/screen/prepare/prepare_screen.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    /// load pref
  }

  void start() {
    Get.toNamed(PrepareScreen.routeName);
  }
}
