import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:jobseek/common/widgets/backButton.dart';
import 'package:jobseek/utils/color_res.dart';

class TermsAndServicesScreen extends StatelessWidget {
  TermsAndServicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
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
              const SizedBox(width: 46),
              const Text(
                "Terms & Condition",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    height: 1,
                    color: ColorRes.black),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 600,
            width: Get.width,
            child: PDFView(
                filePath: "assets/pdf/termsCondition.pdf",
                enableSwipe: true,
                swipeHorizontal: true,
                autoSpacing: false,
                pageFling: true,
                pageSnap: true,
                defaultPage: 0,
                fitPolicy: FitPolicy.BOTH,
                preventLinkNavigation: false,
                // if set to true the link is handled in flutter
                onRender: (pages) {},
                onError: (error) {},
                onPageError: (page, error) {},
                onViewCreated: (PDFViewController pdfViewController) {},
                onLinkHandler: (String? uri) {},
                onPageChanged: (int? page, int? total) {}),
          ),
        ],
      ),
    );
  }
}
