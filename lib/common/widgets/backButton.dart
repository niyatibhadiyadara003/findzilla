import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobseek/utils/color_res.dart';

Widget backButton() {
  return InkWell(
    onTap: () {
      Get.back();
    },
    child: Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: ColorRes.logoColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(
        Icons.arrow_back_ios_new_rounded,
        color: ColorRes.containerColor,
      ),
    ),
  );
}
