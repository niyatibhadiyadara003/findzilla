import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:jobseek/common/widgets/backButton.dart';
import 'package:jobseek/utils/color_res.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                "Privacy Policy",
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
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 600,
            width: Get.width,
            child: SfPdfViewer.asset("assets/pdf/privacyPolicy.pdf"),
          ),
        ],
      ),
    );
  }
}
