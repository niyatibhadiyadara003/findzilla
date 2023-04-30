import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobseek/utils/app_style.dart';
import 'package:jobseek/utils/color_res.dart';

Widget lookingForYouBox(String icon, text, bool isSelect) {
  return Container(
    width: Get.width * 0.44,
    height: Get.height * 0.18,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
          color:
              isSelect == true ? ColorRes.containerColor : ColorRes.borderColor,
          width: 2),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(icon, height: 60,),
        const SizedBox(
          height: 10,
        ),
        Text(
          text,
          style: appTextStyle(color: ColorRes.black, fontSize: 12),
        ),
      ],
    ),
  );
}
