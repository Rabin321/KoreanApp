import 'package:flutter/material.dart';
import 'package:koreanapp/resources/colorManager.dart';
import 'package:koreanapp/services/app_extension.dart';
import 'package:koreanapp/widgets/bottomNavBar.dart';
import 'package:koreanapp/widgets/custom_button.dart';

import '../../../../../services/appcolors.dart';
import '../../../../../widgets/background.dart';
import '../../../../../widgets/customBackButton.dart';

class Practice extends StatefulWidget {
  const Practice({super.key});

  @override
  State<Practice> createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {
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
                  "Practice",
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
      child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return _practiceBox(index);
          }),
    ));
  }

  Widget _practiceBox(int index) {
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
                  "Listening",
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
