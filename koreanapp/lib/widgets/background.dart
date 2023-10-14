import 'package:flutter_tts/flutter_tts.dart';

import 'package:flutter/material.dart';
import 'package:koreanapp/resources/colorManager.dart';
import 'package:koreanapp/screens/onboarding/onboardingScreen.dart';
import 'package:koreanapp/services/app_extension.dart';

import '../routes/routes_manager.dart';
import '../services/appcolors.dart';
import 'customBackButton.dart';

class BackgroungWid extends StatefulWidget {
  final Row? row;
  // final String customtext;
  final Widget? child;
  final Widget? children;
  final CustomBackButton? backbutton;
  final VoidCallback? onback;
  // final Color? color;
  const BackgroungWid({
    Key? key,
    // required this.customtext,
    this.child,
    this.onback,
    this.backbutton,
    this.row,
    this.children,
    // this.color,
  }) : super(key: key);
  @override
  State<BackgroungWid> createState() => _BackgroungWidState();
}

class _BackgroungWidState extends State<BackgroungWid> {
  String? customtext;

  final FlutterTts flutterTts = FlutterTts();
  speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(body: LayoutBuilder(builder: (context, constraints) {
      return Stack(children: [
        Background(),
        // Positioned(
        //   top: 15,
        //   left: 20,
        //   right: 30,
        //child:

        //onBackssss
        Column(children: [
          Padding(
            padding: EdgeInsets.only(
              top: 0.h,
            ),
            child: widget.backbutton,
          ),
          Padding(
            padding: EdgeInsets.only(left: 22.w, right: 22.w),
            child: Column(
              children: [widget.children ?? Container()],
            ),
          ),
          Row(
            children: [
              widget.row ?? Container(),
            ],
          )
        ]),
        // ),
        Stack(children: [
          Positioned(
              top: 90.h,
              left: 0,
              right: 0,
              child: Container(
                height: context.deviceHeight - 140.h,
                decoration: BoxDecoration(
                  color: ColorManager.primary,
                  // borderRadius: BorderRadius.only(
                  //     topLeft: Radius.circular(40.r),
                  //     topRight: Radius.circular(40.r))
                ),
                child: widget.child,
              )),
        ])
      ]);
    })));
  }
}

class Background extends StatefulWidget {
  const Background({super.key});

  @override
  State<Background> createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: context.deviceHeight,
          width: context.deviceWidth,
          color: ColorManager.appbarColor,
          child: Stack(children: [
            CustomPaint(
              painter:
                  VennDiagramPainter(), // CustomPainter to draw Venn diagram-like shapes
              child: Container(),
            ), // Text('dfghjkl') add search bar here
          ]),
        ),
      ),
    );
  }

  Widget _circle() {
    return Container(
      height: 500.h,
      width: 500.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(255, 255, 255, 0.123),
      ),
    );
  }
}

class ProfileBackgroungWid extends StatefulWidget {
  // final String customtext;
  final Widget child;
  const ProfileBackgroungWid({
    Key? key,
    // required this.customtext,
    required this.child,
  }) : super(key: key);
  @override
  State<ProfileBackgroungWid> createState() => _ProfileBackgroungWidState();
}

class _ProfileBackgroungWidState extends State<ProfileBackgroungWid> {
  String? customtext;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Stack(children: [
      Background(),
      // Positioned(
      //   top: 15,
      //   left: 20,
      //   right: 30,
      //child:
      Column(children: [
        Padding(
          padding: EdgeInsets.only(
            top: 13.h,
            left: 22.h,
          ),
          child: CustomBackButton(onBack: () {
            Navigator.pushNamed(context, Routes.signUp);
          }),
        ),
        // Row(
        //   children: [
        //     Text("dfghjkm cfgh"),
        //   ],
        // )
        // CustomBackButton(onBack: () {
        //   locator<NavigationRoutes>().navigateTo(Routes.dashboard);
        // }),
      ]),
      // ),
      Stack(children: [
        // Positioned(
        //     top: 100.h,
        //     left: 0,
        //     right: 0,
        //     child: Container(
        //       height: context.deviceHeight,
        //       decoration: BoxDecoration(
        //         color: AppColors.white,
        //         // borderRadius: BorderRadius.only(
        //         //     topLeft: Radius.circular(40.r),
        //         //     topRight: Radius.circular(40.r))
        //       ),
        //       child: widget.child,
        //     )),
      ])
    ])));
  }
}
