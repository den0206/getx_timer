import 'dart:io';

import 'package:advertising_id/advertising_id.dart';
import 'package:device_info/device_info.dart';

class GetDeviceId {
  static Future<String> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor;
    } else if (Platform.isAndroid) {
      String? id = await AdvertisingId.id(true);

      return id ?? "";
    } else {
      return "";
    }
  }
}
