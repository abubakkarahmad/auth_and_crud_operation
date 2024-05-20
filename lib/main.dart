import 'package:auth_with_provider/provider/circular_indicator.dart';
import 'package:auth_with_provider/provider/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'home_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => LoginProvider(),
            ),
            // Remove the second LoginProvider if it is redundant
            ChangeNotifierProvider(
              create: (context) => CircularProgressIndicatorProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => CircularIndicatorProvider(),
            ),
          ],
          child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
              useMaterial3: true,
            ),
            debugShowCheckedModeBanner: false,
            home: child,
            builder: EasyLoading.init(),
          ),
        );
      },
      child: const SplashScreen(),
    );
  }
}
