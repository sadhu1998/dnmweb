import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class welcome_screen extends StatefulWidget{
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();

}

class _WelcomeScreenState extends State<welcome_screen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Hello World"),
    );
    throw UnimplementedError();
  }

}