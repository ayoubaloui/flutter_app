import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_app/firebase_options.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_flutter_app/landing_screen.dart';

Future<void> main() async {
  // Firebase initilialization
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
        // ScreenUtilInit is a package for responsive layout
        ScreenUtilInit(
            // Define the height and width of the screen you are working on
            designSize: const Size(1920, 1080),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return const MaterialApp(
                  debugShowCheckedModeBanner: false,
                  // First screen to display when running the app
                  home: OnBoardingScreen());
            });
  }
}
