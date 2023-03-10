import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ForgotPasswordController extends GetxController {

  bool isselected = false;
 bool isselectedemail = false;
  mobileUpdate() {
    debugPrint("isselected $isselected");
    if   (isselectedemail ==true){
      isselectedemail = false;
    }
    isselected = !isselected;
    update(['SMS']);
  }

  emailUpdate() {
    debugPrint("isselectedemail $isselectedemail");
    if   (isselected ==true){
      isselected = false;
    }
    isselectedemail = !isselectedemail;
    update(['SMS']);
  }
}
