import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:getx_timer/src/service/database_service.dart';

class SettingService extends GetxService {
  static SettingService get to => Get.find();

  double activeTime = 30;
  double intervalTime = 30;

  int setCount = 3;

  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  void loadSettings() {
    final value = DatabaseService.to.loadSetting();
    if (value != null) {
      this.activeTime = value["active"];
      this.intervalTime = value["interval"];
      this.setCount = value["setCount"];
    }
  }
}
