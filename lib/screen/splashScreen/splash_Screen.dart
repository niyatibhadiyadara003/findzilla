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
    ImageProvider backgroundImage = const AssetImage(AssetRes.splash_screenback);
    backgroundImage.resolve(createLocalImageConfiguration(context));
    ImageProvider backgroundImageBoy = const AssetImage(AssetRes.splashBoyImg);
    backgroundImageBoy.resolve(createLocalImageConfiguration(context));
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Align(
                alignment: Alignment.topRight,
                child: Image.asset(AssetRes.small_logo, height: 40,),
              ),
            ),
           Align(
             alignment: Alignment.topLeft,
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 const Padding(
                   padding: EdgeInsets.only(left: 20),
                   child: Text("Find your", style: TextStyle(fontSize: 50, fontWeight: FontWeight.w500, color: ColorRes.color343740),),
                 ),
                 Stack(
                   alignment: Alignment.centerLeft,
                   children: [
                     Container(
                       height: 50,
                       width: 230,
                       color: ColorRes.colorFFF2DA,
                     ),
                     const Padding(
                       padding: EdgeInsets.only(left: 20),
                       child: Text("dream job", style: TextStyle(fontSize: 50, fontWeight: FontWeight.w500, color: ColorRes.color343740),),
                     ),

                   ],
                 ),
                 const Padding(
                   padding: EdgeInsets.only(left: 20),
                   child: Text("here", style: TextStyle(fontSize: 50, fontWeight: FontWeight.w500, color: ColorRes.color343740),),
                 ),
               ],
             ),
           ),
            const Spacer(flex: 1,),
            Image.asset(AssetRes.splashImage),
            const Spacer(flex: 2),
            const Align(
              alignment: Alignment.center,
              child: Text("Findzilla", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500, color: ColorRes.containerColor),),
            ),
            const SizedBox(height: 30),
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
