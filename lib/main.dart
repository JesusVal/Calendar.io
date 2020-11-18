import 'package:Calendar_io/BLoC/Auth/form_provider.dart';
import 'package:Calendar_io/Views/Auth/forgotPassword.dart';
import 'package:Calendar_io/Views/Auth/login.dart';
import 'package:Calendar_io/Views/Auth/register.dart';
import 'package:Calendar_io/Views/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FormProvider(
      child: MaterialApp(
        title: 'Calendar.io',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: onGenerateRoute,
      ),
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
