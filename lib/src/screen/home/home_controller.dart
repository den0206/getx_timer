import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:getx_timer/src/screen/prepare/prepare_screen.dart';
import 'package:getx_timer/src/screen/set_count/set_count_screen.dart';
import 'package:getx_timer/src/service/database_service.dart';
import 'package:getx_timer/src/service/setting_service.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}

class HomeController extends GetxController {
  final setting = SettingService.to;

  @override
  void onInit() {
    super.onInit();
  }

  void start() {
    DatabaseService.to.setSetting(setting);
    Get.toNamed(PrepareScreen.routeName);
  }

  void setCount() async {
    final setCount = await Get.toNamed(SetCountScreen.routeName);

    if (setCount != null) {
      setting.setCount = setCount;
      update();
    }
  }
}
