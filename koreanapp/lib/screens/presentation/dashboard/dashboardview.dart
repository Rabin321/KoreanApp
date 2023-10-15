// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:koreanapp/screens/presentation/dashboard/dictionary/dictionary.dart';
import 'package:koreanapp/screens/presentation/dashboard/grammar/grammarview.dart';
import 'package:koreanapp/screens/presentation/discussion/discussion.dart';
import 'package:koreanapp/screens/profile/user_profile.dart';

import 'package:koreanapp/services/app_extension.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../../../resources/colorManager.dart';
import '../../../routes/routes_manager.dart';
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

  // final FlutterTts flutterTts = FlutterTts();
  // speak(String text) async {
  //   await flutterTts.setLanguage("en-US");
  //   await flutterTts.setPitch(1);
  //   await flutterTts.speak(text);
  // }

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
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const Profile();
                    }));
                  },
                  child: CircleAvatar(
                    radius: 20.h,
                    backgroundColor: AppColors.primary,
                    child: CircleAvatar(
                      radius: 23.h,
                      backgroundImage: NetworkImage(FirebaseAuth
                              .instance.currentUser!.photoURL ??
                          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"),
                    ),
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
        ],
      ),

      child: ListView(padding: EdgeInsets.all(15.h), children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            PerformanceInfoCard(),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 15.w, bottom: 20.h),
          child: Row(
            children: [
              Text(
                "Our Services",
                style: TextStyle(
                    color: ColorManager.dashboardTitleColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 20.sp),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            HorizontalItem(
              onTap: () {
                // speak('News');
              },
              label1: "UBT Test",
              image1: AppImagePath.signUP,
            ),
            HorizontalItem(
              onTap: () {
                // speak('FAQS');
                print("grammar tapped");
                // Navigator.pushNamed(context, Routes.grammarView);

                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const GrammarView();
                }));
              },
              label1: "Grammar",
              image1: AppImagePath.signIn,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            HorizontalItem(
              onTap: () {
                // speak('Discussion');
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const DictionaryView();
                }));
              },
              label1: "Dictionary",
              image1: AppImagePath.signIn,
            ),
            HorizontalItem(
              onTap: () {
                // speak('Vocational');
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const Discussion();
                }));
              },
              label1: "Discussion",
              image1: AppImagePath.signUP,
            ),
          ],
        ),
      ]),
    );
  }
}

class PerformanceInfoCard extends StatelessWidget {
  const PerformanceInfoCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.h),
      child: Container(
        width: 300.w,
        height: 190.h,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(10.0.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius: 2, // Spread radius
              blurRadius: 5, // Blur radius
              offset: const Offset(0, 3), // Offset
            ),
          ], // Replace with your desired background color
          // Adjust the value to control the roundness
        ),
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // Align children to the left
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Your Performance",
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                        color: ColorManager.dashboardTitleColor),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SvgPicture.asset(
                        AppImagePath.signIn,
                        height: 40.h,
                        width: 40.w,
                        // color: AppColors.red,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.h, bottom: 15.h),
                        child: Text(
                          "7",
                          style: TextStyle(
                              color: ColorManager.dashboardTitleColor,
                              fontSize: 15.sp),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: Text(
                          "Reward Points",
                          style: TextStyle(
                              color: ColorManager.dashboardTitleColor,
                              fontSize: 12.sp),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: SvgPicture.asset(
                          AppImagePath.circle,
                          height: 70.h,
                          width: 70.w,
                          // color: AppColors.red,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 15.h,
                        ),
                        child: Text(
                          "Last Test Score",
                          style: TextStyle(
                              color: ColorManager.dashboardTitleColor,
                              fontSize: 12.sp),
                        ),
                      ),
                    ],
                  ),

                  //
                  Column(
                    children: [
                      SvgPicture.asset(
                        AppImagePath.signIn,
                        height: 40.h,
                        width: 40.w,
                        // color: AppColors.red,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.h, bottom: 15.h),
                        child: Text(
                          "5/100",
                          style: TextStyle(
                              color: ColorManager.dashboardTitleColor,
                              fontSize: 15.sp),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: Text(
                          "Average Score",
                          style: TextStyle(
                              color: ColorManager.dashboardTitleColor,
                              fontSize: 12.sp),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
