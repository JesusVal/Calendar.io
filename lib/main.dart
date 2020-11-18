import 'package:Calendar_io/Views/Auth/forgotPassword.dart';
import 'package:Calendar_io/Views/Auth/login.dart';
import 'package:Calendar_io/Views/Auth/register.dart';
import 'package:Calendar_io/Views/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendar.io',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: onGenerateRoute,
    );
  }

  Route onGenerateRoute(RouteSettings routeSettings) {
    if (routeSettings.name == '/login') {
      // return null;
      return MaterialPageRoute(builder: (_) => Login());
    }
    if (routeSettings.name == '/forgot_password') {
      // return null;
      return MaterialPageRoute(builder: (_) => ForgotPassword());
    }
    if (routeSettings.name == '/register') {
      return MaterialPageRoute(builder: (_) => Register());
      // return null;
    }
    if (routeSettings.name == '/calendar') {
      return null;
      // return MaterialPageRoute(builder: (_) => CalendarView());
    }
    return MaterialPageRoute(builder: (_) => Login());
  }
}
