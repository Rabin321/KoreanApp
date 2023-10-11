// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:koreanapp/services/app_extension.dart';

import '../services/appcolors.dart';

class CustomButton extends StatelessWidget {
  // final FormValidators formValidators;
  final VoidCallback onPressed;
  final String buttonText;
  final Color buttonColor;
  final Color textColor;

  final double? width;
  final double? height;
  final double? borderRadius;
  final double? fontSize;
  final FontWeight? fontWeight;

  const CustomButton({
    Key? key,
    // required this.formValidators,
    required this.onPressed,
    required this.buttonText,
    this.buttonColor = AppColors.buttonColor2,
    this.textColor = AppColors.white,
    this.width,
    this.height,
    this.borderRadius,
    this.fontSize,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: context.text.headlineSmall!.copyWith(
            fontSize: fontSize ?? 15.sp,
            color: textColor,
            fontWeight: fontWeight ?? FontWeight.w700,
            letterSpacing: 0.5,
          ),
          textAlign: TextAlign.center,
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(buttonColor),
          foregroundColor: MaterialStateProperty.all(textColor),
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              // side: BorderSide(color: AppColors.primary, width: 2),
              borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
            ),
          ),
          maximumSize:
              MaterialStateProperty.all(Size(double.infinity, height ?? 40.h)),
          minimumSize:
              MaterialStateProperty.all(Size(width ?? 250.w, height ?? 40.h)),
        ),
      ),
    );
  }
}
