import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../auth_screen/login.dart';
import '../class_home/bottom_nav_bar.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      whichScreen(context);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: "Aubakkar",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 86),
              child: RichText(
                text: const TextSpan(
                  text: "Ahmad",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.black26,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




whichScreen(BuildContext context) {
  FirebaseAuth _auth = FirebaseAuth.instance;
  if (_auth.currentUser == null) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) =>  Login(),
        ),
            (route) => false);
  } else {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) =>  const BottomNavBar(),
        ),
            (route) => false);
  }
}






