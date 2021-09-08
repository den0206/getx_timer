import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:getx_timer/src/screen/home/home_controller.dart';
import 'package:getx_timer/src/screen/home/home_sceen.dart';
import 'package:getx_timer/src/screen/prepare/prepare_controller.dart';
import 'package:getx_timer/src/screen/prepare/prepare_screen.dart';
import 'package:getx_timer/src/screen/timer/timer_controller.dart';
import 'package:getx_timer/src/screen/timer/timer_screen.dart';
import 'package:sizer/sizer.dart';

void main() {
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
                  bodyColor: Colors.white,
                  displayColor: Colors.white,
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
            )
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
    Get.put(HomeController());
    Get.lazyPut(() => PrepareController());
    Get.lazyPut(() => TimerController());
  }
}