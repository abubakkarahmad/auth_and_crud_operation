import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _HomeState();
}

class _HomeState extends State<Expenses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Expenses"),),
    );
  }
}
