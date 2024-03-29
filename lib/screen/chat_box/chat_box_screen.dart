import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobseek/common/widgets/common_loader.dart';
import 'package:jobseek/common/widgets/helper.dart';
import 'package:jobseek/screen/chat_box_user/chat_box_usercontroller.dart';
import 'package:jobseek/screen/create_vacancies/create_vacancies_controller.dart';
import 'package:jobseek/screen/dashboard/home/widgets/search_field.dart';
import 'package:jobseek/screen/job_detail_screen/job_detail_upload_cv_screen/upload_cv_controller.dart';
import 'package:jobseek/service/pref_services.dart';
import 'package:jobseek/utils/app_style.dart';
import 'package:jobseek/utils/asset_res.dart';
import 'package:jobseek/utils/color_res.dart';
import 'package:jobseek/utils/pref_keys.dart';
import 'package:jobseek/utils/string.dart';
import 'chat_box_controller.dart';

// ignore: must_be_immutable
class ChatBoxScreen extends StatelessWidget {
  ChatBoxScreen({Key? key}) : super(key: key);
  final ChatBoxController controller = Get.put(ChatBoxController());
  JobDetailsUploadCvController jobDetailsUploadCvController =
      Get.put(JobDetailsUploadCvController());

  @override
  Widget build(BuildContext context) {
    jobDetailsUploadCvController.init();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorRes.backgroundColor,
      body: Column(
        children: [
          const SizedBox(height: 65),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Stack(
              children: [
                Image.asset(
                  AssetRes.small_logo,
                  height: 40,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Center(
                    child: Text(
                      Strings.chatBox,
                      style: appTextStyle(
                          color: ColorRes.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          searchAreaChatM(),

          allChat(),
        ],
      ),
    );
  }
}

Widget allChat() {
  CreateVacanciesController create = Get.put(CreateVacanciesController());
  return GetBuilder<ChatBoxController>(
      id: "searchChat",
      builder: (controller) {
        return controller.searchController.text.isEmpty
            ? Expanded(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection("Apply")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null || snapshot.hasData == false) {
                        return const CommonLoader();
                      }

                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            String? o;

                            snapshot.data!.docs[index]['companyName']
                                .forEach((element) {
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
                            return StreamBuilder<
                                DocumentSnapshot<Map<String, dynamic>>>(
                              stream: FirebaseFirestore.instance
                                  .collection('chats')
                                  .doc(controller.getChatId(controller.userUidM,
                                      snapshot.data!.docs[index].id))
                                  .snapshots(),
                              builder: (context, snapshotM) {
                                if (snapshotM.data == null ||
                                    snapshotM.hasData == false) {
                                  return const SizedBox();
                                }

                                Map<String, dynamic>? dataM =
                                    snapshotM.data?.data();

                                return (o.toString().toLowerCase() ==
                                        PrefService.getString(
                                                PrefKeys.companyName)
                                            .toString()
                                            .toLowerCase())
                                    ? InkWell(
                                        onTap: () async {
                                          controller.lastMessageTrue(
                                              snapshot.data!.docs[index].id);

                                          controller.gotoChatScreen(
                                            context,
                                            snapshot.data!.docs[index].id,
                                            snapshot.data!.docs[index]
                                                ['userName'],
                                          );
                                        },
                                        child: Container(
                                          height: 92,
                                          width: Get.width,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 18, vertical: 4),
                                          padding: const EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(15),
                                              ),
                                              border: Border.all(
                                                color: const Color(0xffF3ECFF),
                                              ),
                                              color: ColorRes.white),
                                          child: Row(
                                            children: [
                                              ( snapshot.data!.docs[index]
                                              ['imageUrl'] == "")
                                                  ? Container(
                                                width: 60,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    image: const DecorationImage(
                                                        image: AssetImage(
                                                            AssetRes
                                                                .roundAirbnb),
                                                        fit: BoxFit.cover
                                                    )
                                                ),
                                              )
                                                  : Container(
                                                width: 60,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            snapshot.data!.docs[index]
                                                            ['imageUrl']),
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
                                                    snapshot.data!.docs[index]
                                                        ['userName'],
                                                    style: appTextStyle(
                                                        color: ColorRes.black,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  const SizedBox(height: 6),
                                                  Text(
                                                    dataM?['lastMessage'] ?? "",
                                                    style: appTextStyle(
                                                        color: ColorRes.black
                                                            .withOpacity(0.8),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  /*(dataM?['countU'] == 0 ||
                    dataM?['countU'] ==
                        null)
                    ? const SizedBox()
                    : Container(
                  height: 22,
                  width: 22,
                  decoration:
                  BoxDecoration(
                    gradient:
                    const LinearGradient(
                      colors: [
                        ColorRes
                            .gradientColor,
                        ColorRes
                            .containerColor
                      ],
                    ),
                    borderRadius:
                    BorderRadius
                        .circular(
                        22),
                  ),
                  child: Padding(
                    padding:
                    const EdgeInsets
                        .only(
                        top: 5),
                    child: Text(
                      textAlign:
                      TextAlign
                          .center,
                      "${dataM?['countU'] ?? ""}",
                      style: appTextStyle(
                          fontSize: 10,
                          fontWeight:
                          FontWeight
                              .w400,
                          color: ColorRes
                              .white),
                    ),
                  ),
                ),
                const Spacer(),*/
                                                  Text(
                                                    dataM?['lastMessageTime'] ==
                                                            null
                                                        ? ""
                                                        : " ${getFormattedTime(dataM?['lastMessageTime'].toDate() ?? "")}",
                                                    style: appTextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(width: 10),
                                            ],
                                          ),
                                        ),
                                      )
                                    : const SizedBox();
                              },
                            );
                          });
                    }),
              )
            : Expanded(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection("Apply")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null || snapshot.hasData == false) {
                        return const CommonLoader();
                      }

                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            String? o;

                            snapshot.data!.docs[index]['companyName']
                                .forEach((element) {
                              if (element.toString().toLowerCase() ==
                                  PrefService.getString(PrefKeys.companyName)
                                      .toString()
                                      .toLowerCase()) {
                                o = element;
                              }
                            });

                            return StreamBuilder<
                                DocumentSnapshot<Map<String, dynamic>>>(
                              stream: FirebaseFirestore.instance
                                  .collection('chats')
                                  .doc(controller.getChatId(controller.userUidM,
                                  snapshot.data!.docs[index].id))
                                  .snapshots(),
                              builder: (context, snapshotM) {
                                if (snapshotM.data == null ||
                                    snapshotM.hasData == false) {
                                  return const SizedBox();
                                }

                                Map<String, dynamic>? dataM =
                                snapshotM.data?.data();

                                return (o.toString().toLowerCase() ==
                                    PrefService.getString(PrefKeys.companyName)
                                        .toString()
                                        .toLowerCase())
                                    ? (snapshot.data!.docs[index]['userName']
                                    .toString()
                                    .contains(controller
                                    .searchText.value.capitalize
                                    .toString()) ||
                                    snapshot.data!.docs[index]['userName']
                                        .toString()
                                        .contains(controller
                                        .searchText.value
                                        .toLowerCase()
                                        .toString()))
                                    ? InkWell(
                                  onTap: () async {
                                    controller.gotoChatScreen(
                                      context,
                                      snapshot.data!.docs[index].id,
                                      snapshot.data!.docs[index]
                                      ['userName'],
                                    );
                                  },
                                  child: Container(
                                    height: 92,
                                    width: Get.width,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 18, vertical: 4),
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        const BorderRadius.all(
                                            Radius.circular(15)),
                                        border: Border.all(
                                          color: const Color(0xffF3ECFF),
                                        ),
                                        color: ColorRes.white),
                                    child: Row(
                                      children: [
                                        ( snapshot.data!.docs[index]
                                        ['imageUrl'] == "")
                                            ? Container(
                                          width: 60,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              image: const DecorationImage(
                                                  image: AssetImage(
                                                      AssetRes
                                                          .roundAirbnb),
                                                  fit: BoxFit.cover
                                              )
                                          ),
                                        )
                                            : Container(
                                          width: 60,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      snapshot.data!.docs[index]
                                                      ['imageUrl']),
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
                                              snapshot.data!.docs[index]
                                              ['userName'],
                                              style: appTextStyle(
                                                  color: ColorRes.black,
                                                  fontSize: 15,
                                                  fontWeight:
                                                  FontWeight.w500),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                          dataM?['lastMessage'] ??
                                              "",
                                          style: appTextStyle(
                                              color: ColorRes
                                                  .black
                                                  .withOpacity(
                                                  0.8),
                                              fontSize: 12,
                                              fontWeight:
                                              FontWeight
                                                  .w400),
                                        ),
                                          ],
                                        ),
                                        const Spacer(),
                                            Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.end,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: [
                                      /*  (dataM?['countU'] == 0 ||
                                            dataM?['countU'] ==
                                                null)
                                            ? const SizedBox()
                                            : Container(
                                          height: 22,
                                          width: 22,
                                          decoration:
                                          BoxDecoration(
                                            gradient:
                                            const LinearGradient(
                                              colors: [
                                                ColorRes
                                                    .gradientColor,
                                                ColorRes
                                                    .containerColor
                                              ],
                                            ),
                                            borderRadius:
                                            BorderRadius
                                                .circular(
                                                22),
                                          ),
                                          child: Padding(
                                            padding:
                                            const EdgeInsets
                                                .only(
                                                top: 5),
                                            child: Text(
                                              textAlign:
                                              TextAlign
                                                  .center,
                                              "${dataM?['countU'] ?? ""}",
                                              style: appTextStyle(
                                                  fontSize:
                                                  10,
                                                  fontWeight:
                                                  FontWeight
                                                      .w400,
                                                  color: ColorRes
                                                      .white),
                                            ),
                                          ),
                                        ),
                                        const Spacer(),*/
                                        Text(
                                          dataM?['lastMessageTime'] ==
                                              null
                                              ? ""
                                              : " ${getFormattedTime(dataM?['lastMessageTime'].toDate() ?? "")}",
                                          style: appTextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                              fontWeight:
                                              FontWeight
                                                  .w500),
                                        ),
                                      ],
                                    ),
                                        const SizedBox(width: 10),
                                      ],
                                    ),
                                  ),
                                )
                                    : const SizedBox()
                                    : const SizedBox();
                              },
                            );

                          });
                    }),
              );
      });
}



/*

 */