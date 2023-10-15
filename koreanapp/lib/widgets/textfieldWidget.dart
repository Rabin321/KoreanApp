import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:koreanapp/resources/colorManager.dart';
import 'package:koreanapp/services/app_extension.dart';
import 'package:koreanapp/widgets/validators.dart';

import '../services/app_images.dart';

class DiscussionTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String? value)? validator;

  const DiscussionTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.validator = FormValidators.requiredText,
  }) : super(key: key);

  @override
  State<DiscussionTextField> createState() => _DiscussionTextFieldState();
}

class _DiscussionTextFieldState extends State<DiscussionTextField> {
  int len = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(boxShadow: const [
            BoxShadow(
                offset: Offset(0, 0),
                blurRadius: 0.2,
                spreadRadius: 0,
                color: Color.fromRGBO(112, 112, 112, 0.078))
          ]),
          child: SizedBox(
            height: 50.h,
            child: Padding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              child: TextFormField(
                showCursor: true,
                cursorColor: ColorManager.primary,
                maxLength: 100,
                cursorHeight: 18.h,
                scrollPadding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).viewInsets.bottom + 20),
                controller: widget.controller,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  setState(() {
                    len = value.length;
                  });
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: widget.validator,
                decoration: InputDecoration(
                    counterText: "",
                    errorStyle: TextStyle(height: 0.1.h, fontSize: 8.h),
                    errorMaxLines: 2,
                    fillColor: ColorManager.white,
                    filled: true,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                          width: 1.w, color: Color.fromARGB(255, 44, 37, 37)),
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(10.w).copyWith(left: 20.w),
                      child: SvgPicture.asset(
                        AppImagePath.addDiscussion,
                      ),
                    ),
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    hintText: widget.hintText,
                    hintStyle: widget.hintText.length > 20
                        ? context.text.titleMedium!.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 9.sp,
                            color: ColorManager.black,
                          )
                        : context.text.titleMedium!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: ColorManager.black,
                          ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 13.h)),
                style: context.text.titleLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: ColorManager.black,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
            child: Text(
              "$len/100",
              style: context.text.titleSmall!.copyWith(
                  color: ColorManager.primary, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}

class DiscussionTextFieldAns extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String? value)? validator;

  const DiscussionTextFieldAns({
    Key? key,
    required this.controller,
    required this.hintText,
    this.validator = FormValidators.requiredText,
  }) : super(key: key);

  @override
  State<DiscussionTextFieldAns> createState() => _DiscussionTextFieldAnsState();
}

class _DiscussionTextFieldAnsState extends State<DiscussionTextFieldAns> {
  int len = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
              border: Border.all(color: ColorManager.primary),
              boxShadow: const [
                BoxShadow(
                    offset: Offset(0, 0),
                    blurRadius: 0.2,
                    spreadRadius: 0,
                    color: Color.fromRGBO(0, 0, 0, 0.08))
              ]),
          child: SizedBox(
            height: 250.h,
            child: TextFormField(
              textInputAction: TextInputAction.done,
              maxLength: 1000,
              maxLines: 1000,
              cursorHeight: 12.h,
              cursorColor: ColorManager.primary,
              scrollPadding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).viewInsets.bottom + 20),
              controller: widget.controller,
              keyboardType: TextInputType.multiline,
              onChanged: (value) {
                setState(() {
                  len = value.length;
                });
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: widget.validator,
              decoration: InputDecoration(
                  counterText: "",
                  errorStyle: TextStyle(height: 0.1.h, fontSize: 8.h),
                  errorMaxLines: 2,
                  fillColor: ColorManager.white,
                  filled: true,
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        width: 1.w, color: Color.fromARGB(255, 44, 37, 37)),
                  ),
                  prefixIcon: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0)
                            .copyWith(left: 20, top: 21),
                        child: SvgPicture.asset(
                          AppImagePath.addDiscussion,
                        ),
                      ),
                    ],
                  ),
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  hintText: widget.hintText,
                  hintStyle: widget.hintText.length > 20
                      ? context.text.titleMedium!.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 9.sp,
                          color: ColorManager.black,
                        )
                      : context.text.titleMedium!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: ColorManager.black,
                        ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 13.h)),
              style: context.text.titleLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: ColorManager.black,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
            child: Text(
              "$len/1000",
              style: context.text.titleSmall!.copyWith(
                  color: ColorManager.primary, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
