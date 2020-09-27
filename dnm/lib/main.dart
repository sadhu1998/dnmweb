
import 'package:dnm/screens_test/homePage.dart';
import 'package:dnm/screens_test/signIn.dart';
import 'package:dnm/screens_test/signUp.dart';
import 'package:dnm/screens_test/welcomeUser/welcomeUser.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':(context) => MyHomePage(),
        MyHomePage.route: (context) => MyHomePage(),
        SignIn.route : (context) => SignIn(),
        SignUp.route : (context) => SignUp(),
        WelcomeUser.route : (context) => WelcomeUser()
      },
    );
  }
}
