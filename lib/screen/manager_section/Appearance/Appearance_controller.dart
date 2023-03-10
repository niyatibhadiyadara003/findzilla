import 'package:get/get.dart';

class AppearanceController extends GetxController implements GetxService {
  RxBool isSwitchedDarkMode = false.obs;
  RxBool isSwitchedLocalization= false.obs;
  RxBool isSwitchedBlurBackground = true.obs;
  RxBool isSwitchedFullScreenMode = true.obs;

  onchangeDarkMode(value) {
    isSwitchedDarkMode.value = value;
    update();
  }
  onchangeLocalization(value) {
    isSwitchedLocalization.value = value;
    update();
  }

  onchangeBackground(value) {
    isSwitchedBlurBackground.value = value;
    update();
  }

  onchangeFullScreenMode(value) {
    isSwitchedFullScreenMode.value = value;
    update();
  }
}
