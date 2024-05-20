import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../provider/circular_indicator.dart';
import '../provider/login.dart';
import '../utilities/toast.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobNoController = TextEditingController();
  TextEditingController passwordController1 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  ValueNotifier<bool> toogle = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    final loginProviderSecond = Provider.of<LoginProviderSecond>(context);
    final progressIndicatorpprovider = Provider.of<CircularProgressIndicatorProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Create account"),centerTitle: true,backgroundColor: Colors.lightBlueAccent,),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: "Full Name",
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                onChanged: (value) {
                  loginProvider.validateEmail(value);
                },
                decoration: InputDecoration(errorText: loginProvider.emailValidationError,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: "Email",
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: mobNoController,
                keyboardType: TextInputType.number,
                maxLength: 14  ,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: "Mob No",
                ),
              ),
              SizedBox(height: 10),
              Padding(
                  padding: const EdgeInsets.only(right: 8, left: 8, top: 8),
                  child: ValueListenableBuilder(valueListenable: toogle,
                    builder: (context, value, child) {
                      return TextFormField(
                        controller: passwordController1,
                        onChanged: (value) {
                          loginProvider.validatePassword(value);
                        },
                        obscureText: toogle.value,
                        decoration: InputDecoration(suffixIcon: InkWell(onTap: () {
                          toogle.value = !toogle.value;
                        },
                            child: Icon(toogle.value ? Icons.visibility_off : Icons.visibility)),
                          labelText: "Password",
                          errorText: loginProvider.passwordValidationError,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      );
                    },)
              ),
              SizedBox(height: 10),
              Padding(
                  padding: const EdgeInsets.only(right: 8, left: 8, top: 8),
                  child: ValueListenableBuilder(valueListenable: toogle,
                    builder: (context, value, child) {
                      return TextFormField(
                        controller: passwordController2,
                        onChanged: (value) {
                          loginProviderSecond.validatePassword(value);
                        },
                        obscureText: toogle.value,
                        decoration: InputDecoration(suffixIcon: InkWell(onTap: () {
                          toogle.value = !toogle.value;
                        },
                            child: Icon(toogle.value ? Icons.visibility_off : Icons.visibility)),
                          labelText: "Password",
                          errorText: loginProviderSecond.passwordValidationError,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      );
                    },)
              ),
              const SizedBox(height: 20),
              progressIndicatorpprovider.isLoggedIn ? CircularProgressIndicator(color: Colors.red) :
              ElevatedButton(
                onPressed: () {
                  progressIndicatorpprovider.cicularIndicator(true);
                  if(passwordController1.text.trim() == passwordController2.text.trim()){
                    signUpWithEmailAndPassword(
                      emailController.text.trim(),
                      passwordController1.text.trim(),
                    ).then((value) {
                      progressIndicatorpprovider.cicularIndicator(false);
                    },).onError((error, stackTrace) {
                      toast(error.toString());
                    });
                  }
                  else{
                    progressIndicatorpprovider.cicularIndicator(false);
                    toast("Password not matched");
                  }
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(14)))),
                  side: MaterialStateProperty.all(
                      const BorderSide(color: Colors.black)),
                  fixedSize: MaterialStateProperty.all(Size(250.w, 30.h)),
                  backgroundColor:
                  MaterialStateProperty.all(Colors.lightBlueAccent),
                ),
                child: const Text(
                  "Sign up",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 22,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      // Navigate to login screen
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      successToast("Account created");
      Navigator.pop(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ));
      User? user = userCredential.user;
      print(user);
    } catch (e) {
      // Display error message to user
      toast(e.toString());
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(" Alert"),
            content: Text(e.toString()),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }
}


