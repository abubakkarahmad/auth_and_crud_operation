import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../home_screen/expesnes.dart';
import '../home_screen/home.dart';
import '../home_screen/more.dart';
import '../home_screen/profile.dart';



class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int pageIndex = 0;

  final pages = [
    const Home(),
    const Expenses(),
    const More(),
    const Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: pages[pageIndex],
        bottomNavigationBar: buildMyNavBar(context),
      ),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8.w, right: 8.w, bottom: 5.h),
      height: 56.h,
      width: 370.w,
      decoration: BoxDecoration(
        color: Colors.white38,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildNavBarItem(0, Icons.home, "Home"),
          buildNavBarItem(1, Icons.report_gmailerrorred, "Expenses"),
          buildNavBarItem(2, Icons.record_voice_over_outlined, "Details"),
          buildNavBarItem(3, Icons.person, "Profile"),
        ],
      ),
    );
  }

  Widget buildNavBarItem(int index, IconData icon, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          pageIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: pageIndex == index ? Colors.orange : Colors.black54,
            size: 30,
          ),
          Text(
            label,
            style: TextStyle(
              color: pageIndex == index ? Colors.orange : Colors.black54,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
