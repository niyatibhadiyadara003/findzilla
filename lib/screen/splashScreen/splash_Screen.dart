import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobseek/api/api_country.dart';
import 'package:jobseek/screen/dashboard/dashboard_controller.dart';
import 'package:jobseek/screen/dashboard/dashboard_screen.dart';
import 'package:jobseek/screen/manager_section/dashboard/manager_dashboard_screen.dart';
import 'package:jobseek/screen/organization_profile_screen/organization_profile_screen.dart';
import 'package:jobseek/screen/splashScreen/splash_controller.dart';
import 'package:jobseek/service/pref_services.dart';
import 'package:jobseek/utils/asset_res.dart';
import 'package:jobseek/utils/color_res.dart';
import 'package:jobseek/utils/pref_keys.dart';
import 'package:jobseek/utils/string.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashController controller = Get.put(SplashController());
  @override
  void initState() {
    super.initState();
    getpref();



  }
  getpref()async{
  await  PrefService.init();
  if (PrefService.getList(PrefKeys.allDesignation) == null ||
      PrefService.getList(PrefKeys.allDesignation).isEmpty ||
      PrefService.getList(PrefKeys.allCountryData) == null ||
      PrefService.getList(PrefKeys.allCountryData).isEmpty) {
    countryApi();
  }
  splash();
  }

  void splash() async {
    String token = PrefService.getString(PrefKeys.userId);
    String rol = PrefService.getString(PrefKeys.rol);
    bool company = PrefService.getBool(PrefKeys.company);
    await Future.delayed(const Duration(seconds: 3), () {
      final DashBoardController controller = Get.put(DashBoardController());
      controller.currentTab = 0;
      Get.off(() => token == ""
          ? DashBoardScreen()
          : rol == "User"
              ? DashBoardScreen()
              : company
                  ? ManagerDashBoardScreen()
                  : const OrganizationProfileScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider backgroundImage =
        const AssetImage(AssetRes.splash_screenback);
    backgroundImage.resolve(createLocalImageConfiguration(context));
    ImageProvider backgroundImageBoy = const AssetImage(AssetRes.splashBoyImg);
    backgroundImageBoy.resolve(createLocalImageConfiguration(context));
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
            image: DecorationImage(image: backgroundImage, fit: BoxFit.fill)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(top: 54, right: 30),
              child: Text(
                textAlign: TextAlign.end,
                Strings.logo,
                style: GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    color: ColorRes.splashLogoColor),
              ),
            ),
            SizedBox(
              height: 140,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: ' Find Your  \n',
                              style: GoogleFonts.poppins(
                                color: ColorRes.black2,
                                fontWeight: FontWeight.w500,
                                fontSize: 40,
                                height: 1,
                              )),
                          TextSpan(
                            text: ' dream job \n',
                            style: GoogleFonts.poppins(
                              fontSize: 40,
                              fontWeight: FontWeight.w500,
                              color: ColorRes.black2,
                              background: Paint()..color = Colors.white,
                              height: 1,
                            ),
                          ),
                          TextSpan(
                              text: ' here',
                              style: GoogleFonts.poppins(
                                  color: ColorRes.black2,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 40,
                                  height: 1))
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      height: 140,
                      alignment: Alignment.bottomRight,
                      child: Container(
                        margin: const EdgeInsets.only(right: 33),
                        alignment: Alignment.center,
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            shape: BoxShape.circle,
                            color: ColorRes.black2),
                        child: const Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            Image.asset(
              AssetRes.splashBoyImg,
              height: Get.height < 657 ? Get.height / 2 : Get.height / 1.6,
              width: Get.width,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.none,
            )
          ],
        ),
      ),
    );
  }

  countryApi() async {
    controller.countryData = await CountrySearch.countNotification();

    controller.countryData!.forEach((element) {
      controller.allData.add(element.name ?? "");
      element.state!.forEach((el) {
        controller.allData.add(el.name ?? "");
        el.city!.forEach((e) {
          controller.allData.add(e.name ?? "");
        });
      });
    });

    if (kDebugMode) {
      print(PrefService.getList(PrefKeys.allDesignation));
    }
    if (PrefService.getList(PrefKeys.allCountryData) == null ||
        PrefService.getList(PrefKeys.allCountryData).isEmpty) {
      PrefService.setValue(PrefKeys.allCountryData, controller.allData);
    }

    if (PrefService.getList(PrefKeys.allDesignation) == null ||
        PrefService.getList(PrefKeys.allDesignation).isEmpty) {
      PrefService.setValue(PrefKeys.allDesignation, controller.allDesignation);
    }
  }
}
