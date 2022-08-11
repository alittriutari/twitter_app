import 'package:flutter/material.dart';
import 'package:twitter_app/features/presentation/pages/main_page.dart';
import 'package:twitter_app/features/presentation/pages/signin_page.dart';
import 'package:twitter_app/features/presentation/pages/signup_page.dart';

class Routes {
  Route<dynamic> route(RouteSettings settings) {
    switch (settings.name) {
      case MainPage.routeName:
        return pageRoute(page: const MainPage());
      case SignInPage.routeName:
        return pageRoute(page: const SignInPage());
      case SignUpPage.routeName:
        return pageRoute(page: const SignUpPage());
      default:
        return pageRoute(page: const SignUpPage());
    }
  }

  static MaterialPageRoute<dynamic> pageRoute({required Widget page}) {
    return MaterialPageRoute(builder: (_) => page);
  }
}
