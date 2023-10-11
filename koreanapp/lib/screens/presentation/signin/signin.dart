import 'package:advanced_rich_text/advanced_rich_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:koreanapp/screens/presentation/signin/signin_model.dart';
import 'package:koreanapp/screens/presentation/signup/signup.dart';
import 'package:koreanapp/services/app_extension.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';

import '../../../routes/routes_manager.dart';
import '../../../services/app_images.dart';
import '../../../services/appcolors.dart';
import '../../../widgets/customTextbox.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/pwd_text_field.dart';
import '../../../widgets/validators.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  final FlutterTts flutterTts = FlutterTts();
  speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  Stream<List<Login>> getLoginUsers() {
    return FirebaseFirestore.instance
        .collection("users")
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        return Login(
          uid: doc.id,
          email: data['email'],
          name: data['name'],
          phone: data['phone'],
        );
      }).toList();
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController username = TextEditingController();
  TextEditingController pwd = TextEditingController();
  String drpdwn = "English (US)";

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          // appBar: customAppbar(
          //   context,
          //   leading: false,
          //   language: true,
          //   value: drpdwn,
          //   onChanged: (v) {
          //     setState(() {
          //       drpdwn = v.toString();
          //     });
          //   },
          // ),
          body: SingleChildScrollView(
            padding:
                EdgeInsets.symmetric(horizontal: 25.h).copyWith(top: 100.h),
            child: Column(
              children: [
                SvgPicture.asset(
                  AppImagePath.signIn,
                  height: context.deviceHeight * 0.25,
                ),
                SizedBox(
                  height: 15.h,
                ),
                CustomTextField(
                    keyboardType: TextInputType.emailAddress,
                    validator: FormValidators.email,
                    controller: username,
                    hintText: "Enter your email",
                    label: "Email"),
                PWDTextField(
                    validator: FormValidators.password,
                    controller: pwd,
                    hintText: "Enter your password",
                    label: "Password"),
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: Text(
                //     "Forgot password?",
                //     style: context.text.headlineSmall!.copyWith(
                //         color: AppColors.primary, fontWeight: FontWeight.w700),
                //   ),
                // ),

                SizedBox(
                  height: 20.h,
                ),
                CustomButton(
                  onPressed: () async {
                    if (username.text.isEmpty || pwd.text.isEmpty) {
                      _showSnackbar('Please fill in all fields');
                      return;
                    }
                    try {
                      final userCredential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                        email: username.text,
                        password: pwd.text,
                      );
                      final loggedInUser = userCredential.user;

                      if (loggedInUser != null) {
                        final userDoc = await FirebaseFirestore.instance
                            .collection("users")
                            .doc(loggedInUser.uid)
                            .get();
                        if (userDoc.exists) {
                          final data = userDoc.data();
                          final userName = data!['name'];
                          final token = data['uid'];
                          final phone = data['phone'];
                          debugPrint("Token is $token");
                          debugPrint("Logged-in user's name: $userName");

                          // Save user's name to SharedPreferences
                          var prefs = await SharedPreferences.getInstance();
                          prefs.setString('token', token);
                          prefs.setString('name', userName);
                          prefs.setString('phone', phone);
                          print("successfully sign in");

                          Navigator.pushNamed(context, Routes.homeBottomNavBar);

                          speak("Hello${userName}");
                        } else {
                          debugPrint("User data not found.");
                        }
                      } else {
                        debugPrint("No logged-in user found.");
                      }
                    } catch (error) {
                      _showSnackbar("Username and password do not match.");
                      debugPrint("Error: $error");
                    } finally {
                      Future.delayed(const Duration(seconds: 2), () {
                        setState(() {
                          _isLoading = false;
                        });
                      });
                    }
                  },
                  buttonText: "Sign In",
                ),
                if (_isLoading) CircularProgressIndicator(),

                //   FirebaseAuth.instance
                //       .signInWithEmailAndPassword(
                //           email: username.text, password: pwd.text)
                //       .then((value) {
                //     locator<NavigationRoutes>()
                //         .navigateReplacementAll(Routes.bottomNavBar);
                //   }).onError((error, stackTrace) {
                //     print("Error ${error.toString()}");
                //   });
                // },
                // buttonText: "Sign In"),
                // Get the FCM token and print it

                AdvanceRichText(
                    initialTextStyle: context.text.titleMedium,
                    textList: [
                      TextSpanList(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.signUp);
                          },
                          text: "Sign Up",
                          textStyle: context.text.titleMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.buttonColor2))
                    ],
                    initialText: "Don't have an account? "),
                SizedBox(
                  height: MediaQuery.of(context).viewInsets.bottom + 30,
                )
              ],
            ),
          )),
    );
  }
}
