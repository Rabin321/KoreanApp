import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:koreanapp/screens/onboarding/onboardingScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Korean App',
        // home: BottomNavBar(),

        home: OnboardingScreen(), // suru dekhi ho yo
        // home: BeforeHomeDrawer(),
      ),
    );
  }
}
