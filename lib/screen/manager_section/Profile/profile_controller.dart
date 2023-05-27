import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobseek/screen/manager_section/Profile/edit_profile/edit_profile_screen.dart';
import 'package:jobseek/service/pref_services.dart';
import 'package:jobseek/utils/app_res.dart';
import 'package:jobseek/utils/pref_keys.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileController extends GetxController implements GetxService {
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyEmailController = TextEditingController();
  TextEditingController companyAddressController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  static FirebaseFirestore fireStore = FirebaseFirestore.instance;
  RxBool isNameValidate = false.obs;
  RxBool isEmailValidate = false.obs;
  RxBool isAddressValidate = false.obs;
  RxBool isCountryValidate = false.obs;
  RxBool isDateController = false.obs;
  RxBool isLod = false.obs;
  // RxString fbImageUrlM = "".obs;

  DateTime? startTime;
  ImagePicker picker = ImagePicker();
  File? image;
  String url = '';
  Future<void> onDatePickerTap(context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            primarySwatch: Colors.blue,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      if (kDebugMode) {
        startTime = picked;
      }
      if (kDebugMode) {
        print("START TIME : $startTime");
      }
      dateController.text =
          "${picked.toLocal().month}/${picked.toLocal().day}/${picked.toLocal().year}";
      update();
    }
  }

  init() {
    isLod.value = true;
    final docRef = fireStore
        .collection("Auth")
        .doc("Manager")
        .collection("register")
        .doc(PrefService.getString(PrefKeys.userId))
        .collection("company")
        .doc("details");
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        companyNameController.text = data["name"];
        companyEmailController.text = data["email"];
        companyAddressController.text = data["address"];
        dateController.text = data["date"];
        countryController.text = data["country"];
        url = data["imageUrl"];
        image = File(PrefService.getString(PrefKeys.imageManager));
        update();

        imagePicker();
        isLod.value = false;
      },
      onError: (e) {
        Get.snackbar("Error getting document:", "$e",
            colorText: const Color(0xffDA1414));
        if (kDebugMode) {
          print("Error getting document: $e");
        }
      },
    );
  }

  onTapEdit() {
    if (kDebugMode) {
      print("GO TO Edit Profile");
    }
    Get.to(EditProfileScreen());
  }

  changeDropdwon({required String val}) {
    dropDownValue = val;
    countryController.text = dropDownValue;

    update(["dropdown"]);
  }

  onTapSubmit() async {
    validate();
    if (isNameValidate.value == false &&
        isEmailValidate.value == false &&
        isAddressValidate.value == false &&
        isCountryValidate.value == false &&
        isDateController.value == false) {
      String uid = PrefService.getString(PrefKeys.userId);
      Map<String, dynamic> map = {
        "email": companyEmailController.text.trim(),
        "name": companyNameController.text.trim(),
        "date": dateController.text.trim(),
        "country": countryController.text.trim(),
        "address": companyAddressController.text.trim(),
        "imageUrl": url,
      };
      /*    PrefService.setValue(
        PrefKeys.imageManager,
        url,
      );*/


      await fireStore
          .collection("Auth")
          .doc("Manager")
          .collection("register")
          .doc(uid)
          .collection("company")
          .doc("details")
          .update(map);

      await fireStore
          .collection("allPost")
          .where("Id", isEqualTo: uid)
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((element) async {
          await fireStore.collection("allPost").doc(element.id).update(
              {
                "CompanyName": companyNameController.text.trim().toString(),
                "date": dateController.text.trim(),
                "country": countryController.text.trim(),
                "address": companyAddressController.text.trim(),
                "imageUrl": url,
              });
        });
      });

      if (kDebugMode) {
        print("GO TO HOME PAGE");
      }
      init();
      Get.back();
      // Get.to(ManagerDashBoardScreen());
    }
  }

  validate() {
    if (companyNameController.text.isEmpty) {
      isNameValidate.value = true;
    } else {
      isNameValidate.value = false;
    }
    if (companyEmailController.text.isEmpty ||
        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(companyEmailController.text)) {
      isEmailValidate.value = true;
    } else {
      isEmailValidate.value = false;
    }
    if (companyAddressController.text.isEmpty) {
      isAddressValidate.value = true;
    } else {
      isAddressValidate.value = false;
    }
    if (countryController.text.isEmpty) {
      isCountryValidate.value = true;
    } else {
      isCountryValidate.value = false;
    }
    if (dateController.text.isEmpty) {
      isDateController.value = true;
    } else {
      isDateController.value = false;
    }
  }

  validateAndSubmit() {
    Get.toNamed(AppRes.managerDashboardScreen);
/*    if (companyNameController.text.isEmpty) {
      isNameValidate.value = true;
    } else {
      isNameValidate.value = false;
    }
    if (companyEmailController.text.isEmpty ||
        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(companyEmailController.text)) {
      isEmailValidate.value = true;
    } else {
      isEmailValidate.value = false;
    }
    if (companyAddressController.text.isEmpty) {
      isAddressValidate.value = true;
    } else {
      isAddressValidate.value = false;
    }*/
  }

  String dropDownValue = 'India';

  var items = [
    'India',
    'United States',
    'Europe',
    'china',
    'United Kingdom',
    " Cuba",
    "	Havana",
    "Cyprus",
    "Nicosia",
    "Czech ",
    "Republic",
    "Prague",
  ];
  onTapImage() async {
    XFile? img = await picker.pickImage(source: ImageSource.camera);
    String path = img!.path;
    image = File(path);
    url =  (await uploadImage(
        flow: image,
        path: PrefService.getString(PrefKeys.userId)))!;
    PrefService.setValue(PrefKeys.imageUrlM, url);
    Get.back();
    imagePicker();
  }



  Future<String?> uploadImage({File? flow, String? path}) async {
    final firebaseStorage = FirebaseStorage.instance;
    String? imageUrl;

    var snapshot =
    await firebaseStorage.ref().child(path!).putFile(flow!);
    String downloadUrl = await snapshot.ref.getDownloadURL();

    imageUrl = downloadUrl;
    print(imageUrl);
    return imageUrl;
  }

  onTapGallery1() async {
    XFile? gallery = await picker.pickImage(source: ImageSource.gallery);
    String path = gallery!.path;
    image = File(path);
    url =  (await uploadImage(
        flow: image,
        path:  PrefService.getString(PrefKeys.userId)))!;
    PrefService.setValue(PrefKeys.imageUrlM, url);
    print(url);
    Get.back();
    imagePicker();
  }

  imagePicker() {
    update(['gallery']);
    update(['onTap']);
    update(['image']);
    update();
  }

  void onChanged(String value) {
    update(["colorChange"]);
  }
}
