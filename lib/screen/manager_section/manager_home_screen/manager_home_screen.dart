import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobseek/common/widgets/common_loader.dart';
import 'package:jobseek/screen/job_detail_screen/job_detail_upload_cv_screen/upload_cv_controller.dart';
import 'package:jobseek/screen/manager_section/Recent%20People%20Application/recent_Application_screen.dart';
import 'package:jobseek/screen/manager_section/manager_home_screen/manager_home_screen_controller.dart';
import 'package:jobseek/screen/manager_section/manager_home_screen/manager_home_screen_widget/manager_home_screen_widget.dart';
import 'package:jobseek/screen/manager_section/notification1/notification1_screen.dart';
import 'package:jobseek/service/pref_services.dart';
import 'package:jobseek/utils/app_style.dart';
import 'package:jobseek/utils/asset_res.dart';
import 'package:jobseek/utils/color_res.dart';
import 'package:jobseek/utils/pref_keys.dart';
import 'package:jobseek/utils/string.dart';

// ignore: must_be_immutable
class ManagerHomeScreen extends StatelessWidget {
  ManagerHomeScreen({Key? key}) : super(key: key);
  final controller = Get.put(ManagerHomeScreenController());

  JobDetailsUploadCvController jobDetailsUploadCvController =
      Get.put(JobDetailsUploadCvController());

  @override
  Widget build(BuildContext context) {
    jobDetailsUploadCvController.init();
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child:   Row(
              children: [
               Image.asset(
                 AssetRes.small_logo,
                 height: 40,
               ),
                SizedBox(width: Get.width * 0.23),
                Column(

                  children: [
                    Text(
                      Strings.welcome,
                      style: appTextStyle(
                          color: ColorRes.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      PrefService.getString(PrefKeys.companyName),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: appTextStyle(
                          color: ColorRes.containerColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Strings.RecentPeopleApplication,
                  style: appTextStyle(
                      color: ColorRes.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (con) => RecentApplicationScreen(),
                      ),
                    );
                  },
                  child: Text(
                    Strings.seeAll,
                    style: appTextStyle(
                        color: ColorRes.containerColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                ),
              ],
            ),
          ),

          GetBuilder<ManagerHomeScreenController>(
              id: "userdata",
              builder: (contro) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: (contro.loader == true)
                      ? const CommonLoader()
                      : recentPeopleBox(),
                );
              }),
        ],
      ),
    );
  }
}
