import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:koreanapp/services/app_extension.dart';

import '../services/appcolors.dart';

class HomeBottomNavBar extends StatefulWidget {
  const HomeBottomNavBar({Key? key}) : super(key: key);

  @override
  State<HomeBottomNavBar> createState() => _HomeBottomNavBarState();
}

class _HomeBottomNavBarState extends State<HomeBottomNavBar> {
  int _activePage = 0;
  final _tabItems = [
    // Dashboard(

    // ),
    // Discussion(),
    // News()
  ];

  @override
  void initState() {
    // AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    //   if (!isAllowed) {
    //     AwesomeNotifications().requestPermissionToSendNotifications();
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: Duration(milliseconds: 400),
        index: 0,
        backgroundColor: Colors.white,
        onTap: (index) {
          setState(() {
            _activePage = index;
            print(_activePage);
          });
        },
        height: 50.h,
        color: AppColors.primary,
        items: [
          Icon(
            Icons.home,
            size: 30.h,
            color: Colors.white,
          ),
          Icon(
            Icons.chat,
            size: 30.h,
            color: Colors.white,
          ),
          Icon(
            Icons.newspaper,
            size: 30.h,
            color: Colors.white,
          ),
        ],
      ),
      body: _tabItems[_activePage],
    );
  }
}
