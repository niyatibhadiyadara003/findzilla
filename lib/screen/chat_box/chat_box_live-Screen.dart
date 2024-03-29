import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobseek/screen/chat_box/chat_box_controller.dart';
import 'package:jobseek/screen/chat_box_user/chat_box_usercontroller.dart';
import 'package:jobseek/screen/manager_section/Notification/notification_services.dart';
import 'package:jobseek/screen/manager_section/call/call_join_Screen.dart';
import 'package:jobseek/screen/manager_section/call/video_joinig_Screen.dart';
import 'package:jobseek/service/pref_services.dart';
import 'package:jobseek/utils/app_style.dart';
import 'package:jobseek/utils/asset_res.dart';
import 'package:jobseek/utils/color_res.dart';
import 'package:jobseek/utils/pref_keys.dart';
import 'package:jobseek/utils/string.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

// ignore: must_be_immutable
class ChatBoxLiveScreenM extends StatelessWidget {
  final String? name;
  final String? roomId;
  final String? otherUserUid;
  final String? userUid;


  ChatBoxLiveScreenM(
      {Key? key, this.name, this.roomId, this.otherUserUid, this.userUid,
      })
      : super(key: key);

  ChatBoxController controller = Get.put(ChatBoxController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {

        controller.msController.clear();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: ColorRes.backgroundColor,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: InkWell(
                      onTap: () {

                        controller.msController.clear();
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
                    ),
                  ),
                  const SizedBox(width: 85),
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
                ],
              ),
              const SizedBox(height: 12),
              Center(
                child: Container(
                  height: 92,
                  width: Get.width,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
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
                      Expanded(
                          child: Row(
                        children: [
                          Image.asset(
                            AssetRes.chatbox_Men_Image,
                          ),
                          const SizedBox(width: 20),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name.toString(),
                                style: appTextStyle(
                                    color: ColorRes.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "Online",
                                style: appTextStyle(
                                    color: ColorRes.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ],
                      )),

                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (con) => const CallJoinScreen(),
                            ),
                          );
                        },
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color: ColorRes.logoColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          child: const Icon(Icons.call,
                              color: ColorRes.containerColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: PaginateFirestore(
                    scrollController: controller.listScrollController,
                    isLive: true,
                    reverse: true,
                    query: FirebaseFirestore.instance
                        .collection("chats")
                        .doc(roomId)
                        .collection(roomId!)
                        .orderBy("time", descending: true),
                    itemBuilderType: PaginateBuilderType.listView,
                    itemBuilder: (context, docementSnapshot, index) {
                      Map<String, dynamic>? data = docementSnapshot[index]
                          .data() as Map<String, dynamic>?;
                      if (data == null) {
                        return const SizedBox();
                      }
                      /* if (index == 0) {
                        controller.lastMsg = data['time'].toDate();
                      }*/

                      if (data['read'] != true &&
                          data['senderUid'].toString() != userUid) {
                        controller.setReadTrue(docementSnapshot[index].id);
                      }

                      Widget box = data['type'] == "alert"
                          ? const SizedBox()
                          : Column(
                              children: [
                                SizedBox(
                                  width: Get.width,
                                  height: 35,
                                  child: Center(
                                    child: Text(
                                      controller.timeAgo(data['time'].toDate()),
                                      style: TextStyle(
                                        color: Colors.grey.withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      data['senderUid'].toString() == userUid
                                          ? MainAxisAlignment.end
                                          : MainAxisAlignment.start,
                                  children: [
                                    // Text(controller.data['time'].toString(),style: sfProTextReguler(fontSize: 12,color:ColorRes.colorF0F0F0 ),),

                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      constraints: BoxConstraints(
                                        maxWidth: Get.width / 1.3,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient:
                                            data['senderUid'].toString() ==
                                                    userUid
                                                ? const LinearGradient(colors: [
                                                    ColorRes.gradientColor,
                                                    ColorRes.containerColor,
                                                  ])
                                                :  LinearGradient(colors: [
                                              ColorRes.containerColor.withOpacity(0.1),
                                              ColorRes.containerColor.withOpacity(0.1),
                                                  ]),
                                        /* color: data['senderUid']
                                        .toString() ==
                                        userUid
                                        ? Colors.green
                                        : Colors.lightBlue*/
                                      ),
                                      child: Text(
                                        data['content'].toString(),
                                        style: data['senderUid'].toString() ==
                                                userUid
                                            ? const TextStyle(
                                                fontSize: 17,
                                                color: ColorRes.white)
                                            : const TextStyle(
                                                fontSize: 17,
                                                color: ColorRes.black),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                              ],
                            );
                      if ((index + 1) == docementSnapshot.length) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            box,
                          ],
                        );
                      }

                      return box;
                    },
                    ),
              ),
              const SizedBox(
                height: 15,
              ),
              GetBuilder<ChatBoxController>(
                  id: "message",
                  builder: (controller) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: ColorRes.containerColor.withOpacity(0.2),
                            width: 1),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: ColorRes.white,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: controller.msController,
                              style: const TextStyle(color: ColorRes.black),
                              decoration: const InputDecoration(
                                  hintText: "Type message...",
                                  hintStyle: TextStyle(
                                      fontSize: 17, color: Colors.grey),
                                  border: InputBorder.none),
                            ),
                          ),
                          InkWell(
                            onTap: () {


                              if (controller.validation()) {
                                controller.sendMessage(
                                  roomId.toString(),
                                  otherUserUid,
                                );
                                FocusScope.of(context).unfocus();
                              }
                            },
                            child: Image.asset(
                              AssetRes.chatSend,
                              height: 25,
                              width: 25,
                              color: ColorRes.containerColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
              const SizedBox(
                height: 15,
              ),
            ]),
      ),
    );
  }
}
