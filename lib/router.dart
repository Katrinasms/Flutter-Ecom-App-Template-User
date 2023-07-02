import 'package:custom_shop/features/auth/screen/login.dart';
import 'package:custom_shop/features/auth/screen/register.dart';
import 'package:custom_shop/features/home/screen/bottom_bar.dart';
import 'package:custom_shop/features/home/screen/home.dart';
import 'package:custom_shop/features/thank/screen/thank.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => const Login());
    case '/register':
      return MaterialPageRoute(builder: (context) => const Register());
    case '/home':
      return MaterialPageRoute(builder: (context) => const Home());
    case '/bottom_bar':
      return MaterialPageRoute(builder: (context) => const BottomBar());
    case '/thank':
      return MaterialPageRoute(builder: (context) => const Thank());
    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text('Screen Dose Not Exist!'),
                ),
              ));
  }
}
