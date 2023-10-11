import 'package:flutter/material.dart';
import 'package:koreanapp/routes/string_manager.dart';
import 'package:koreanapp/screens/auth/congrats.dart';
import 'package:koreanapp/screens/onboarding/onboardingScreen.dart';
import 'package:koreanapp/screens/presentation/signin/signin.dart';
import 'package:koreanapp/screens/presentation/signup/signup.dart';
import 'package:koreanapp/widgets/bottomNavBar.dart';

class Routes {
  static const String signIn = "/";
  static const String signUp = "/signUp";
  static const String onboarding = "/onboarding";
  static const String congrats = "/congrats";
  static const String homeBottomNavBar = "/homeBottomNavBar";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.signIn:
        return MaterialPageRoute(builder: (_) => const SignIn());

      case Routes.signUp:
        return MaterialPageRoute(builder: (_) => const SignUp());
      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case Routes.congrats:
        return MaterialPageRoute(builder: (_) => Congrats());
      case Routes.homeBottomNavBar:
        return MaterialPageRoute(builder: (_) => const HomeBottomNavBar());
      // case Routes.dematRoute:
      //   return MaterialPageRoute(builder: (_) => const DematServiceView());
      // case Routes.lockerServiceRoute:
      //   return MaterialPageRoute(builder: (_) => const LockerServiceView());

      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}
