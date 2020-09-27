import 'package:dnm/screens_test/homePage.dart';
import 'package:dnm/screens_test/signIn.dart';
import 'package:dnm/utils/responsiveLayout.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavBarUser extends StatefulWidget {
  @override
  _NavBarUserState createState() => _NavBarUserState();
}

class _NavBarUserState extends State<NavBarUser> {
  final navItems = ["Blood Requests","Settings", "Contact Us"];
  double _signInButtonWidth = 140;

  clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  List<Widget> navItem() {
    return navItems
        .map((item) => Padding(
        padding: EdgeInsets.only(left: 30),
        child: FlatButton(
          onPressed: () {
            print(item);
            Navigator.pushNamed(context, '/' + item.toLowerCase());
          },
          color: Colors.white,
          child: Text(
            item,
            style: TextStyle(
                fontFamily: "Quicksand", fontWeight: FontWeight.w500, color: Colors.black),
          ),
        )))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: ResponsiveLayout.isSmallScreen(context) ? 40 : 130,
          right: ResponsiveLayout.isSmallScreen(context) ? 40 : 130,
          top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 60,
            height: 60,
            decoration:
            BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: Image.asset("assets/logo.png"),
          ),
          if (!ResponsiveLayout.isSmallScreen(context))
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[...navItem()]..add(GestureDetector(
                onTap: () {
                  clearSharedPreferences();
                  setState(() {
                    _signInButtonWidth =
                    _signInButtonWidth == 140 ? 180 : 140;
                  });
                  Navigator.pushNamed(context, MyHomePage.route);
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  width: _signInButtonWidth,
                  height: 40,
                  margin: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    color: Color(0xFFB0BFDE),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 4),
                          blurRadius: 4)
                    ],
                  ),
                  child: Center(
                    child: AnimatedOpacity(
                      opacity: 1.0,
                      duration: Duration(milliseconds: 500),
                      child: Text(
                        "Log Out",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontFamily: "Quicksand",
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              )),
            )
        ],
      ),
    );
  }
}
