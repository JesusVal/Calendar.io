import 'package:Calendar_io/BLoC/Auth/authentification_service.dart';
import 'package:Calendar_io/BLoC/Auth/form_provider.dart';
import 'package:Calendar_io/Views/Auth/forgotPassword.dart';
import 'package:Calendar_io/Views/Auth/login.dart';
import 'package:Calendar_io/Views/Auth/register.dart';
import 'package:Calendar_io/Views/Calendar/calendar.dart';
import 'package:Calendar_io/Views/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        )
      ],
      child: FormProvider(
        child: MaterialApp(
          title: 'Calendar.io',
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: AuthenticationWrapper(),
          onGenerateRoute: onGenerateRoute,
        ),
      ),
    );
  }

  Route onGenerateRoute(RouteSettings routeSettings) {
    if (routeSettings.name == '/') {
      return MaterialPageRoute(builder: (_) => Login());
    }

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

    // return MaterialPageRoute(builder: (_) => Login());
    return null;
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return Calendar();
    }
    return Login();
  }
}
