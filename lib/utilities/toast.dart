import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void toast(text){
  Fluttertoast.showToast(
      msg: text,
      fontSize: 18,
      backgroundColor: Colors.red,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.black);
}
void successToast(text){
  Fluttertoast.showToast(
      msg: text,
      fontSize: 18,
      backgroundColor: Colors.blue,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.black);
}