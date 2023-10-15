import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:koreanapp/resources/colorManager.dart';
import 'package:koreanapp/services/app_extension.dart';
import 'package:koreanapp/widgets/bottomNavBar.dart';
import 'package:shimmer/shimmer.dart';

import '../../../widgets/background.dart';
import '../../../widgets/customBackButton.dart';
import '../../../widgets/searchbar.dart';
import 'add_discussion.dart';

// class Discussion extends StatefulWidget {
//   const Discussion({super.key});

//   @override
//   State<Discussion> createState() => _DiscussionState();
// }

// class _DiscussionState extends State<Discussion> {
//   String? title;
//   String _searchQuery = '';

//   String? name;

//   bool isLoading = true; // Flag to control shimmer display
//   late List<String> discussionIds;

//   @override
//   void initState() {
//     super.initState();
//     // _startShakeDetection(context);
//     Future.delayed(Duration(milliseconds: 500), () {
//       setState(() {
//         isLoading = false; // After 3 seconds, stop displaying shimmer
//       });
//     });
//   }

//   // void _startShakeDetection(BuildContext context) {
//   //   shake(context);
//   // }

//   // void getDiscussName() async{
//   //   var prefs = await SharedPreferences.getInstance();
//   //   var getName = prefs.get('name');
//   //   print("Discuss name  is ${getName}");
//   //   setState(() {
//   //     name = getName as String?;
//   //   });
//   // }

//   final String defaultImageAssetPath = "assets/images/profile.jpg";
//   Widget _buildShimmerLoading() {
//     return ListView.builder(
//       physics: const ClampingScrollPhysics(),
//       padding: EdgeInsets.all(20.h),
//       itemCount: 5, // Adjust the number of shimmer placeholders as needed
//       itemBuilder: (context, index) {
//         return Shimmer.fromColors(
//           baseColor: Colors.grey[300]!,
//           highlightColor: Colors.grey[100]!,
//           child: Container(
//             margin: EdgeInsets.symmetric(vertical: 8.h),
//             padding: EdgeInsets.all(20.h),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(18.r),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   height: 14.h,
//                   width: double.infinity,
//                   color: Colors.white,
//                 ),
//                 SizedBox(height: 8.h),
//                 Container(
//                   height: 14.h,
//                   width: double.infinity,
//                   color: Colors.white,
//                 ),
//                 SizedBox(height: 8.h),
//                 Container(
//                   height: 14.h,
//                   width: double.infinity,
//                   color: Colors.white,
//                 ),
//                 SizedBox(height: 8.h),
//                 Container(
//                   height: 14.h,
//                   width: double.infinity,
//                   color: Colors.white,
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

// void showDial(String reply, String discussionTiltle) {
//   showDialog(
//     context: context,
//     builder: (context) {
//       return Center(
//         child: SimpleDialog(
//           backgroundColor: ColorManager.white,
//           title: Center(
//               child: Text(
//             discussionTiltle,
//             style: context.text.headlineSmall!.copyWith(
//                 fontWeight: FontWeight.w500, color: ColorManager.black),
//             // style: TextStyle(color: AppColors.black),
//           )),
//           children: [
//             Padding(
//               padding: EdgeInsets.all(18.h),
//               child: Container(
//                 padding: EdgeInsets.all(8.h),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey, width: 1.w),
//                   borderRadius: BorderRadius.circular(4.r),
//                 ),
//                 child: Column(
//                   children: [
//                     Text(
//                       reply,
//                       style: TextStyle(fontSize: 16.sp, color: Colors.black),
//                     ),
//                     SizedBox(height: 10.h),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       );
//     },
//   );
// }

//   Stream<List<String>> getDiscussionIds() {
//     return FirebaseFirestore.instance
//         .collection("discussion")
//         .snapshots()
//         .map((querySnapshot) {
//       return querySnapshot.docs.map((doc) => doc.id).toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         floatingActionButton: FloatingActionButton(
//             backgroundColor: ColorManager.primary,
//             onPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) {
//                 return const AddDiscussion();
//               }));
//             },
//             child: Icon(Icons.add_comment_rounded)),
//         body: BackgroungWid(
//             row: Row(
//               children: [
//                 SearchField(
//                   onSearch: (query) {
//                     setState(() {
//                       _searchQuery = query;
//                     });
//                   },
//                 ),
//               ],
//             ),
//             children: Padding(
//               padding: EdgeInsets.only(bottom: 5.h),
//               child: Column(
//                 children: [
//                   CustomBackButton(
//                     onBack: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) {
//                         return const HomeBottomNavBar();
//                       }));
//                     },
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         "Discussion",
//                         style: context.text.headlineMedium!.copyWith(
//                           fontWeight: FontWeight.bold,
//                           color: ColorManager.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             child: isLoading
//                 ? _buildShimmerLoading()
//                 : StreamBuilder<List<String>>(
//                     stream: getDiscussionIds(),
//                     builder: (context, snapshot) {
//                       if (snapshot.hasError) {
//                         return Text("Error: ${snapshot.error}");
//                       }
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return CircularProgressIndicator();
//                       }
//                       List<String> discussionIds = snapshot.data ?? [];
//                       return ListView.builder(
//                         physics: ClampingScrollPhysics(),
//                         padding: EdgeInsets.all(20.h),
//                         itemCount: discussionIds.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           String documentId = discussionIds[index];
//                           return _item(context, documentId);
//                         },
//                       );
//                     },
//                   ))
//                   );
//   }

