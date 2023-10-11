import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:koreanapp/services/app_extension.dart';

import '../../routes/routes_manager.dart';
import '../../services/app_images.dart';
import '../../widgets/custom_button.dart';

class Congrats extends StatefulWidget {
  String? username, password;
  Congrats({super.key, this.username, this.password});

  @override
  State<Congrats> createState() => _CongratsState();
}

class _CongratsState extends State<Congrats> {
  String drpdwn = "English (US)";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: EdgeInsets.only(bottom: 20.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                SvgPicture.asset(
                  AppImagePath.congrats,
                  height: context.deviceHeight * 0.25,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Center(
                  child: Text(
                    "Congrats!\nYour account has been created.",
                    style: context.text.titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                // Padding(
                //   padding:
                //       EdgeInsets.symmetric(horizontal: 40.h, vertical: 10.h),
                //   child: Text(
                //     "We have sent you an email with verification link. Verify your account to login",
                //     style: context.text.titleLarge,
                //     textAlign: TextAlign.center,
                //   ),
                // ),
                Spacer(),
                CustomButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.signIn);
                    },
                    buttonText: "Sign In"),
              ],
            ),
          )),
    );
  }
}
