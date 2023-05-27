import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobseek/screen/chat_box/chat_box_screen.dart';
import 'package:jobseek/screen/create_vacancies/create_vacancies_controller.dart';
import 'package:jobseek/screen/job_detail_screen/job_detail_upload_cv_screen/upload_cv_controller.dart';
import 'package:jobseek/screen/manager_section/call/video_joinig_Screen.dart';
import 'package:jobseek/screen/manager_section/manager_home_screen/manager_home_screen_controller.dart';
import 'package:jobseek/service/pref_services.dart';
import 'package:jobseek/utils/app_res.dart';
import 'package:jobseek/utils/app_style.dart';
import 'package:jobseek/utils/asset_res.dart';
import 'package:jobseek/utils/color_res.dart';
import 'package:jobseek/utils/pref_keys.dart';
import 'package:jobseek/utils/string.dart';

Widget recentPeopleBox({bool? homeScreen, String? position}) {
  final ManagerHomeScreenController contro =
      Get.put(ManagerHomeScreenController());
  JobDetailsUploadCvController jobDetailsUploadCvController =
      Get.put(JobDetailsUploadCvController());
  jobDetailsUploadCvController.init();
  CreateVacanciesController create = Get.put(CreateVacanciesController());
  return SingleChildScrollView(
    child: SizedBox(
      height: Get.height / 1.40,
      child: ListView.builder(
          itemCount: contro.userData.length,
          itemBuilder: (context, i) {
            String? o;

            if (kDebugMode) {
              print(contro.userData[0]['companyName'][0]);
            }

            if (homeScreen == true) {
              contro.userData[i]['companyName'].forEach((element) {
                if (element.toString().toLowerCase() ==
                        PrefService.getString(PrefKeys.companyName)
                            .toString()
                            .toLowerCase() &&
                    contro.userData[i]['Occupation']
                        .toString()
                        .toLowerCase()
                        .contains(position.toString().toLowerCase())) {
                  if (kDebugMode) {
                    print(element);
                  }
                  o = element;
                }
              });
            } else {
              contro.userData[i]['companyName'].forEach((element) {
                if (element.toString().toLowerCase() ==
                    PrefService.getString(PrefKeys.companyName)
                        .toString()
                        .toLowerCase()) {
                  if (kDebugMode) {
                    print(element);
                  }
                  o = element;
                }
              });
            }

            return (o.toString().toLowerCase() ==
                    PrefService.getString(PrefKeys.companyName)
                        .toString()
                        .toLowerCase())
                ? Column(
                    children: [
                      InkWell(
                        onTap: () => Get.toNamed(AppRes.applicantsDetails,
                            arguments: contro.userData[i]),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 20),
                          decoration: BoxDecoration(
                            border: Border.all(color: ColorRes.borderColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: ColorRes.black,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: (contro.userData[i]
                                                    ['imageUrl'] ==
                                                "")
                                            ? Container(
                                                width: 60,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: const DecorationImage(
                                                        image: AssetImage(
                                                            AssetRes
                                                                .roundAirbnb),
                                                        fit: BoxFit.cover)),
                                              )
                                            : Container(
                                                width: 60,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            contro.userData[i]
                                                                ['imageUrl']),
                                                        fit: BoxFit.cover)),
                                              ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${contro.userData[i]['userName']}",
                                            style: appTextStyle(
                                                color: ColorRes.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            "${contro.userData[i]['Occupation']}",
                                            style: appTextStyle(
                                                color: ColorRes.grey,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  /* Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (con) => ChatBoxScreen(),
                                            ),
                                          );
                                        },
                                        // onTap: () => Get.toNamed(
                                        //     AppRes.applicantsDetails,
                                        //     arguments: control.userData[i]),
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              color: ColorRes.logoColor,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: GradientIcon(
                                            Icons.chat,
                                            20,
                                            LinearGradient(colors: [
                                              ColorRes.logoColor,
                                              ColorRes.containerColor,
                                            ]),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (con) =>
                                                  const VideoJoiningScreen(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            color: ColorRes.logoColor,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: GradientIcon(
                                            Icons.videocam_sharp,
                                            20,
                                            LinearGradient(colors: [
                                              ColorRes.logoColor,
                                              ColorRes.containerColor,
                                            ]),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),*/
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                color: ColorRes.lightGrey.withOpacity(0.6),
                                height: 1.5,
                                width: Get.width,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () => Get.toNamed(
                                        AppRes.resumeScreen,
                                        arguments: {
                                          "doc": contro.userData[i]['resumeUrl']
                                        }),
                                    child: Container(
                                      width: 135,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(colors: [
                                          ColorRes.logoColor,
                                          ColorRes.containerColor,
                                        ]),
                                      ),
                                      child: Center(
                                        child: Text(
                                          Strings.seeResume,
                                          style: appTextStyle(
                                              color: ColorRes.white,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => Get.toNamed(
                                        AppRes.seeDetailsScreen,
                                        arguments: contro.userData[i]),
                                    child: Container(
                                      width: 135,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: ColorRes.containerColor,
                                              width: 2),
                                          color: ColorRes.white),
                                      child: Center(
                                        child: Text(
                                          Strings.seeDetails,
                                          style: appTextStyle(
                                              color: ColorRes.containerColor,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )
                : const SizedBox();
          }),
    ),
  );
}

class GradientIcon extends StatelessWidget {
  const GradientIcon(this.icon, this.size, this.gradient, {Key? key})
      : super(key: key);

  final IconData icon;
  final double size;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}
