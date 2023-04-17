import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobseek/common/widgets/backButton.dart';

import 'package:jobseek/screen/faq_screen/faq_controller.dart';
import '../../utils/color_res.dart';

class FaqScreen extends StatelessWidget {
  FaqScreen({Key? key}) : super(key: key);
  final FaqController controller = Get.put(FaqController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: backButton(),
                  ),
                ),
                const Text(
                  'FAQs',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      height: 1,
                      color: ColorRes.black),
                ),
                Visibility(
                  visible: false,
                  maintainAnimation: true,
                  maintainSize: true,
                  maintainState: true,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: backButton(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            GetBuilder<FaqController>(
              id: "faq",
              builder: (faq) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  height: Get.height - 160,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount:
                        controller.data == null ? 0 : controller.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: faq.selected[index]
                                  ? ColorRes.containerColor
                                  : ColorRes.lightGrey),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: Get.width * 0.64,
                                  child: Text(
                                    controller.data![index]['title'].toString(),
                                    style: const TextStyle(
                                        fontSize: 15, color: ColorRes.black),
                                  ),
                                ),
                                InkWell(
                                  onTap: () => faq.onchange(index),
                                  child: faq.selected[index]
                                      ? const Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: ColorRes.black,
                                          size: 20,
                                        )
                                      : const Icon(
                                          Icons.keyboard_arrow_right,
                                          color: ColorRes.black,
                                          size: 20,
                                        ),
                                )
                              ],
                            ),
                            faq.selected[index]
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          controller.data[index]['description']
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 14,
                                              height: 2,
                                              letterSpacing: 1.0,
                                              color: ColorRes.grey))
                                    ],
                                  )
                                : const SizedBox()
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
