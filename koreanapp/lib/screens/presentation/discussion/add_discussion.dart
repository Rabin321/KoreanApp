// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:koreanapp/resources/colorManager.dart';
import 'package:koreanapp/screens/presentation/discussion/discussion.dart';
import 'package:koreanapp/services/app_extension.dart';
import 'package:koreanapp/widgets/bottomNavBar.dart';

import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

import '../../../widgets/background.dart';
import '../../../widgets/customBackButton.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/textfieldWidget.dart';

class AddDiscussion extends StatefulWidget {
  // String? id;

  const AddDiscussion({
    Key? key,
    // this.id,
  }) : super(key: key);

  @override
  State<AddDiscussion> createState() => _AddDiscussionState();
}

class _AddDiscussionState extends State<AddDiscussion> {
  // late Profile getValue;
  var uuid = Uuid();
  TextEditingController discussionTitle = TextEditingController();
  TextEditingController discussionPost = TextEditingController();
  late String imageUrls = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _startShakeDetection(context);
    // getImages();
    // getUsername(context);
    // Dashboard.of(context)?.shake();
  }

  // void _startShakeDetection(BuildContext context) {
  //   shake(context);
  // }

// Function to update profile image and discussions
  void updateProfileImageAndDiscussions(String newImageURL) async {
    // Update the user's profile image in the user document
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'imageUrls': newImageURL});

    // Update the profile image in all discussions posted by the user
    QuerySnapshot discussionsSnapshot = await FirebaseFirestore.instance
        .collection("discussion")
        .where("name",
            isEqualTo: FirebaseAuth.instance.currentUser!.displayName)
        .get();

    for (var doc in discussionsSnapshot.docs) {
      doc.reference.update({"profile_image": newImageURL});
    }

    setState(() {
      imageUrls = newImageURL;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.data!.exists) {
              return const Center(child: Text("User data not found"));
            }
            final userData = snapshot.data!.data() as Map<String, dynamic>;

            String image = userData['imageUrls'];

            return BackgroungWid(
                children: Column(
                  // Use the 'children' parameter
                  children: [
                    CustomBackButton(
                      onBack: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const HomeBottomNavBar();
                        }));
                      },
                    ),
                    Row(
                      children: [
                        Text(
                          "Add Discussion",
                          style: context.text.headlineMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: ColorManager.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 0)
                      .copyWith(top: 30.h),
                  children: [
                    DiscussionTextField(
                      controller: discussionTitle,
                      hintText: "Discussion Title",
                    ),
                    DiscussionTextFieldAns(
                      controller: discussionPost,
                      hintText: "Write a post...",
                    ),
                    Row(
                      children: [
                        Expanded(child: SizedBox()),
                        Expanded(
                            child: CustomButton(
                                buttonColor: ColorManager.primary,
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const Discussion();
                                  }));
                                },
                                buttonText: "Discard")),
                        SizedBox(
                          width: 15.w,
                        ),
                        Expanded(
                            child: CustomButton(
                          onPressed: () {
                            if (discussionTitle.text.isEmpty ||
                                discussionPost.text.isEmpty) {
                              // Show snackbar indicating that fields are empty
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.grey,
                                  content: Text("Please fill all the fields."),
                                ),
                              );
                            } else {
                              var now = DateTime.now();
                              var formatter = DateFormat('yyyy-MM-dd');
                              String discussionPostedDate =
                                  formatter.format(now);
                              print(discussionPostedDate);
                              // Fields are not empty, proceed with posting
                              Map<String, dynamic> datatoSave = {
                                "discussion_title": discussionTitle.text,
                                "discussion_post": discussionPost.text,
                                "discussionAnswer": "",
                                "discussionPostedDate": discussionPostedDate,
                                "id": uuid.v4(),
                                "name": FirebaseAuth
                                        .instance.currentUser!.displayName ??
                                    "un",
                                "profile_image": image,
                              };
                              String profileName = FirebaseAuth
                                      .instance.currentUser!.displayName ??
                                  "No Profile Name";
                              print("Profile Name : $profileName");
                              String profileImageURL =
                                  imageUrls ?? "No Profile Image";
                              print("Profile Image URL: $profileImageURL");

                              FirebaseFirestore.instance
                                  .collection("discussion")
                                  .add(datatoSave)
                                  .then((DocumentReference doc) {
                                var discussid = doc.id;
                                print(discussid);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const Discussion();
                                }));
                              });
                              if (imageUrls != image) {
                                updateProfileImageAndDiscussions(image);
                              }

                              // locator<NavigationRoutes>()
                              //     .navigateTo(Routes.discussion);
                            }
                          },
                          buttonText: "Post",
                        )),
                        SizedBox(
                          width: 15.w,
                        ),
                      ],
                    )
                  ],
                ));
          },
        ),
      ),
    );
  }
}

// import 'package:flutter/foundation.dart';
// import 'package:flutter/widgets.dart';
// import 'package:pfpid/widgets/customback_button.dart';

// import '../../config/app_extensions.dart';
// import 'components/textFieldWid.dart';

// class AddDiscussion extends StatefulWidget {
//   const AddDiscussion({super.key});

//   @override
//   State<AddDiscussion> createState() => _AddDiscussionState();
// }

// class _AddDiscussionState extends State<AddDiscussion> {
//   TextEditingController discussionTitle = TextEditingController();
//   TextEditingController discussionPost = TextEditingController();

//   // ...

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: BackgroungWid(
//           child: Column(
//             children: [
//               CustomBackButton(
//                 onBack: () {
//                   locator<NavigationRoutes>().navigateTo(Routes.bottomNavBar);
//                 },
//               ),
//               Row(
//                 children: [
//                   Text(
//                     "Add Discussion",
//                     style: context.text.displayLarge!.copyWith(
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.white,
//                     ),
//                   ),
//                 ],
//               ),
//               DiscussionTextField(
//                 controller: discussionTitle,
//                 hintText: "Discussion Title",
//               ),
//               DiscussionTextFieldAns(
//                 controller: discussionPost,
//                 hintText: "Write a post...",
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
