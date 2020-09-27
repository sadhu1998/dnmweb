import 'package:dnm/screens_test/signIn.dart';
import 'package:dnm/utils/responsiveLayout.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final navItems = ["Home", "Features", "About Us", "Contact Us"];
  double _signInButtonWidth = 140;

  List<Widget> navItem() {
    return navItems
        .map((item) => Padding(
            padding: EdgeInsets.only(left: 30),
            child: OutlineButton(
              onPressed: () {
                print(item);
                Navigator.pushNamed(context, '/' + item.toLowerCase());
              },
              child: Text(
                item,
                style: TextStyle(
                    fontFamily: "Quicksand", fontWeight: FontWeight.w500),
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
          top: 25),
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
                    setState(() {
                      _signInButtonWidth =
                          _signInButtonWidth == 140 ? 180 : 140;
                    });
                    Navigator.pushNamed(context, SignIn.route);
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
                          "Sign In",
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
