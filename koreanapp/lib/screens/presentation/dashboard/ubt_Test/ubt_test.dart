import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:koreanapp/resources/colorManager.dart';
import 'package:koreanapp/services/app_extension.dart';
import 'package:koreanapp/widgets/bottomNavBar.dart';
import 'package:koreanapp/widgets/custom_button.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../services/appcolors.dart';
import '../../../../widgets/background.dart';
import '../../../../widgets/customBackButton.dart';
import 'gold/gold_package.dart';

class UbtTest extends StatefulWidget {
  const UbtTest({super.key});

  @override
  State<UbtTest> createState() => _UbtTestState();
}

class _UbtTestState extends State<UbtTest> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackgroungWid(
      children: Padding(
        padding: EdgeInsets.only(bottom: 5.h),
        child: Column(
          children: [
            CustomBackButton(
              onBack: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const HomeBottomNavBar();
                }));
              },
            ),
            Row(
              children: [
                Text(
                  "UbtTest",
                  style: context.text.headlineMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: ColorManager.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: Text(
                "Packages",
                style: TextStyle(
                    color: ColorManager.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400),
              ),
            ),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.withOpacity(0.7), // Shadow color
                              spreadRadius: 2, // Spread radius
                              blurRadius: 7, // Blur radius
                              offset: const Offset(0, 3), // Offset
                            ),
                          ],
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                ColorManager.gold1,
                                ColorManager.white
                              ])),

                      height: 100.h,
                      width: 170.w,
                      // color: ColorManager.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: Text(
                              "Gold",
                              style: TextStyle(
                                  fontSize: 22.sp, fontWeight: FontWeight.w500),
                            ),
                          ),
                          UbtButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const GoldPackage();
                                }));
                              },
                              buttonText: "Get Packages")
                          // ElevatedButton(onPressed: () {}, child: Text("Get package"))
                        ],
                      ),
                    ),
                  ),
                  // silver
                  Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.withOpacity(0.7), // Shadow color
                              spreadRadius: 2, // Spread radius
                              blurRadius: 7, // Blur radius
                              offset: const Offset(0, 3), // Offset
                            ),
                          ],
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                ColorManager.silver1,
                                ColorManager.white
                              ])),

                      height: 100.h,
                      width: 170.w,
                      // color: ColorManager.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: Text(
                              "Silver",
                              style: TextStyle(
                                  fontSize: 22.sp, fontWeight: FontWeight.w500),
                            ),
                          ),
                          UbtButton(onPressed: () {}, buttonText: "buttonText")
                          // ElevatedButton(onPressed: () {}, child: Text("Get package"))
                        ],
                      ),
                    ),
                  ),

                  // bronze
                  Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.withOpacity(0.7), // Shadow color
                              spreadRadius: 2, // Spread radius
                              blurRadius: 7, // Blur radius
                              offset: const Offset(0, 3), // Offset
                            ),
                          ],
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.brown, ColorManager.white])),

                      height: 100.h,
                      width: 170.w,
                      // color: ColorManager.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: Text(
                              "Bronze",
                              style: TextStyle(
                                  fontSize: 22.sp, fontWeight: FontWeight.w500),
                            ),
                          ),
                          UbtButton(
                              onPressed: () {}, buttonText: "Get Packages")
                          // ElevatedButton(onPressed: () {}, child: Text("Get package"))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30.h, bottom: 20.h),
              child: Text(
                "All Sets",
                style: TextStyle(
                    color: ColorManager.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.only(right: 10.w),
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return _ubtTestsBox(index);
                  }),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _ubtTestsBox(int index) {
    return InkWell(
      onTap: () {
        // Handle item tap, e.g., navigate to item details
      },
      child: Container(
        width: 400.w,
        height: 100.h,
        // decoration: BoxDecoration(
        //   color: ColorManager.primary,
        //   borderRadius: BorderRadius.all(Radius.circular(18.r)),
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.all(Radius.circular(10.0.r)),
          color: ColorManager.onboardingCircle,
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.12),
                blurRadius: 10.0,
                offset: Offset(0, 4))
          ],
        ),

        margin: EdgeInsets.only(bottom: 25.h),
        child: Padding(
          padding: EdgeInsets.all(15.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 0.h, bottom: 8.h),
                child: Image(image: AssetImage("assets/images/exam3.png")),
              ),
              Center(
                child: Text(
                  "UBT Test 1",
                  style: TextStyle(
                      color: ColorManager.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Claim now"),
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.buttonColor2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          50.0), // Adjust the value to control the border radius
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
