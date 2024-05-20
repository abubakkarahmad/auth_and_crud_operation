import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class More extends StatefulWidget {
  const More({super.key});

  @override
  State<More> createState() => _HomeState();
}

class _HomeState extends State<More> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("More"),),
    );
  }
}
