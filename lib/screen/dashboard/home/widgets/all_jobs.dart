import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobseek/common/widgets/common_loader.dart';
import 'package:jobseek/screen/create_vacancies/create_vacancies_controller.dart';
import 'package:jobseek/screen/dashboard/home/home_controller.dart';
import 'package:jobseek/screen/job_recommendation_screen/job_recommendation_controller.dart';
import 'package:jobseek/service/pref_services.dart';
import 'package:jobseek/utils/app_res.dart';
import 'package:jobseek/utils/app_style.dart';
import 'package:jobseek/utils/asset_res.dart';
import 'package:jobseek/utils/color_res.dart';
import 'package:jobseek/utils/pref_keys.dart';

Widget allJobs(Stream stream, {bool? seeAll = false}) {
  final HomeController controller = HomeController();
  CreateVacanciesController create = Get.put(CreateVacanciesController());

  //final jrController = Get.put(JobRecommendationController());
  return GetBuilder<JobRecommendationController>(
      id: "search",
      builder: (jrController) {
        return StreamBuilder(
            stream: stream,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                jrController.documents = snapshot.data.docs;
              }
              controller.jobTypesSaved =
                  List.generate(jrController.documents.length, (index) => false)
                      .obs;

              if (jrController.searchText.value.isNotEmpty) {
                jrController.documents =
                    jrController.documents.where((element) {
                  //print(element.get('Position'));
                  return element
                          .get('Position')
                          .toString()
                          .toLowerCase()
                          .contains(
                              jrController.searchText.value.toLowerCase()) ||
                      element
                          .get('CompanyName')
                          .toString()
                          .toLowerCase()
                          .contains(
                              jrController.searchText.value.toLowerCase());
                }).toList();
              }
              /*   if (jrController.searchText.value.isNotEmpty) {
                jrController.documents =
                    jrController.documents.where((element) {
                  return element
                      .get('CompanyName')
                      .toString()
                      .toLowerCase()
                      .contains(jrController.searchText.value.toLowerCase());
                }).toList();
              }*/
              return snapshot.hasData
                  ? ListView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: seeAll!
                          ? jrController.documents.length
                          : (jrController.documents.length <= 15
                              ? jrController.documents.length
                              : 15),
                      //jrController.documents.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (kDebugMode) {
                          print([jrController.documents.length - 1 - index]);
                        }
                        if (kDebugMode) {
                          print(jrController
                              .documents[
                                  jrController.documents.length - 1 - index]
                              .id);
                        }
                        return (jrController.documents[
                                    jrController.documents.length -
                                        1 -
                                        index]["Status"] !=
                                'Inactive')
                            ? InkWell(
                                onTap: () => Get.toNamed(AppRes.jobDetailScreen,
                                    arguments: {
                                      "saved": jrController.documents[jrController.documents.length - 1 - index],
                                      "docId": jrController.documents.length - 1 - index
                                    }),
                                child: Container(
                                  height: 92,
                                  width: Get.width,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 18, vertical: 4),
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                      border: Border.all(
                                        color: const Color(0xffF3ECFF),
                                      ),
                                      color: ColorRes.white),
                                  child: Row(
                                    children: [
                                      ( jrController.documents[
                                      jrController.documents.length -
                                          1 -
                                          index]["imageUrl"] == "")


                                          ? Container(
                                        width: 60,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image:  AssetImage(
                                                AssetRes.roundAirbnb),
                                            fit: BoxFit.cover
                                          )
                                        ),
                                      )
                                          : Container(
                                        width: 60,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            image: DecorationImage(
                                                image:  NetworkImage(
                                                    jrController.documents[
                                                    jrController.documents.length -
                                                        1 -
                                                        index]["imageUrl"]),
                                                fit: BoxFit.cover
                                            )
                                        ),
                                      ),


                                      const SizedBox(width: 20),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            jrController.documents[
                                                jrController.documents.length -
                                                    1 -
                                                    index]["Position"],
                                            style: appTextStyle(
                                                color: ColorRes.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            jrController.documents[
                                                jrController.documents.length -
                                                    1 -
                                                    index]["CompanyName"],
                                            style: appTextStyle(
                                                color: ColorRes.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            "${jrController.documents[jrController.documents.length - 1 - index]["location"]} "
                                            " ${jrController.documents[jrController.documents.length - 1 - index]["type"]}",
                                            style: appTextStyle(
                                                color: ColorRes.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              String docId = snapshot
                                                  .data
                                                  .docs[jrController
                                                          .documents.length -
                                                      1 -
                                                      index]
                                                  .id;
                                              controller.onTapSave(
                                                  jrController
                                                          .documents.length -
                                                      1 -
                                                      index,
                                                  jrController.documents[
                                                      jrController.documents
                                                              .length -
                                                          1 -
                                                          index],
                                                  docId);
                                            },
                                            child: GetBuilder<
                                                    JobRecommendationController>(
                                                builder: (con) {
                                              return Image.asset(
                                                (jrController.documents[jrController
                                                                        .documents
                                                                        .length -
                                                                    1 -
                                                                    index][
                                                                'BookMarkUserList'] ==
                                                            null ||
                                                        jrController
                                                                .documents[jrController.documents.length - 1 - index][
                                                                    'BookMarkUserList']
                                                                .length ==
                                                            0)
                                                    ? AssetRes
                                                        .bookMarkBorderIcon
                                                    : (jrController.documents[
                                                                jrController
                                                                        .documents
                                                                        .length -
                                                                    1 -
                                                                    index]
                                                                ['BookMarkUserList']
                                                            .contains(PrefService.getString(PrefKeys.userId)))
                                                        ? AssetRes.bookMarkFillIcon
                                                        : AssetRes.bookMarkBorderIcon,
                                                height: 20,
                                                color: ColorRes.containerColor,
                                              );
                                            }),
                                          ),
                                          const Spacer(),
                                          Text(
                                            "\$${jrController.documents[jrController.documents.length - 1 - index]["salary"]}",
                                            style: appTextStyle(
                                                fontSize: 16,
                                                color: ColorRes.containerColor,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                      const SizedBox(width: 10)
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox();
                      })
                  : const CommonLoader();
            });
      });
}
