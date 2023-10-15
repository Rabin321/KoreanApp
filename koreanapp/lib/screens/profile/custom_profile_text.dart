// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:koreanapp/screens/profile/switch_provider.dart';
import 'package:koreanapp/services/app_extension.dart';

import '../../services/appcolors.dart';

class CustomProfileText extends StatelessWidget {
  String customtext;
  // AppImagePath image;

  VoidCallback onTap;
  IconData? customicon;
  CustomProfileText({
    Key? key,
    required this.customtext,
    required this.onTap,
    this.customicon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 10.h),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => onTap(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  // "Profile",
                  customtext,
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 15.h,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  width: 10.w,
                ),

                Icon(
                  customicon,
                  color: AppColors.primary,
                )
                // SvgPicture.asset(AppImagePath.profile)
                // SvgPicture.asset(image as String)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomProfileSignoutText extends StatelessWidget {
  String customtext;
  // AppImagePath image;

  VoidCallback onTap;
  IconData customicon;
  CustomProfileSignoutText({
    Key? key,
    required this.customtext,
    required this.onTap,
    required this.customicon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 10.h),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => onTap(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  // "Profile",
                  customtext,
                  style: TextStyle(
                      color: Color.fromARGB(255, 230, 3, 3),
                      fontSize: 15.h,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Icon(
                  customicon,
                  color: Color.fromARGB(255, 230, 3, 3),
                )
                // SvgPicture.asset(AppImagePath.profile)
                // SvgPicture.asset(image as String)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// custom switch

class CustomSwitchRow1 extends StatelessWidget {
  final String text;
  final bool value;
  final ValueChanged<bool> onChanged;
  // final SwitchProvider switchProvider;

  const CustomSwitchRow1({
    super.key,
    required this.text,
    required this.value,
    required this.onChanged,
    // required this.switchProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
                color: AppColors.black,
                fontSize: 15.h,
                fontWeight: FontWeight.w400),
          ),
          Switch(
            activeColor: AppColors.primary,
            focusColor: AppColors.lightText,
            value: false,
            // value: switchProvider.switchValue1,
            onChanged: (newValue) {
              // switchProvider.setSwitchValue1(newValue);
              onChanged(newValue);
            },
          ),
        ],
      ),
    );
  }
}

//2nd
class CustomSwitchRow2 extends StatelessWidget {
  final String text;
  final bool value;
  final ValueChanged<bool> onChanged;
  // final SwitchProvider switchProvider;

  const CustomSwitchRow2({
    super.key,
    required this.text,
    required this.value,
    required this.onChanged,
    // required this.switchProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
                color: AppColors.black,
                fontSize: 15.h,
                fontWeight: FontWeight.w400),
          ),
          Switch(
            activeColor: AppColors.primary,
            focusColor: AppColors.lightText,
            value: false,
            // value: switchProvider.switchValue2,
            onChanged: (newValue) {
              // switchProvider.setSwitchValue2(newValue);
              onChanged(newValue);
            },
          ),
        ],
      ),
    );
  }
}
