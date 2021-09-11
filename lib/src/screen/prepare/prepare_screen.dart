import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:getx_timer/src/screen/prepare/prepare_controller.dart';
import 'package:getx_timer/src/screen/widgets/backgroung_vide._screen.dart';
import 'package:getx_timer/src/service/admon_service.dart';
import 'package:sizer/sizer.dart';

class PrepareScreen extends GetView<PrepareController> {
  const PrepareScreen({Key? key}) : super(key: key);

  static const routeName = '/PrepareScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundVideoScreen(),
          Center(
            child: Obx(
              () => Text(
                controller.count.toString(),
                style: TextStyle(fontSize: 100.sp, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            child: AppBar(
              elevation: 0,
              title: AdmobBannerService.to.myBannerAd,
            ),
          )
        ],
      ),
    );
  }
}
