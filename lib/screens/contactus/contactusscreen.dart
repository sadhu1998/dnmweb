import 'package:donornearme/screens/contactus/bodyContactUs.dart';
import 'package:donornearme/screens/contactus/navBarContactUs.dart';
import 'package:flutter/material.dart';

class ContactUs extends StatefulWidget {
  static String route = "/contactus";

  _ContactUsScreen createState() => _ContactUsScreen();
}

class _ContactUsScreen extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        child: Stack(
          children: [
            Column(
              children: [_getNavBar(context), Expanded(child: BodyContactUs())],
            ),
          ],
        ),
      ),
    );
  }

  Widget _getNavBar(BuildContext context) {
    return Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.redAccent,
          border: Border.all(color: Colors.black),
        ),
        child: NavBarContactUs());
  }

}