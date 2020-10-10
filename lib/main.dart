import 'package:donornearme/screens/checkrequest/checkRequest.dart';
import 'package:donornearme/screens/contactus/contactusscreen.dart';
import 'package:donornearme/screens/homepage/homePage.dart';
import 'package:donornearme/screens/signin/signIn.dart';
import 'package:donornearme/screens/register/signUp.dart';
import 'package:donornearme/screens/welcomeUser/welcomeUser.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Donor Near Me",
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':(context) => MyHomePage(),
        MyHomePage.route: (context) => MyHomePage(),
        SignIn.route : (context) => SignIn(),
        SignUp.route : (context) => SignUp(),
        WelcomeUser.route : (context) => WelcomeUser(),
        CheckRequest.route : (context) => CheckRequest(),
        ContactUs.route : (context) => ContactUs()
      },
    );
  }
}
