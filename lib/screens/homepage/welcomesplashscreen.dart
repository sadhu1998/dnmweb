import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

class WelcomeSplashScreen extends StatefulWidget {
  static const String route = '/welcome';

  @override
  _WelcomeSplashScreen createState() => new _WelcomeSplashScreen();
}

class _WelcomeSplashScreen extends State<WelcomeSplashScreen> {
  bool isUserLoggedIn = false;
  String mailid = '';

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 4,
        navigateAfterSeconds: Navigator.pushNamed(context, '/home'),
        title: new Text(
          'Welcome to Donor Near Me',
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
        ),
//        image: new Image.asset("assets/logo.png"),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
//        photoSize: 100.0,
        onClick: () => print("Donor Near Me"),
        loaderColor: Colors.red);
  }
}
