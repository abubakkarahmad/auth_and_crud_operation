import 'package:auth_with_provider/home_screen/expesnes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utilities/snackbar.dart';
import '../widgets/textform_field.dart';
import 'add_data.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _auth = FirebaseAuth.instance.currentUser;
  final address_c = TextEditingController();

  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  void dispose() {
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white38,
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.lightBlueAccent,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error: ${snapshot.error}"),
                  );
                } else if(snapshot.data!.docs.isEmpty){
                  return const Center(
                    child: Text("No Booking found",style: TextStyle(color: Colors.black45,fontSize: 14),),
                  );
                }

                else {
                  return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      var booking = snapshot.data!.docs[index];
                      var name = booking['name'];
                      var address = booking['address'];
                      var bookingId = booking.id;

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation:
                          2,
                          color: Colors.white60,
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                      AssetImage("images/assets/img.png"),
                                      radius: 40.r,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '$name',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black87),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.location_on,
                                                color: Colors.lightBlueAccent,
                                              ),
                                              Text(' $address',style: TextStyle(fontSize: 15),),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        EasyLoading.show();
                                        deleteBooking(bookingId);
                                      },
                                      style: ButtonStyle(
                                        fixedSize: MaterialStateProperty.all(
                                            Size(138.w, 30.h)),
                                        backgroundColor:
                                        MaterialStateProperty.all(
                                            Colors.white),
                                        side: MaterialStateProperty.all(
                                            const BorderSide(
                                                color: Colors.black54,
                                                style: BorderStyle.solid)),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(10))),
                                      ),
                                      child: const Text(
                                        "Delete",
                                        style: TextStyle(
                                            color: Colors.lightBlueAccent),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return dialog(
                                              bookingId,
                                              address
                                            );
                                          },
                                        );
                                      },
                                      style: ButtonStyle(
                                        fixedSize: MaterialStateProperty.all(Size(138.w, 30.h)),
                                        backgroundColor: MaterialStateProperty.all(Colors.white),
                                        side: MaterialStateProperty.all(
                                          BorderSide(color: Colors.black54, style: BorderStyle.solid),
                                        ),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                      child: const Text(
                                        "Update",
                                        style: TextStyle(color: Colors.lightBlueAccent),
                                      ),
                                    ),

                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddData(),));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Stream<QuerySnapshot> getData() {
    final _auth = FirebaseAuth.instance.currentUser;
    final firestore = FirebaseFirestore.instance;
    return firestore
        .collection("Users")
        .doc(_auth?.uid)
        .collection("booking")
        .snapshots();
  }

  void deleteBooking(String bookingId) async {
    try {
      final firestore = FirebaseFirestore.instance;
      await firestore
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("booking")
          .doc(bookingId)
          .delete();
      // Refresh UI by rebuilding the widget or updating the state
      EasyLoading.dismiss(animation: false);
      setState(() {});
      // Show a snack bar or a message indicating successful cancellation
      SnackBarHelper.showMessage(context, "Booking cancelled successfully",Colors.blueAccent);
    } catch (error) {
      // Handle errors, show error message
      SnackBarHelper.showMessage(context, "Failed to cancel booking: $error",Colors.red);
    }
  }
  void rescheduleBooking(String bookingId, Map<String, dynamic> updateData) async {
    try {
      final firestore = FirebaseFirestore.instance;
      await firestore
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("booking")
          .doc(bookingId)
          .update(updateData);

      setState(() {});
      Navigator.pop(context);

      SnackBarHelper.showMessage(context, "Booking rescheduled successfully", Colors.blueAccent);
    } catch (error) {
      SnackBarHelper.showMessage(context, "Failed to reschedule booking: $error", Colors.red);
    }
  }


  Widget dialog(String bookingId, String address) {
    TextEditingController addressController = TextEditingController(text: address);

    return Column(
      children: [
        AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            "Update your Data",
            style: TextStyle(color: Colors.lightBlueAccent, fontSize: 20, fontWeight: FontWeight.w600),
          ),
          content: Column(
            children: [
              SizedBox(height: 20),
              textFormField(addressController, "Address", Icons.location_on),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Map<String, dynamic> updateData = {
                  'address': addressController.text,
                };
                rescheduleBooking(bookingId, updateData);
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size(120.w, 30.h)),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                side: MaterialStateProperty.all(
                  const BorderSide(color: Colors.black54, style: BorderStyle.solid),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              child: const Text(
                "Update",
                style: TextStyle(color: Colors.lightBlueAccent, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ],
    );
  }


}