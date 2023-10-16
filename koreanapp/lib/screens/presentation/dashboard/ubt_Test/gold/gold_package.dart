import 'package:flutter/material.dart';
import 'package:koreanapp/resources/colorManager.dart';
import 'package:koreanapp/services/app_extension.dart';
import 'package:koreanapp/widgets/bottomNavBar.dart';
import 'package:koreanapp/widgets/custom_button.dart';

import '../../../../../services/appcolors.dart';
import '../../../../../widgets/background.dart';
import '../../../../../widgets/customBackButton.dart';

class GoldPackage extends StatefulWidget {
  const GoldPackage({super.key});

  @override
  State<GoldPackage> createState() => _GoldPackageState();
}

class _GoldPackageState extends State<GoldPackage> {
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
                  "Gold",
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
            return _GoldBox(index);
          }),
    ));
  }

  Widget _GoldBox(int index) {
    return InkWell(
      onTap: () {
        // Handle item tap, e.g., navigate to item details
      },
      child: Container(
        width: 400.w,
        height: 50.h,
        // decoration: BoxDecoration(
        //   color: ColorManager.primary,
        //   borderRadius: BorderRadius.all(Radius.circular(18.r)),
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.all(Radius.circular(10.0.r)),
          color: ColorManager.onboardingCircle,
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.2),
                blurRadius: 20.0,
                offset: Offset(0, 8))
          ],
        ),

        margin: EdgeInsets.only(bottom: 25.h),
        child: Padding(
          padding: EdgeInsets.all(10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: AssetImage(
                  "assets/images/exam3.png",
                ),
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
              Container(
                height: 25.h,
                child: Center(
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
