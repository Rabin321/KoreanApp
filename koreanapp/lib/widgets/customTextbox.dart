import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:koreanapp/services/app_extension.dart';
import 'package:koreanapp/widgets/validators.dart';

import '../services/appcolors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool enabled;
  final bool isObscured;
  final TextInputType? keyboardType;
  final String? Function(String? value)? validator;
  final String label;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.enabled = true,
    this.isObscured = false,
    this.keyboardType = TextInputType.text,
    this.validator = FormValidators.requiredText,
    required this.label,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h, bottom: 3.h),
      child: SizedBox(
        height: 45.h,
        child: TextFormField(
          enabled: widget.enabled,
          scrollPadding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).viewInsets.bottom + 20),
          controller: widget.controller,
          key: formKey,
          keyboardType: widget.keyboardType,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: widget.validator,
          inputFormatters: widget.keyboardType == TextInputType.number
              ? [FilteringTextInputFormatter.digitsOnly]
              : [],
          decoration: InputDecoration(
            label: Text(
              widget.label,
              style: context.text.titleLarge!.copyWith(
                  color: AppColors.buttonColor2, fontWeight: FontWeight.w500),
            ),
            errorStyle: TextStyle(height: 0.1.h, fontSize: 10.h),
            errorMaxLines: 2,
            fillColor: AppColors.white,
            filled: true,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                  width: 1.h, color: Color.fromARGB(255, 44, 37, 37)),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(width: 1.w, color: AppColors.lightText),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                  width: widget.controller.value.text.isEmpty ? 1 : 2,
                  color: AppColors.buttonColor2),
            ),
            // disabledBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(8.r),
            //   borderSide: BorderSide(
            //       width: widget.controller.value.text.isEmpty ? 1 : 2,
            //       color: widget.controller.value.text.isEmpty
            //           ? AppColors.lightText
            //           : AppColors.lightText),
            // ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(width: 1.w, color: AppColors.buttonColor2),
            ),
            hintText: widget.hintText,
            hintStyle: widget.hintText.length > 20
                ? context.text.titleMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 9.sp,
                    color: AppColors.lightText,
                  )
                : context.text.titleMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColors.lightText,
                  ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 24.w, vertical: 13.h),
          ),
          style: context.text.titleLarge!.copyWith(
              fontWeight: FontWeight.w400,
              color: AppColors.black,
              letterSpacing: 1),
          obscureText: widget.isObscured,
        ),
      ),
    );
  }
}
