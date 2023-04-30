import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobseek/common/widgets/common_loader.dart';
import 'package:jobseek/common/widgets/helper.dart';
import 'package:jobseek/screen/create_vacancies/create_vacancies_controller.dart';
import 'package:jobseek/screen/dashboard/home/widgets/search_field.dart';
import 'package:jobseek/screen/job_detail_screen/job_detail_upload_cv_screen/upload_cv_controller.dart';
import 'package:jobseek/utils/app_style.dart';
import 'package:jobseek/utils/asset_res.dart';
import 'package:jobseek/utils/color_res.dart';
import 'package:jobseek/utils/string.dart';
import 'chat_box_usercontroller.dart';

// ignore: must_be_immutable
class ChatBoxUserScreen extends StatelessWidget {
  ChatBoxUserScreen({Key? key}) : super(key: key);

  final ChatBoxUserController controller = Get.put(ChatBoxUserController());

  JobDetailsUploadCvController jobDetailsUploadCvController =
      Get.put(JobDetailsUploadCvController());

  @override
  Widget build(BuildContext context) {
    jobDetailsUploadCvController.init();
    controller.getUserData();
    return Scaffold(
      backgroundColor: ColorRes.backgroundColor,
      body: Column(children: [
        const SizedBox(height: 50),
        Row(children: [
          Container(
            margin: const EdgeInsets.all(15),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: ColorRes.logoColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              AssetRes.small_logo,
              scale: 6,
            ),
          ),
          const SizedBox(width: 80),
          Center(
            child: Text(
              Strings.chatBox,
              style: appTextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  height: 1,
                  color: ColorRes.black),
            ),
          ),
        ]),
        const SizedBox(height: 20),
        searchAreaChatU(),
        const SizedBox(height: 20),
        allChat(),
      ]),
    );
  }
}

Widget allChat() {
  return GetBuilder<ChatBoxUserController>(
      id: "searchChat",
      builder: (controller) {
        CreateVacanciesController create = Get.put(CreateVacanciesController());
        return controller.searchController.text.isEmpty
            ? Expanded(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection("Auth")
                      .doc("Manager")
                      .collection("register")
                      .snapshots(),
                  builder: (context, snapshot1) {
                    if (snapshot1.data == null || snapshot1.hasData == false) {
                      return const SizedBox();
                    }

                    return ListView.builder(
                        itemCount: snapshot1.data!.docs.length,
                        itemBuilder: (context, index) {
                          return StreamBuilder<
                              DocumentSnapshot<Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance
                                .collection('Auth')
                                .doc('Manager')
                                .collection('register')
                                .doc(snapshot1.data!.docs[index].id)
                                .collection('company')
                                .doc('details')
                                .snapshots(),
                            builder: (context, snapshot) {
                              Map<String, dynamic>? data =
                                  snapshot.data?.data();

                              if (data == null) {
                                return const SizedBox();
                              }

                              String? o;

                              companyList.forEach((element) {
                                if (element.toString().toLowerCase() == data['name'].toString().toLowerCase()) {
                                  o = element;
                                }
                              });

                              return (o.toString().toLowerCase() == data['name'].toString().toLowerCase())
                                  ? InkWell(
                                      onTap: () async {
                                        controller.gotoChatScreen(
                                            context,
                                            snapshot1.data!.docs[index].id,
                                            data['name'],
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
                                            (create.url == "")
                                                ? const Image(
                                                    image: AssetImage(
                                                        AssetRes.airBnbLogo),
                                                    height: 100,
                                                  )
                                                : Image(
                                                    image: NetworkImage(
                                                        create.url),
                                                    height: 100,
                                                  ),
                                            /*
                                                      Image.asset(
                                                        AssetRes.airBnbLogo,
                                                      ),*/
                                            const SizedBox(width: 20),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data['name'],
                                                  style: appTextStyle(
                                                      color: ColorRes.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                const SizedBox(height: 6),
                                                /* Text(
                                            dataM?['lastMessage'] ??
                                                "",
                                            style: appTextStyle(
                                                color: ColorRes.black
                                                    .withOpacity(0.8),
                                                fontSize: 12,
                                                fontWeight:
                                                FontWeight.w400),
                                          ),*/
                                              ],
                                            ),
                                            const Spacer(),
                                            /*  Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: [
                                          (dataM?['countM'] == 0 ||
                                              dataM?['countM'] ==
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
                                                "${dataM?['countM'] ?? ""}",
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
                                          const Spacer(),
                                          Text(
                                            dataM?['lastMessageTime'] ==
                                                null
                                                ? ""
                                                : " ${getFormattedTime(dataM?['lastMessageTime'].toDate() ?? "")}",
                                            style: appTextStyle(
                                                fontSize: 12,
                                                color: ColorRes.black
                                                    .withOpacity(0.8),
                                                fontWeight:
                                                FontWeight.w500),
                                          ),
                                        ],
                                      ),*/
                                            const SizedBox(width: 10),
                                          ],
                                        ),
                                      ),
                                    )
                                  : SizedBox();
                            },
                          );
                        });
                  },
                ),
              )
            : Expanded(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection("Auth")
                      .doc("Manager")
                      .collection("register")
                      .snapshots(),
                  builder: (context, snapshot1) {
                    if (snapshot1.data == null || snapshot1.hasData == false) {
                      return const SizedBox();
                    }

                    return ListView.builder(
                        itemCount: snapshot1.data!.docs.length,
                        itemBuilder: (context, index) {
                          return StreamBuilder<
                              DocumentSnapshot<Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance
                                .collection('Auth')
                                .doc('Manager')
                                .collection('register')
                                .doc(snapshot1.data!.docs[index].id)
                                .collection('company')
                                .doc('details')
                                .snapshots(),
                            builder: (context, snapshot) {
                              Map<String, dynamic>? data =
                                  snapshot.data?.data();
                              if (data == null) {
                                return const SizedBox();
                              }

                              String? o;

                              companyList.forEach((element) {
                                if (element.toString().toLowerCase() ==
                                    data['name'].toString().toLowerCase()) {
                                  o = element;
                                }
                              });

                              if (o.toString().contains(controller
                                  .searchText.value.capitalize
                                  .toString()) ||
                                  o.toString().contains(controller
                                      .searchText.value
                                      .toLowerCase()
                                      .toString())) {
                                return InkWell(
                                  onTap: () async {
                                    controller.gotoChatScreen(
                                        context,
                                        snapshot1.data!.docs[index].id,
                                        data['name'],
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
                                            color: const Color(0xffF3ECFF)),
                                        color: ColorRes.white),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          AssetRes.airBnbLogo,
                                        ),
                                        const SizedBox(width: 20),
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data['name'],
                                              style: appTextStyle(
                                                  color: ColorRes.black,
                                                  fontSize: 15,
                                                  fontWeight:
                                                  FontWeight.w500),
                                            ),
                                            const SizedBox(height: 6),
                                            /*Text(
                                              dataM?['lastMessage'] ?? "",
                                              style: appTextStyle(
                                                  color: ColorRes.black
                                                      .withOpacity(0.8),
                                                  fontSize: 12,
                                                  fontWeight:
                                                  FontWeight.w400),
                                            ),*/
                                          ],
                                        ),
                                        const Spacer(),
                                     /*   Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          children: [
                                            (dataM?['countM'] == 0 ||
                                                dataM?['countM'] ==
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
                                                    .circular(22),
                                              ),
                                              child: Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(top: 5),
                                                child: Text(
                                                  textAlign: TextAlign
                                                      .center,
                                                  "${dataM?['countM'] ?? ""}",
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
                                            const Spacer(),
                                            Text(
                                              dataM?['lastMessageTime'] ==
                                                  null
                                                  ? ""
                                                  : " ${getFormattedTime(dataM?['lastMessageTime'].toDate() ?? "")}",
                                              style: appTextStyle(
                                                  fontSize: 12,
                                                  color: ColorRes.black
                                                      .withOpacity(0.8),
                                                  fontWeight:
                                                  FontWeight.w500),
                                            ),
                                          ],
                                        ),*/
                                        const SizedBox(width: 10),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          );
                        });
                  },
                ),
              );
      });
}

