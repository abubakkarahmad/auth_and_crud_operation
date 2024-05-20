import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../class_home/set_data.dart';
import '../utilities/snackbar.dart';
import '../widgets/textform_field.dart';



class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  State<AddData> createState() => _BookingState();
}

class _BookingState extends State<AddData> {
  final name_c = TextEditingController();
  final address_c = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    name_c.dispose();
    address_c.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        title: const Text("Add Data"),centerTitle: true,backgroundColor: Colors.lightBlueAccent,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Column(
            children: [
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                          padding: EdgeInsets.only(left: 8.w, right: 8.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  SizedBox(height: 16.h),
                                  textFormField(
                                      name_c, "Full Name", Icons.person),
                                  SizedBox(height: 14.h),
                                  SizedBox(height: 20.h),
                                  textFormField(
                                      address_c, "Address", Icons.home_work),
                                  SizedBox(height: 30.h),
                                ],
                              ),
                              Card(
                                color: Colors.lightBlueAccent,
                                child: SizedBox(
                                  height: 80.h,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                     mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            EasyLoading.show();
                                            if (name_c.text.isNotEmpty &&
                                                address_c.text.isNotEmpty) {
                                              final formData = {
                                                'name': name_c.text,
                                                'address': address_c.text,
                                              };
                                              saveData(context, formData);
                                            } else {
                                              EasyLoading.dismiss();
                                              SnackBarHelper.showMessage(
                                                  context,
                                                  "Please fill all field",
                                                  Colors.red);
                                            }
                                          },
                                          style: ButtonStyle(
                                            fixedSize: MaterialStateProperty.all(
                                                Size(120.w, 30.h)),
                                            backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white),
                                            side: MaterialStateProperty.all(
                                                const BorderSide(
                                                  color: Colors.black54,
                                                  style: BorderStyle.solid,
                                                )),
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                )),
                                          ),
                                          child: const Text(
                                            'Confirm',
                                            style: TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.h)
                            ],
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




