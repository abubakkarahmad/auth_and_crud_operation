import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../utilities/snackbar.dart';

void saveData(BuildContext context, Map<String, dynamic> formData) {
  final _auth = FirebaseAuth.instance.currentUser;
  final firestore = FirebaseFirestore.instance;

  if (_auth != null) {

    final Map<String, dynamic> bookingData = {
      'name': formData['name'],
      'address': formData['address'],
    };

    firestore
        .collection("Users")
        .doc(_auth.uid)
        .collection("booking")
        .add(bookingData)

        .then((value) async{
      EasyLoading.dismiss();
      SnackBarHelper.showMessage(
          context, "Addeed data successfully!", Colors.green);
      Navigator.pop(context);
    }).catchError((error) {
      print("Failed to save data: $error");
    });
  } else {
    print("User not authenticated.");
  }
}