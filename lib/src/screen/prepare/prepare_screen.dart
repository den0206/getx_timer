import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:getx_timer/src/screen/prepare/prepare_controller.dart';
import 'package:sizer/sizer.dart';

class PrepareScreen extends GetView<PrepareController> {
  const PrepareScreen({Key? key}) : super(key: key);

  static const routeName = '/PrepareScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Obx(
          () => Text(
            controller.count.toString(),
            style: TextStyle(fontSize: 100.sp),
          ),
        ),
      ),
    );
  }
}
