import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnackBarHelper {
  static void showMessage(BuildContext context, String text, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: color,
      ),
    );
  }
}