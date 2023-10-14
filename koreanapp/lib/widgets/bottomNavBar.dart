import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../resources/colorManager.dart';
import '../screens/presentation/dashboard/dashboardview.dart';
import '../services/app_images.dart';

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    PersistentTabController controller;
    controller = PersistentTabController(initialIndex: 0);

    return PersistentTabView(
      context,
      controller: controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: ColorManager.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        adjustScreenBottomPaddingOnCurve: true,
        borderRadius: BorderRadius.circular(10.0.r),
        colorBehindNavBar: ColorManager.white,
      ),
      // margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 10.h),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 500),
      ),
      navBarStyle: NavBarStyle.style2, //style2,  style6, 8
    );
  }
}

List<Widget> _buildScreens() {
  return [
    const Dashboard(),
    const Dashboard(),
    const Dashboard(),
    const Dashboard(),
    const Dashboard(),
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: Icon(
        Icons.home,
        size: 20.h,
        //SvgPicture.asset(AppImagePath.bottomnav1
      ),

      title: "Home",
      textStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),

      // activeColorPrimary: CupertinoColors.activeBlue,
      activeColorSecondary: ColorManager.appbarColor,
      inactiveColorPrimary: ColorManager.black,
      inactiveColorSecondary: ColorManager.black,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.book_sharp, size: 20.h),
      title: "Activities",
      textStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
      activeColorSecondary: ColorManager.appbarColor,
      inactiveColorPrimary: ColorManager.black,
      inactiveColorSecondary: ColorManager.black,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.find_in_page, size: 20.h),
      title: "Settings",
      textStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
      activeColorSecondary: ColorManager.appbarColor,
      inactiveColorPrimary: ColorManager.black,
      inactiveColorSecondary: ColorManager.black,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.event_note_sharp, size: 20.h),
      title: "Settings 4",
      textStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
      activeColorSecondary: ColorManager.appbarColor,
      inactiveColorPrimary: ColorManager.black,
      inactiveColorSecondary: ColorManager.black,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.track_changes_outlined, size: 20.h),
      title: "Settings 5",
      textStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
      activeColorSecondary: ColorManager.appbarColor,
      inactiveColorPrimary: ColorManager.black,
      inactiveColorSecondary: ColorManager.black,
    ),
  ];
}

class CustomNavBarWidget extends StatelessWidget {
  final int selectedIndex;
  final List<PersistentBottomNavBarItem>
      items; // NOTE: You CAN declare your own model here instead of `PersistentBottomNavBarItem`.
  final ValueChanged<int> onItemSelected;

  CustomNavBarWidget({
    required Key key,
    required this.selectedIndex,
    required this.items,
    required this.onItemSelected,
  });

  Widget _buildItem(PersistentBottomNavBarItem item, bool isSelected) {
    return Container(
      alignment: Alignment.center,
      height: 60.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: IconTheme(
              data: IconThemeData(
                  size: 26.0,
                  color: isSelected
                      ? (item.activeColorSecondary == null
                          ? item.activeColorPrimary
                          : item.activeColorSecondary)
                      : item.inactiveColorPrimary == null
                          ? item.activeColorPrimary
                          : item.inactiveColorPrimary),
              child: item.icon,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Material(
              type: MaterialType.transparency,
              child: FittedBox(
                  child: Text(
                "test",
                style: TextStyle(
                    color: isSelected
                        ? (item.activeColorSecondary == null
                            ? item.activeColorPrimary
                            : item.activeColorSecondary)
                        : item.inactiveColorPrimary,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0),
              )),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        width: double.infinity,
        height: 60.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.map((item) {
            int index = items.indexOf(item);
            return Flexible(
              child: GestureDetector(
                onTap: () {
                  this.onItemSelected(index);
                },
                child: _buildItem(item, selectedIndex == index),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
