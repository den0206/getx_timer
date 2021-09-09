import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_timer/src/service/setting_service.dart';

class DatabaseService extends GetxService {
  static DatabaseService get to => Get.find();
  final box = GetStorage();

  Future<void> initStorage() async {
    await GetStorage.init();
  }

  void setSetting(SettingService setting) {
    final value = {
      "active": setting.activeTime,
      "interval": setting.intervalTime,
      "setCount": setting.setCount
    };

    box.write("setting", value);
  }

  Map<String, dynamic>? loadSetting() {
    final key = "setting";

    if (box.read(key) == null) {
      return null;
    } else {
      Map<String, dynamic> value = box.read("setting");
      return value;
    }
  }
}
