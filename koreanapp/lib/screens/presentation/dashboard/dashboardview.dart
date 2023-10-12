// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:flutter/material.dart';
import 'package:koreanapp/services/app_extension.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../../../services/app_images.dart';
import '../../../services/appcolors.dart';
import '../../../widgets/background.dart';
import 'component/box.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    Key? key,
  }) : super(key: key);
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  StreamSubscription<QuerySnapshot>? noticeStreamSubscription;

  bool hasnewNotification = false;
  int notificationCount = 0;
  int newnotificationCount = 0;

//
  bool shouldListenToNoticeCollection = true;
  bool hasFetchedNoticeCollection =
      false; // Flag to track whether collection has been fetched

  List<DocumentSnapshot> noticeCollection = [];

  String? myEmail;
  late stt.SpeechToText _speech;
  final bool _isListening = false;
  final double _confidence = 1.0;
  final CollectionReference _referenceUser =
      FirebaseFirestore.instance.collection('users');
  late Stream<QuerySnapshot> streamUserItems;
  // Initialize the GetX controller for notifications
  // final NotificationController notificationController =
  //     Get.put(NotificationController());
  @override
  void initState() {
    super.initState();
    // Other initialization code...

    // Initialize notification count and flag
    // newnotificationCount = 0;
    // hasnewNotification = false;

    // Listen for changes in the "notice" collection
    // noticeStreamSubscription = FirebaseFirestore.instance
    //     .collection("notice")
    //     .snapshots()
    //     .listen((snapshot) {
    //   // Calculate the count of new notices
    //   int newNoticeCount = snapshot.docs.length;

    //   print("newNoticeCount $newNoticeCount");

    //   // Update the notification count using GetX
    //   notificationController.notificationCount.value = newNoticeCount;

    //   print(
    //       "newnotificationCount is is is ${notificationController.notificationCount}");
    // });
  }

  @override
  void dispose() {
    // Cancel the stream subscription when the widget is disposed
    noticeStreamSubscription?.cancel();
    super.dispose();
  }

  // void resetNotificationCount() {
  //   print("Resetting notification count"); // Add this line for debugging
  //   setState(() {
  //     notificationCount = 0;
  //     // newnotificationCount = notificationCount;
  //     hasnewNotification = false;
  //     hasFetchedNoticeCollection = false;
  //     print("newnotificationCoun $newnotificationCount");
  //   });
  //   shouldListenToNoticeCollection = false;
  // }

  Future<void> _fetch() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      setState(() {
        myEmail = userData.data()!['email'];
        // Update newnotificationCount and hasnewNotification based on userData
        newnotificationCount = userData.data()!['notificationCount'] ?? 0;
        hasnewNotification = newnotificationCount > 0;
      });
    }
  }

  final FlutterTts flutterTts = FlutterTts();
  speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    // return ColorFiltered(
    //   colorFilter: ColorFilter.mode(Colors.yellow, BlendMode.modulate),
    //   child: NewBackgroundWid(context),
    // );

    return NewBackgroundWid(context);
  }

  BackgroungWid NewBackgroundWid(BuildContext context) {
    return BackgroungWid(
      // color: AppColors.primary,
      children: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 30.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 20.h,
                  backgroundColor: AppColors.white,
                  child: CircleAvatar(
                    radius: 23.h,
                    backgroundImage: NetworkImage(FirebaseAuth
                            .instance.currentUser!.photoURL ??
                        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"),
                  ),
                ),
                Text(
                  "${FirebaseAuth.instance.currentUser!.displayName ?? 'user'}'s Dashboard",
                  style: context.text.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 24.sp,
                    color: AppColors.white,
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Reset the notification count using GetX
                        // notificationController.notificationCount.value = 0;
                        // print(
                        //     "count noti ${notificationController.notificationCount}");
                        // print("Tapped notifications icon");
                        // speak('notifications');
                        // locator<NavigationRoutes>()
                        //     .navigateTo(Routes.notification);
                      },
                      child: Badge(
                        // label: Obx(() {
                        //   // final count =
                        //   //     notificationController.notificationCount.value;
                        //   if (count > 0) {
                        //     return Text(
                        //       count.toString(),
                        //       style: TextStyle(
                        //           fontSize: 16.sp, color: AppColors.white),
                        //     );
                        //   } else {
                        //     return Text(
                        //       '', // Empty string when count is zero
                        //       style: TextStyle(color: AppColors.white),
                        //     );
                        //   }
                        // }),
                        label: Text(
                          newnotificationCount.toString(),
                          style: TextStyle(
                              fontSize: 16.sp, color: AppColors.white),
                        ),
                        child: Icon(
                          Icons.notifications,
                          color: AppColors.white,
                          size: 22.h,
                        ),
                      ),
                    ),

                    // GestureDetector(

                    SizedBox(
                      width: 10.w,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.menu,
                        color: AppColors.white,
                        size: 22.h,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Row(
            children: [],
          ),
        ],
      ),
      child: ListView(padding: EdgeInsets.all(15.h), children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            HorizontalItem(
              onTap: () {
                speak('Care');
                // baaakiii
              },
              label1: "Care",
              image1: AppImagePath.signIn,
            ),
            // SizedBox(
            //   width: 22.h,
            // ),
            HorizontalItem(
              onTap: () {
                speak('notice');
              },
              label1: "Notice",
              image1: AppImagePath.signIn,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            HorizontalItem(
              onTap: () {
                speak('News');
              },
              label1: "News",
              image1: AppImagePath.signUP,
            ),
            HorizontalItem(
              onTap: () {
                speak('FAQS');
              },
              label1: "FAQs",
              image1: AppImagePath.signIn,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            HorizontalItem(
              onTap: () {
                speak('Discussion');
              },
              label1: "Discussion",
              image1: AppImagePath.signIn,
            ),
            HorizontalItem(
              onTap: () {
                speak('Vocational');
              },
              label1: "Vocational",
              image1: AppImagePath.signUP,
            ),
          ],
        ),
      ]),
    );
  }
}
