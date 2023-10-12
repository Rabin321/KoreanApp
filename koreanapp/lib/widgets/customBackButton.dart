import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:koreanapp/services/app_extension.dart';

import '../services/appcolors.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback onBack;
  CustomBackButton({Key? key, required this.onBack}) : super(key: key);
  final FlutterTts flutterTts = FlutterTts();
  speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onBack,
      // child: Container(
      //   color: Colors.transparent,

      child: Padding(
        padding: EdgeInsets.only(top: 20.h, bottom: 0.h),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.arrow_back, size: 20.h, color: AppColors.white),
            //const SizedBox(width: ),
          ],
        ),
      ),
    );
  }
}
