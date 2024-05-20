import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../provider/circular_indicator.dart';
import '../provider/login.dart';
import '../utilities/toast.dart';

class ForgotPasswordByEmail extends StatelessWidget {
  ForgotPasswordByEmail({super.key});

  final TextEditingController email_c = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    final progressIndicator =
    Provider.of<CircularIndicatorProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Forgot password"),centerTitle: true,backgroundColor: Colors.lightBlueAccent,),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: email_c,
              onChanged: (value) {
                loginProvider.validateEmail(value);
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  errorText: loginProvider.emailValidationError,
                  hintText: "Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.black))),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(right: 30.w, left: 30.w,top: 14.h),
            child: progressIndicator.loading
                ? CircularProgressIndicator(color: Colors.red)
                : ElevatedButton(
              onPressed: loginProvider.isLoginButtonEnabled()
                  ? () {
                forgotByEmail(context, email_c.text.toString());
              }
                  : null,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(18),
                ),
                backgroundColor: Colors.lightBlueAccent,
              ),
              child: const SizedBox(
                width: double.infinity,
                height: 40,
                child: Center(
                  child: Text(
                    "Send Link to email",
                    style: TextStyle(
                        fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void forgotByEmail(BuildContext context, String email) {
  final progressIndicator =
  Provider.of<CircularIndicatorProvider>(context, listen: false);
  final FirebaseAuth auth = FirebaseAuth.instance;
  progressIndicator.circularProgressIndicator(true); // Start the progress indicator

  try{
    auth.sendPasswordResetEmail(email: email).then((value) {
      successToast("Email Send successfully check your email and reset password");
      progressIndicator.circularProgressIndicator(false); // Stop the progress indicator on success
    }).catchError((error) {
      toast(error.toString());
      progressIndicator.circularProgressIndicator(false); // Stop the progress indicator on error
    });
  }catch(e){
    toast(e.toString());
  }
}

