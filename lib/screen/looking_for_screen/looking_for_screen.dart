import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobseek/screen/looking_for_screen/looking_for_widget/looking_for_widget.dart';
import 'package:jobseek/screen/looking_for_screen/looking_for_you_screen_controller.dart';
import 'package:jobseek/utils/app_style.dart';
import 'package:jobseek/utils/asset_res.dart';
import 'package:jobseek/utils/color_res.dart';
import 'package:jobseek/utils/string.dart';

class LookingForScreen extends StatelessWidget {
  const LookingForScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LookingForYouScreenController());
    return Scaffold(
      backgroundColor: ColorRes.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Spacer(flex: 2,),
          Image.asset(
            AssetRes.logoWithName,
            height: 170,
          ),
          Spacer(),
          SizedBox(
            height: Get.height * 0.06,
          ),

          Text(
            Strings.whatAreYouLookingFor,
            style: appTextStyle(color: ColorRes.black, fontSize: 14),
          ),
          SizedBox(
            height: Get.height * 0.035,
          ),
          Padding(
            padding:
            EdgeInsets.symmetric(horizontal: Get.width * 0.048),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => controller.onChangeWantJobChoice(),
                  child: Obx(
                        () => lookingForYouBox(
                            AssetRes.wantJob,
                        "I want job", controller.isJob.value),
                  ),
                ),
                InkWell(
                  onTap: () => controller.onChangeEmployeeChoice(),
                  child: Obx(
                        () => lookingForYouBox(
                        AssetRes.person,
                        "I want an employee",
                        controller.isEmployee.value),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: Get.height * 0.06,
          ),

        ],
      ),
    );
  }
}


