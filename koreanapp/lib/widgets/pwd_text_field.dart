import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:koreanapp/services/app_extension.dart';
import 'package:koreanapp/widgets/validators.dart';

import '../services/app_images.dart';
import '../services/appcolors.dart';

class PWDTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String? value)? validator;
  final String? label;

  const PWDTextField({
    Key? key,
    this.label,
    this.validator = FormValidators.password,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  State<PWDTextField> createState() => _PWDTextFieldState();
}

class _PWDTextFieldState extends State<PWDTextField> {
  bool show = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h, bottom: 3.h),
      child: SizedBox(
        height: 45.h,
        child: TextFormField(
          scrollPadding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).viewInsets.bottom + 20),
          controller: widget.controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: widget.validator,
          decoration: InputDecoration(
            label: Text(
              widget.label!,
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
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  show = !show;
                });
              },
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h)
                      .copyWith(right: 20),
                  child: show == false
                      ? SvgPicture.asset(
                          AppImagePath.hide,
                          color: AppColors.buttonColor2.withOpacity(0.7),
                        )
                      : SvgPicture.asset(
                          AppImagePath.view,
                          color: AppColors.buttonColor2.withOpacity(0.7),
                        )),
            ),
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
          obscureText: show,
          obscuringCharacter: "*",
        ),
      ),
    );
  }
}
