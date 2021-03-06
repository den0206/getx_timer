import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:getx_timer/src/screen/home/home_sceen.dart';
import 'package:getx_timer/src/screen/prepare/prepare_controller.dart';
import 'package:getx_timer/src/screen/prepare/prepare_screen.dart';
import 'package:getx_timer/src/screen/set_count/set_count_screen.dart';
import 'package:getx_timer/src/screen/timer/timer_controller.dart';
import 'package:getx_timer/src/screen/timer/timer_screen.dart';
import 'package:getx_timer/src/service/audio_managet.dart';
import 'package:getx_timer/src/service/setting_service.dart';
import 'package:getx_timer/src/utils/get_device_id.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sizer/sizer.dart';

import 'src/service/admon_service.dart';
import 'src/service/database_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  await FlutterConfig.loadEnvVariables();

  await Get.put(DatabaseService()).initStorage();
  await MobileAds.instance
      .initialize()
      .then((InitializationStatus status) async {
    final testId = await GetDeviceId.getDeviceId();

    MobileAds.instance.updateRequestConfiguration(
      RequestConfiguration(
        tagForChildDirectedTreatment: TagForChildDirectedTreatment.unspecified,
        testDeviceIds: <String>[testId],
      ),
    );

    print("$testId");
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.transparent,
            ),
            scaffoldBackgroundColor: Colors.black,
            textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: Colors.white.withOpacity(0.7),
                  displayColor: Colors.white.withOpacity(0.7),
                ),
          ),
          getPages: [
            GetPage(
              name: PrepareScreen.routeName,
              page: () => PrepareScreen(),
              binding: PrepareBinding(),
            ),
            GetPage(
              name: TimerScreen.routeName,
              page: () => TimerScreen(),
              binding: TimerBinding(),
            ),
            GetPage(
              name: SetCountScreen.routeName,
              page: () => SetCountScreen(),
              fullscreenDialog: true,
            ),
          ],
          initialBinding: InitialBinding(),
          home: HomeScreen(),
        );
      },
    );
  }
}

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AudioManager());
    Get.put(AdmobInterstialService());
    Get.lazyPut(() => SettingService(), fenix: true);
  }
}
