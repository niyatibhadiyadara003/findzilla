import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobseek/screen/auth/sign_inScreen/Signin_Screen.dart';
import 'package:jobseek/screen/looking_for_screen/looking_for_screen.dart';
import 'package:jobseek/utils/app_style.dart';
import 'package:jobseek/utils/asset_res.dart';
import 'package:jobseek/utils/color_res.dart';



class AppliesLogoScreen extends StatelessWidget {
  const AppliesLogoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Container(
              alignment: Alignment.center,
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: ColorRes.logoColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Logo',
                style: appTextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  color: ColorRes.containerColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          const Center(
            child: Image(
              image: AssetImage(AssetRes.appliesLogo),
              height: 150,
            ),
          ),
          const SizedBox(height: 30),
          Center(
            child: Text("One place to track all your \njob applications",
                style: GoogleFonts.playfairDisplay(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: ColorRes.black),
                textAlign: TextAlign.center),
          ),
          const SizedBox(height: 15),
          Center(
            child: Text(
              "Watch out and apply to jobs with \nhigh match scores and get real-time \nupdates",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: ColorRes.black.withOpacity(0.8),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 40),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (con) => const LookingForScreen()));
            },
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(top: 15),
                height: 36,
                width: 147,
                decoration: BoxDecoration(
                  color: ColorRes.containerColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "Register for free",
                    style: TextStyle(
                        color: ColorRes.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account?",
                style: appTextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: const Color(0xff555555)),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (con) => SigninScreenU()));
                },
                child: Text(
                  'Login',
                  style: appTextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: ColorRes.containerColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
