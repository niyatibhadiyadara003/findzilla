import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebaseServices {
  static FirebaseFirestore fireStore = FirebaseFirestore.instance;

  static Future<void> createData(
      {firstName,
      lastName,
      email,
      phoneNumber,
      city,
      country,
      state,
      String? s, required String name, required String date, required String address}) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? users = auth.currentUser;
    final uid = users!.uid;
    if (kDebugMode) {
      print("USER UID $uid");
    }
    DocumentReference documentRefence = FirebaseFirestore.instance
        .collection("Auth")
        .doc("Manager")
        .collection("register")
        .doc("taru uid");
    Map<String, dynamic> user = {
      'FirstName': firstName,
      'LastName': lastName,
      'email': email,
      'PhoneNumber': phoneNumber,
      'city': city,
      'country': country,
      'state': state,
    };
    await documentRefence.set(user).whenComplete(() {
      if (kDebugMode) {
        print('$user Created');
      }
    });
  }

  void readData(
    firstName,
    lastName,
    email,
    phoneNumber,
    city,
    country,
    state,
  ) {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("Auth")
        .doc("Manager")
        .collection("register")
        .doc("taru uid");
    Map<String, dynamic> user = {
      'FirstName': firstName,
      'LastName': lastName,
      'email': email,
      'PhoneNumber': phoneNumber,
      'city': city,
      'country': country,
      'state': state,
    };
  }
}