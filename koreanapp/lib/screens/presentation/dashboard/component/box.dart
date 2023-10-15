import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:koreanapp/resources/colorManager.dart';
import 'package:koreanapp/services/app_extension.dart';

import '../../../../services/appcolors.dart';

class HorizontalItem extends StatefulWidget {
  final String label1, image1;
  final Function()? onTap;

  const HorizontalItem({
    super.key,
    required this.onTap,
    required this.label1,
    // required this.label2,
    required this.image1,
    // required this.image2
    //
  });

  @override
  State<HorizontalItem> createState() => _HorizontalItemState();
}

class _HorizontalItemState extends State<HorizontalItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      // child: Container(
      //   //children: [
      //   child:

      child: BoxWid(
        image: widget.image1,
        label: widget.label1,
        // ontap: onTap,
      ),
      // SizedBox(
      //   width: 20,
      // ),
      // BoxWid(
      //   image: widget.image2,
      //   label: widget.label2,
      //   // ontap: onTap,
      // ),
      //],
      //),
    );
  }
}

class BoxWid extends StatefulWidget {
  final String image;
  final String label;

  const BoxWid({
    super.key,
    required this.image,
    required this.label,
  });

  @override
  State<BoxWid> createState() => _BoxWidState();
}

class _BoxWidState extends State<BoxWid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125.h,
      padding: EdgeInsets.only(bottom: 15.h),
      margin: EdgeInsets.only(left: 4.h, bottom: 20.h),
      width: 125.h,
      decoration: BoxDecoration(
          color: ColorManager.primary,
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.12),
                blurRadius: 40.0,
                offset: Offset(0, 4))
          ],
          borderRadius: BorderRadius.all(Radius.circular(20.r))),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset(
              widget.image,
              height: 60.h,
              width: 60.h,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              widget.label,
              style: context.text.headlineMedium!.copyWith(
                  fontSize: 16.sp,
                  color: ColorManager.dashboardTitleColor,
                  fontWeight: FontWeight.w400),
            ),
          ]),
    );
  }
}