//   Widget _item(BuildContext context, String discussid) {
//     var dataStream =
//         FirebaseFirestore.instance.collection("discussion").doc(discussid).snapshots();
//     return StreamBuilder<DocumentSnapshot>(
//       stream: dataStream,
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Text("Error:${snapshot.error}");
//         }
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         }
//         Map<String, dynamic> data =
//             snapshot.data!.data() as Map<String, dynamic>;
//         String discussionTitle = data['discussion_title'] ?? '';
//         String discussionPost = data['discussion_post'] ?? '';
//         String discussionAnswer = data['discussionAnswer'] ?? '';
//         String discussionpostedDate = data['discussionPostedDate'] ?? '';
//         String name = data['name'] ?? '';
//         String image = data['profile_image'] ?? '';

//         if (_searchQuery.isNotEmpty &&
//             !discussionTitle
//                 .toLowerCase()
//                 .contains(_searchQuery.toLowerCase())) {
//           return SizedBox.shrink();
//         }
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: EdgeInsets.only(left: 48.w),
//               child: Text(
//                 discussionTitle,
//                 maxLines: 2,
//                 style: context.text.titleLarge!.copyWith(
//                     fontWeight: FontWeight.bold, color: ColorManager.black),
//               ),
//             ),
//             SizedBox(
//               height: 4.h,
//             ),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // CircleAvatar(
//                 //   backgroundColor: AppColors.red,
//                 //   radius: 23.r,
//                 //   backgroundImage: NetworkImage(image),
//                 // ),

//                 CircleAvatar(
//                   backgroundColor: Color(0xffF8F8F8),
//                   radius: 23.r,
//                   // backgroundImage: image.isEmpty
//                   //     ? AssetImage(defaultImageAssetPath)
//                   //     : NetworkImage(image) as ImageProvider,
//                   backgroundImage: NetworkImage(image),
//                 ),
//                 SizedBox(
//                   width: 10.w,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       discussionPost,
//                       style: context.text.titleMedium!
//                           .copyWith(color: ColorManager.black),
//                       maxLines: 3,
//                       overflow: TextOverflow.ellipsis,
//                       textAlign: TextAlign.justify,
//                     ),
//                     // Text(
//                     //   name, // Display the user's name
//                     //   style: context.text.titleLarge!.copyWith(
//                     //       fontWeight: FontWeight.normal,
//                     //       color: AppColors.dTitle),
//                     // ),
//                     // Text(
//                     //   discussionpostedDate,
//                     //   style: context.text.titleLarge!.copyWith(
//                     //       fontWeight: FontWeight.normal,
//                     //       color: AppColors.dLight),
//                     // ),
//                   ],
//                 )
//               ],
//             ),

//             Padding(
//               padding: EdgeInsets.only(bottom: 5.h),
//               child: Text(
//                 name, // Display the user's name
//                 style: context.text.titleLarge!.copyWith(
//                     fontWeight: FontWeight.normal, color: ColorManager.black),
//               ),
//             ),
//             Text(
//               discussionpostedDate,
//               style: context.text.titleSmall!.copyWith(
//                   fontWeight: FontWeight.normal, color: ColorManager.black),
//             ),
//             // Text(
//             //   discussionPost,
//             //   style:
//             //       context.text.titleMedium!.copyWith(color: AppColors.dTitle),
//             //   maxLines: 2,
//             //   overflow: TextOverflow.ellipsis,
//             //   textAlign: TextAlign.justify,
//             // ),
//             Divider(),
//             GestureDetector(
//               onTap: () {
//                 showDial(discussionAnswer, discussionTitle);
//               },
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.comment_bank_outlined,
//                     color: ColorManager.primary,
//                   ),
//                   SizedBox(
//                     width: 10.w,
//                   ),
//                   Text(
//                     "Replies",
//                     style: context.text.titleMedium!
//                         .copyWith(color: ColorManager.black),
//                   ),
//                 ],
//               ),
//             ),
//             Divider(
//               thickness: 0.5,
//               color: ColorManager.black,
//             ),
//             SizedBox(
//               height: 10.h,
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// new

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:koreanapp/resources/colorManager.dart';
// import 'package:koreanapp/widgets/background.dart';
// import 'package:koreanapp/widgets/customBackButton.dart';
// import 'package:koreanapp/widgets/searchbar.dart';
// import 'package:shimmer/shimmer.dart';