/*
StreamBuilder<
                                  DocumentSnapshot<Map<String, dynamic>>>(
                                stream: FirebaseFirestore.instance
                                    .collection('chats')
                                    .doc(controller.getChatId(
                                        controller.userUid,
                                        snapshot1.data!.docs[index].id))
                                    .snapshots(),
                                builder: (context, snapshotM) {
                                  if (snapshotM.data == null ||
                                      snapshotM.hasData == false) {
                                    return const SizedBox();
                                  }

                                  Map<String, dynamic>? dataM =
                                      snapshotM.data?.data();

                                  String? o;

                                  companyList.forEach((element) {
                                    if (element
                                            .toString()
                                            .toLowerCase() ==
                                        data['name'].toString().toLowerCase()) {
                                      o = element;
                                    }
                                  });

                                  return (o.toString().toLowerCase() == data['name'].toString().toLowerCase())
                                      ? InkWell(
                                          onTap: () async {
                                            controller.lastMessageTrue(
                                                snapshot1.data!.docs[index].id);

                                            controller.gotoChatScreen(
                                                context,
                                                snapshot1.data!.docs[index].id,
                                                data['name'],
                                                data['deviceToken'].toString());
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
                                                  color:
                                                      const Color(0xffF3ECFF),
                                                ),
                                                color: ColorRes.white),
                                            child: Row(
                                              children: [
                                                (create.url == "")
                                                    ? const Image(
                                                        image: AssetImage(
                                                            AssetRes
                                                                .airBnbLogo),
                                                        height: 100,
                                                      )
                                                    : Image(
                                                        image: NetworkImage(
                                                            create.url),
                                                        height: 100,
                                                      ),
                                                /*
                                                      Image.asset(
                                                        AssetRes.airBnbLogo,
                                                      ),*/
                                                const SizedBox(width: 20),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      data['name'],
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
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    (dataM?['countM'] == 0 ||
                                                            dataM?['countM'] ==
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
                                                                "${dataM?['countM'] ?? ""}",
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
                                                    const Spacer(),
                                                    Text(
                                                      dataM?['lastMessageTime'] ==
                                                              null
                                                          ? ""
                                                          : " ${getFormattedTime(dataM?['lastMessageTime'].toDate() ?? "")}",
                                                      style: appTextStyle(
                                                          fontSize: 12,
                                                          color: ColorRes.black
                                                              .withOpacity(0.8),
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
 */
