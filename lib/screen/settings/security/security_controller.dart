import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SecurityControllerU extends GetxController implements GetxService {
  RxBool isSwitchedFace = true.obs;
  RxBool isSwitchedRemember = true.obs;
  RxBool isSwitchedTouch = false.obs;


  onchangeFace(value){
    isSwitchedFace.value = value;
    update();
  }
  onchangeRemember(value){
    isSwitchedRemember.value = value;
    update();
  }
  onchangeTouch(value){
    isSwitchedTouch.value = value;
    update();
  }

}