class Discussion extends StatefulWidget {
  const Discussion({Key? key}) : super(key: key);

  @override
  _DiscussionState createState() => _DiscussionState();
}

class _DiscussionState extends State<Discussion> {
  String _searchQuery = '';

  bool isLoading = true;
  late List<String> discussionIds;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  Widget _buildShimmerLoading() {
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.all(20),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 14,
                  width: double.infinity,
                  color: Colors.white,
                ),
                SizedBox(height: 8),
                Container(
                  height: 14,
                  width: double.infinity,
                  color: Colors.white,
                ),
                SizedBox(height: 8),
                Container(
                  height: 14,
                  width: double.infinity,
                  color: Colors.white,
                ),
                SizedBox(height: 8),
                Container(
                  height: 14,
                  width: double.infinity,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showDial(String reply, String discussionTiltle) {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: SimpleDialog(
            backgroundColor: ColorManager.white,
            title: Center(
                child: Text(
              discussionTiltle,
              style: context.text.headlineSmall!.copyWith(
                  fontWeight: FontWeight.w500, color: ColorManager.black),
              // style: TextStyle(color: AppColors.black),
            )),
            children: [
              Padding(
                padding: EdgeInsets.all(18.h),
                child: Container(
                  padding: EdgeInsets.all(8.h),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.w),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Column(
                    children: [
                      Text(
                        reply,
                        style: TextStyle(fontSize: 16.sp, color: Colors.black),
                      ),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Stream<List<String>> getDiscussionIds() {
    return FirebaseFirestore.instance
        .collection("discussion")
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) => doc.id).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroungWid(
        row: Row(
          children: [
            SearchField(
              onSearch: (query) {
                setState(() {
                  _searchQuery = query;
                });
              },
            ),
          ],
        ),
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
                    "Discussion",
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
        // ... Other parts of the BackgroundWidget remain unchanged
        child: isLoading
            ? _buildShimmerLoading()
            : StreamBuilder<List<String>>(
                stream: getDiscussionIds(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  List<String> discussionIds = snapshot.data ?? [];
                  return ListView.builder(
                    physics: ClampingScrollPhysics(),
                    padding: EdgeInsets.all(20),
                    itemCount: discussionIds.length,
                    itemBuilder: (BuildContext context, int index) {
                      String documentId = discussionIds[index];
                      return _item(context, documentId);
                    },
                  );
                },
              ),
      ),
    );
  }

  Widget _item(BuildContext context, String discussId) {
    var dataStream = FirebaseFirestore.instance
        .collection("discussion")
        .doc(discussId)
        .snapshots();
    return StreamBuilder<DocumentSnapshot>(
      stream: dataStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;
        String discussionTitle = data['discussion_title'] ?? '';
        String discussionPost = data['discussion_post'] ?? '';
        String discussionAnswer = data['discussionAnswer'] ?? '';
        String discussionpostedDate = data['discussionPostedDate'] ?? '';
        String name = data['name'] ?? '';
        String image = data['profile_image'] ?? '';

        if (_searchQuery.isNotEmpty &&
            !discussionTitle
                .toLowerCase()
                .contains(_searchQuery.toLowerCase())) {
          return SizedBox.shrink();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 48),
              child: Text(
                discussionTitle,
                maxLines: 2,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorManager.black,
                ),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: image,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  imageBuilder: (context, imageProvider) {
                    return CircleAvatar(
                      backgroundColor: Color(0xffF8F8F8),
                      radius: 23,
                      backgroundImage: imageProvider,
                    );
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      discussionPost,
                      style: TextStyle(color: ColorManager.black),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: ColorManager.black,
                ),
              ),
            ),
            Text(
              discussionpostedDate,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: ColorManager.black,
              ),
            ),
            Divider(),
            GestureDetector(
              onTap: () {
                showDial(discussionAnswer, discussionTitle);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.comment_bank_outlined,
                    color: ColorManager.primary,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Replies",
                    style: TextStyle(
                      color: ColorManager.black,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 0.5,
              color: ColorManager.black,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        );
      },
    );
  }
}
