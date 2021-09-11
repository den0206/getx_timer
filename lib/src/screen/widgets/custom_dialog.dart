import 'dart:io';

import 'package:flutter/material.dart';
import 'package:getx_timer/src/service/admon_service.dart';
import 'package:sizer/sizer.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    Key? key,
    required this.title,
    required this.descripon,
    required this.onSuceed,
    this.onCancel,
    required this.icon,
    this.mainColor = Colors.redAccent,
  }) : super(key: key);

  final String title;
  final String descripon;

  final Function() onSuceed;
  final Function()? onCancel;
  final IconData icon;
  final Color mainColor;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 70, 10, 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  descripon,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.sp,
                  ),
                ),
                if (Platform.isIOS) AdmobBannerService.to.myDialogAd,
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
                          textStyle: TextStyle(
                            color: Colors.white,
                          )),
                      onPressed: () {
                        Navigator.pop(context);
                        if (onCancel != null) onCancel!();
                      },
                      child: Text(
                        "Cancel",
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: mainColor,
                          textStyle: TextStyle(
                            color: Colors.white,
                          )),
                      onPressed: () {
                        Navigator.pop(context);
                        onSuceed();
                      },
                      child: Text(
                        "OK",
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: -60,
            child: CircleAvatar(
              backgroundColor: mainColor,
              radius: 60,
              child: Icon(
                icon,
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
