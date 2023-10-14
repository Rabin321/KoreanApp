import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:koreanapp/routes/routes_manager.dart';
import 'package:koreanapp/screens/onboarding/onboardingScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyBmeZUSxp9cIXtohDj2vQQx2hTG5JNnil0",
      authDomain: "korean-app-a4615.firebaseapp.com",
      projectId: "korean-app-a4615",
      storageBucket: "korean-app-a4615.appspot.com",
      messagingSenderId: "1041137681162",
      appId: "1:1041137681162:android:709679076acdde9dc9f0f3",
    ));
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // const MyApp({super.key}); // default constructor
  MyApp._internal(); //private named constructor
  int appState = 0;

  static final MyApp instance =
      MyApp._internal(); // single instance -- singleton

  factory MyApp() => instance; // factory for the class instance

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    void initState() {
      super.initState();
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }

    @override
    dispose() {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      super.dispose();
    }

    return const ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: '/',
      ),
    );
  }
}
