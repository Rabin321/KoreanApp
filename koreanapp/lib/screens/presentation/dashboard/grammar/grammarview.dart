// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:koreanapp/services/app_extension.dart';
// import 'package:koreanapp/services/appcolors.dart';

// import '../../../../widgets/background.dart';
// import '../../../../widgets/customBackButton.dart';

// class GrammarView extends StatefulWidget {
//   const GrammarView({super.key});

//   @override
//   State<GrammarView> createState() => _GrammarViewState();
// }

// class _GrammarViewState extends State<GrammarView> {
//   String? title;
//   String _searchQuery = '';

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // _startShakeDetection(context);

//     // Dashboard.of(context)?.shake();
//   }

//   // Stream<List<String>> getNewsIds() {
//   //   return FirebaseFirestore.instance
//   //       .collection('notice')
//   //       .snapshots()
//   //       .map((querySnapshot) {
//   //     return querySnapshot.docs.map((doc) => doc.id).toList();
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: BackgroungWid(
//           // customtext: "Notice",

//           children: Padding(
//             padding: EdgeInsets.only(bottom: 5.h),
//             child: Column(
//               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 CustomBackButton(
//                   onBack: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       "Grammar",
//                       style: context.text.headlineMedium!.copyWith(
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           child: StreamBuilder<List<String>>(
//             // stream: getNewsIds(),
//             builder: (context, snapshot) {
//               if (snapshot.hasError) {
//                 return Text("Error:${snapshot.error}");
//               }
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return CircularProgressIndicator();
//               }
//               List<String> newsIds = snapshot.data ?? [];

//               return ListView.builder(
//                 padding: EdgeInsets.all(25.h),
//                 itemCount: newsIds.length,
//                 itemBuilder: (context, index) {
//                   String newsId = newsIds[index];
//                   return _item(newsId);
//                 },
//               );
//             },
//           )),
//     );
//   }

//   Widget _item(String newsId) {
//     return StreamBuilder<DocumentSnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection('notice')
//           .doc(newsId)
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Text("Error: ${snapshot.error}");
//         }
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         }
//         var data = snapshot.data?.data() as Map<String, dynamic>;

//         String noticeImage = data['imageUrls'] ?? '';
//         String noticeTitle = data['title'] ?? '';
//         String noticeDetails = data['detail'] ?? '';
//         String discussionPostedDate = data['discussionPostedDate'] ?? '';

//         if (_searchQuery.isNotEmpty &&
//             !noticeTitle.toLowerCase().contains(_searchQuery.toLowerCase())) {
//           return SizedBox.shrink();
//         }

//         return InkWell(
//           onTap: () {
//             // Navigator.push(
//             //     context,
//             //     MaterialPageRoute(
//             //         builder: (context) => NoticeDetail(
//             //               newsImage: noticeImage,
//             //               newsDetails: noticeDetails,
//             //               newsTitle: noticeTitle,
//             //             ))

//             //             );
//           },
//           child: Container(
//             height: 110.h,
//             decoration: BoxDecoration(
//                 color: Color(0xffF8F8F8),
//                 borderRadius: BorderRadius.all(Radius.circular(18.r))),
//             // padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.w),
//             margin: EdgeInsets.only(bottom: 15.h),
//             child: Padding(
//               padding:
//                   EdgeInsets.only(left: 4.w, right: 6.w, top: 8.h, bottom: 4.h),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "grammar title",
//                           // noticeTitle,
//                           maxLines: 2,
//                           style: context.text.titleLarge!.copyWith(
//                               color: AppColors.black,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         Text(
//                           "grammar deatils is the ",
//                           // noticeDetails,
//                           style: context.text.titleMedium!
//                               .copyWith(color: AppColors.dLight),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           textAlign: TextAlign.justify,
//                         ),
//                         Text(
//                           "2023-12-12",
//                           // discussionPostedDate,
//                           style: context.text.titleMedium!
//                               .copyWith(color: AppColors.dLight),
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// JUST FOR UI DESIGN

import 'package:flutter/material.dart';
import 'package:koreanapp/resources/colorManager.dart';
import 'package:koreanapp/services/app_extension.dart';
import 'package:koreanapp/services/appcolors.dart';
import '../../../../widgets/background.dart';
import '../../../../widgets/customBackButton.dart';
import '../../../../widgets/searchbar.dart';

class GrammarView extends StatefulWidget {
  const GrammarView({super.key});

  @override
  State<GrammarView> createState() => _GrammarViewState();
}

class _GrammarViewState extends State<GrammarView> {
  String? title;
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BackgroungWid(
        children: Padding(
          padding: EdgeInsets.only(bottom: 5.h),
          child: Column(
            children: [
              CustomBackButton(
                onBack: () {
                  Navigator.pop(context);
                },
              ),
              Row(
                children: [
                  Text(
                    "Grammar",
                    style: context.text.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _item1(1),
                SearchField(
                  onSearch: (query) {
                    setState(() {
                      _searchQuery = query;
                    });
                  },
                ),
                ListView.builder(
                    padding: EdgeInsets.all(25.h),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return _item2(index);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _item1(int index) {
    return InkWell(
      onTap: () {
        // Handle item tap, e.g., navigate to item details
      },
      child: Container(
        width: 300.w,
        height: 190.h,
        // decoration: BoxDecoration(
        //   color: ColorManager.primary,
        //   borderRadius: BorderRadius.all(Radius.circular(18.r)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0.r)),
          color: ColorManager.grammarbox,
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.12),
                blurRadius: 5.0,
                offset: Offset(0, 5))
          ],
        ),

        margin: EdgeInsets.only(bottom: 25.h),
        child: Padding(
          padding: EdgeInsets.all(15.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
                child: Text(
                  "Grammar of the day",
                  maxLines: 1,
                  style: context.text.headlineSmall!.copyWith(
                    fontSize: 22.sp,
                    color: ColorManager.dashboardTitleColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                "Grammar Title $index",
                style: context.text.titleLarge!.copyWith(
                  color: ColorManager.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
              ),
              Text(
                "Office ipsum you must be muted. Where own by work weaponize pin join sky charts. Die old submit plan savvy. Hours beforehand tentative items innovation incentivize stop. Sky sexy door solutionize any nobody gave looking.",
                style: context.text.titleMedium!.copyWith(
                  color: ColorManager.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "Read More...", // Replace with your desired date
                  style: context.text.titleMedium!.copyWith(
                    color: ColorManager.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item2(int index) {
    return InkWell(
      onTap: () {
        // Handle item tap, e.g., navigate to item details
      },
      child: Container(
        width: 300.w,
        height: 160.h,
        // decoration: BoxDecoration(
        //   color: ColorManager.primary,
        //   borderRadius: BorderRadius.all(Radius.circular(18.r)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0.r)),
          color: ColorManager.primary,
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.12),
                blurRadius: 40.0,
                offset: Offset(0, 4))
          ],
        ),

        margin: EdgeInsets.only(bottom: 25.h),
        child: Padding(
          padding: EdgeInsets.all(15.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 0.h, bottom: 8.h),
                child: Text(
                  "Grammar of the day",
                  maxLines: 1,
                  style: context.text.headlineSmall!.copyWith(
                    fontSize: 22.sp,
                    color: ColorManager.dashboardTitleColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                "Copy Office ipsum you must b",
                style: context.text.titleLarge!.copyWith(
                  color: ColorManager.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
              ),
              Text(
                "Office ipsum you must be muted. Where own by work weaponize pin join sky charts. Die old submit plan savvy. Hours beforehand tentative items innovation incentivize stop. Sky sexy door solutionize any nobody gave looking.",
                style: context.text.titleMedium!.copyWith(
                  color: ColorManager.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "Read More...", // Replace with your desired date
                  style: context.text.titleMedium!.copyWith(
                    color: ColorManager.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
