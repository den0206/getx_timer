import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:getx_timer/src/service/setting_service.dart';
import 'package:get/get.dart';

class SetCountScreen extends StatelessWidget {
  const SetCountScreen({Key? key}) : super(key: key);

  static const routeName = '/SetCount';

  @override
  Widget build(BuildContext context) {
    final List<int> counts = List.generate(10, (index) => index + 1);

    return Scaffold(
      appBar: AppBar(
        title: Text('セット数'),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.white,
          height: 1,
        ),
        itemCount: counts.length,
        itemBuilder: (BuildContext context, int index) {
          final value = counts[index];
          return ListTile(
            title: Text(
              "$value セット",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Get.back(result: value);
            },
            selected: SettingService.to.setCount == value,
            selectedTileColor: Colors.white12,
          );
        },
      ),
    );
  }
}
