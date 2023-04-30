import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobseek/service/pref_services.dart';
import 'package:jobseek/utils/app_res.dart';
import 'package:jobseek/utils/app_style.dart';
import 'package:jobseek/utils/asset_res.dart';
import 'package:jobseek/utils/color_res.dart';
import 'package:jobseek/utils/pref_keys.dart';
import 'package:jobseek/utils/string.dart';

Widget homeAppBar() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          AssetRes.small_logo,
          height: 40,
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      Strings.hello,
                      style: appTextStyle(
                          color: ColorRes.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      PrefService.getString(PrefKeys.fullName),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: appTextStyle(
                          color: ColorRes.containerColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 40,
          width: 40,
        ),

      ],
    ),
  );
}
