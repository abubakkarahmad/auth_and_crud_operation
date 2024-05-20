import 'package:auth_with_provider/auth_screen/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../class_home/bottom_nav_bar.dart';
import '../provider/circular_indicator.dart';
import '../provider/login.dart';
import '../utilities/snackbar.dart';
import '../utilities/toast.dart';
import 'forgot_password.dart';


class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email_c = TextEditingController();
  TextEditingController password_c = TextEditingController();
  ValueNotifier<bool> toogle = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    final progressIndicatorProvider =
    Provider.of<CircularProgressIndicatorProvider>(context);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.white70,
                  child: SizedBox(
                    height: 500.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("LOGIN",style: TextStyle(fontSize: 30,color: Colors.black54,fontWeight: FontWeight.bold),)
                          ],
                        ),
                        SizedBox(height:  50.h),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: TextFormField(
                                controller: email_c,
                                style: const TextStyle(color: Colors.black),
                                onChanged: (value) {
                                  loginProvider.validateEmail(value);
                                },
                                decoration: InputDecoration(
                                  hintText: "abc@gmail.com",
                                  labelText: "Email",
                                  prefixIcon: const Icon(Icons.email_outlined),
                                  errorText: loginProvider.emailValidationError,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(right: 8.w, left: 8.w, top: 8.h),
                                child: ValueListenableBuilder(
                                  valueListenable: toogle,
                                  builder: (context, value, child) {
                                    return TextFormField(
                                      controller: password_c,
                                      style: const TextStyle(color: Colors.black),
                                      onChanged: (value) {
                                        loginProvider.validatePassword(value);
                                      },
                                      obscureText: toogle.value,
                                      decoration: InputDecoration(
                                        suffixIcon: InkWell(
                                            onTap: () {
                                              toogle.value = !toogle.value;
                                            },
                                            child: Icon(toogle.value
                                                ? Icons.visibility_off
                                                : Icons.visibility)),
                                        labelText: "Password",
                                        prefixIcon: Icon(Icons.lock_open),
                                        errorText: loginProvider.passwordValidationError,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                    );
                                  },
                                )),
                            Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ForgotPasswordByEmail(),
                                          ));
                                    },
                                    child: const Text(
                                      "Forgot password",
                                      style: TextStyle(color: Colors.blue),
                                    )),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 50, left: 50),
                                  child: progressIndicatorProvider.isLoggedIn
                                      ? const CircularProgressIndicator(color: Colors.black87)
                                      : ElevatedButton(
                                    onPressed: loginProvider.isLoginButtonEnabled()
                                        ? () {
                                      progressIndicatorProvider
                                          .cicularIndicator(true);
                                      _login(context);
                                    }
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(color: Colors.white70),
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      backgroundColor: Colors.lightBlueAccent,
                                    ),
                                    child: const SizedBox(
                                      width: double.infinity,
                                      height: 40,
                                      child: Center(
                                        child: Text(
                                          "Login Now",
                                          style: TextStyle(
                                              fontSize: 20, color: Colors.black54),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Don't have an account?",style: TextStyle(color: Colors.black54),),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => const SignUp()),
                                        );
                                      },
                                      child: const Text("Sign up",
                                          style: TextStyle(color: Colors.blue)),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            _button(context, "images/assets/google.png",_signWithGoogle, const BottomNavBar())
                          ],
                        ),
                      ],
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






  void _login(BuildContext context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final progressIndicatorProvider =
    Provider.of<CircularProgressIndicatorProvider>(context, listen: false);

    try {
      final userCredential = await auth.signInWithEmailAndPassword(
        email: email_c.text.toString(),
        password: password_c.text.toString(),
      );

      if (userCredential.user != null) {
        successToast("Login Successfully");
        progressIndicatorProvider.cicularIndicator(false);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavBar(),
          ),
              (Route<dynamic> route) => false,
        ).onError((error, stackTrace) {
          progressIndicatorProvider.cicularIndicator(false);
          toast(error.toString());
        });
      }
    } catch (e) {
      progressIndicatorProvider.cicularIndicator(false);
      toast(e.toString());
    }
  }
}

Future<void> _signWithGoogle() async {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth authh = FirebaseAuth.instance;

  final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

  final GoogleSignInAuthentication googleAuth =
  await googleUser!.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

  final UserCredential userCredential =
  await authh.signInWithCredential(credential);
}

Widget _button(BuildContext context,logo,
    Future<void> Function() function, Widget navigate) {
  final progressIndicatorProvider =
  Provider.of<CircularProgressIndicatorProvider>(context, listen: false);
  return InkWell(onTap: () async{
    try {
      await function();
      SnackBarHelper.showMessage(context, "Successful", Colors.blue);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => navigate),
            (Route<dynamic> route) =>
        false, // RoutePredicate to keep only the new route
      );
    } catch (e) {
      toast(e.toString());
    }
  },
      child: Image.asset(logo,width: 50.w,height: 100,));
}




