import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget textFormField(controller, text, icon) {
  return TextFormField(
    maxLength: 19,
    style: TextStyle(color: Colors.black),
    controller: controller,
    decoration: InputDecoration(
        labelText: text,
        suffixIcon: Icon(icon),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.white10))),
    onTap: () {

    },
  );
}