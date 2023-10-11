import 'package:advanced_rich_text/advanced_rich_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:koreanapp/screens/auth/congrats.dart';
import 'package:koreanapp/services/app_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../../routes/routes_manager.dart';
import '../../../services/app_images.dart';
import '../../../services/appcolors.dart';
import '../../../services/appcolors.dart';
import '../../../widgets/customTextbox.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/pwd_text_field.dart';
import '../../../widgets/validators.dart';
import '../signin/signin.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  var uuid = Uuid();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController pwd = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController name = TextEditingController();
  String id = '';
  String imageUrls = "";
  String drpdwn = "English (US)";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        // appBar: customAppbar(
        //   context,
        //   language: true,
        //   value: drpdwn,
        //   onChanged: (v) {
        //     setState(() {
        //       drpdwn = v.toString();
        //     });
        //   },
        // ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 25.h).copyWith(top: 60.h),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SvgPicture.asset(
                  AppImagePath.signUP,
                  height: context.deviceHeight * 0.20,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: Text(
                    "Welcome Onboard!",
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30.h),
                  child: Text(
                    "Lets help you meet up your tasks",
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                CustomTextField(
                    //key: formKey,
                    keyboardType: TextInputType.emailAddress,
                    validator: FormValidators.email,
                    controller: username,
                    hintText: "Enter your email",
                    label: "Email"),
                CustomTextField(
                    //key: formKey,
                    //keyboardType: TextInputType.emailAddress,
                    validator: FormValidators.phonenumber,
                    controller: phone,
                    hintText: "Enter your phone",
                    label: "Phone"),
                CustomTextField(
                    //key: formKey,
                    keyboardType: TextInputType.text,
                    validator: FormValidators.username,
                    controller: name,
                    hintText: "Enter your name",
                    label: "Name"),
                PWDTextField(
                    //key: formKey,
                    validator: FormValidators.password,
                    controller: pwd,
                    hintText: "Enter your password",
                    label: "Password"),
                CustomButton(
                    onPressed: () async {
                      if (username.text.isEmpty ||
                          phone.text.isEmpty ||
                          name.text.isEmpty ||
                          pwd.text.isEmpty) {
                        _showSnackbar('Please fill in all fields');
                        return;
                      }

                      FirebaseMessaging messaging = FirebaseMessaging.instance;
                      String? fcmToken = await messaging.getToken();
                      print('FCM Token: $fcmToken');
                      UserCredential userCred = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: username.text, password: pwd.text);
                      // Save username name
                      await FirebaseAuth.instance.currentUser!
                          .updateDisplayName(name.text);
                      // After that access "users" Firestore in firestore and save username, email and userLocation
                      // # 3
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(userCred.user!.uid)
                          .set(
                        {
                          "name": name.text,
                          "email": username.text,
                          "phone": phone.text,
                          "uid": userCred.user!.uid,
                          "notificationToken": fcmToken,
                          "imageUrls": "",
                        },
                      );

                      if (formKey.currentState!.validate()) {
                        try {
                          print("Validation successful");
                          // UserCredential credential = await FirebaseAuth
                          //     .instance
                          //     .createUserWithEmailAndPassword(
                          //   email: username.text,
                          //   password: pwd.text,
                          // );

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => Congrats(
                          //       username: username.text,
                          //       password: pwd.text,
                          //     ),
                          //   ),
                          // );
                          await Future.delayed(const Duration(seconds: 2));
                          print("after delay");
                          Navigator.pushNamed(context, Routes.congrats);

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => Congrats()));
                        } catch (e) {
                          print("Error creating user: $e");
                        }
                      } else {
                        print("Validation failed");
                      }
                      var phn = phone.text.toString();
                      print(phn);
                      var prefs = await SharedPreferences.getInstance();
                    },
                    buttonText: "Sign Up"),
                AdvanceRichText(
                    initialTextStyle: context.text.titleMedium,
                    textList: [
                      TextSpanList(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignIn()));
                          },
                          text: "Sign In",
                          textStyle: context.text.titleMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.buttonColor2))
                    ],
                    initialText: "Already have an account? "),
                SizedBox(
                  height: MediaQuery.of(context).viewInsets.bottom + 30,
                )
              ],
            ),
          ),
        ));
  }
}
