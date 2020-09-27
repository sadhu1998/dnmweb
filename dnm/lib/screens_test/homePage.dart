import 'package:dnm/screens_test/navBar.dart';
import 'package:dnm/utils/responsiveLayout.dart';
import 'package:dnm/widgets/mainButton.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  static const String route = '/home';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFF5f6FA),
      body: Stack(
        children: [
          Column(
            children: [
              NavBar(),
              Body(),
            ],
          )
        ],
      ),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      largeScreen: LargeScreen(),
      smallScreen: SmallScreen(),
    );
  }
}

class SmallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Mission",
                style: TextStyle(
                    fontSize: 80,
                    color: Color(0xFF7C8Fb5),
                    fontFamily: "Quicksand",
                    fontWeight: FontWeight.w700),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 550),
                child: Text(
                  "Blood is needed to keep us alive. It brings oxygen and nutrients to all the parts of the body so they can keep working. Blood carries carbon dioxide and other waste materials to the lungs, kidneys, and digestive system to be removed from the body. Blood also fights infections, and carries hormones around the body.",
                  style: TextStyle(fontSize: 16, color: Color(0xFF7C8FB5)),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: <Widget>[
                  MainButton(
                    text: "Sign Up",
                    colors: [Color(0xFF23BCBA), Color(0xFF45E994)],
                    isOnLight: false,
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  MainButton(
                    text: "See Facts",
                    colors: [Colors.white, Colors.white],
                    isOnLight: true,
                  )
                ],
              )
            ],
          ),
          Image.asset("assets/logo.png")
        ],
      ),
    );
  }
}

class LargeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 120),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Mission",
                style: TextStyle(
                    fontSize: 80,
                    color: Color(0xFF7C8Fb5),
                    fontFamily: "Quicksand",
                    fontWeight: FontWeight.w700),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 550),
                child: Text(
                  "Blood is needed to keep us alive. It brings oxygen and nutrients to all the parts of the body so they can keep working. Blood carries carbon dioxide and other waste materials to the lungs, kidneys, and digestive system to be removed from the body. Blood also fights infections, and carries hormones around the body.",
                  style: TextStyle(fontSize: 16, color: Color(0xFF7C8FB5)),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: <Widget>[
                  MainButton(
                    text: "Sign Up",
                    colors: [Color(0xFF23BCBA), Color(0xFF45E994)],
                    isOnLight: false,
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  MainButton(
                    text: "See Facts",
                    colors: [Colors.white, Colors.white],
                    isOnLight: true,
                  )
                ],
              )
            ],
          ),
          Image.asset("assets/logo.png")
        ],
      ),
    );
  }
}
