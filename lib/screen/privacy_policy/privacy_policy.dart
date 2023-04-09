import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobseek/common/widgets/backButton.dart';
import 'package:jobseek/utils/color_res.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

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
                "Privacy Policy",
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
          Text("")
        ],
      ),
    );
  }
}
