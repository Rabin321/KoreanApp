import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:koreanapp/routes/string_manager.dart';
import 'package:koreanapp/screens/auth/congrats.dart';
import 'package:koreanapp/screens/onboarding/onboardingScreen.dart';
import 'package:koreanapp/screens/presentation/dashboard/grammar/grammarview.dart';
import 'package:koreanapp/screens/presentation/signin/signin.dart';
import 'package:koreanapp/screens/presentation/signup/signup.dart';
import 'package:koreanapp/widgets/bottomNavBar.dart';

class Routes {
    static const String index = "/";

  static const String signIn = "/signIn";
  static const String signUp = "/signUp";
  static const String onboarding = "/onboarding";
  static const String congrats = "/congrats";
  static const String homeBottomNavBar = "/homeBottomNavBar";
  static const String grammarView = "/grammarView";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    switch (routeSettings.name) {
      case Routes.index:
        return MaterialPageRoute(builder: (_) {
          if (user != null) {
            // User is logged in, navigate to HomeBottomNavBar
            print("logged in User is $user");
            return HomeBottomNavBar();
          } else {
            // User is not logged in, navigate to SignIn
            return SignIn();
          }
        });

      case Routes.signUp:
        return MaterialPageRoute(builder: (_) => const SignUp());

      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case Routes.congrats:
        return MaterialPageRoute(builder: (_) => Congrats());

      case Routes.homeBottomNavBar:
        return MaterialPageRoute(builder: (_) => const HomeBottomNavBar());

      case Routes.grammarView:
        return MaterialPageRoute(builder: (_) => const GrammarView());



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
