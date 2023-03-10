import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jobseek/utils/app_style.dart';
import 'package:jobseek/utils/color_res.dart';

Future alert(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text("Do you want to Exit?"),
          actions: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(ColorRes.containerColor),
              ),
              child: Text(
                'Cancel',
                style: appTextStyle(color: ColorRes.white, fontSize: 15),
              ),
              onPressed: () {
                return Navigator.of(context).pop(false);
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(ColorRes.containerColor),
              ),
              child: Text("Exit",
                  style: appTextStyle(color: ColorRes.white, fontSize: 15)),
              onPressed: () async {
                exit(0);
              },
            ),
          ],
        );
      });
}
