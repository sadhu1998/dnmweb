import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainButton extends StatefulWidget {
  List<Color> colors;
  String text;
  bool isOnLight;

  MainButton({Key key, @required this.colors, this.text, this.isOnLight})
      : super(key: key);

  @override
  _MainButtonTheme createState() => _MainButtonTheme(colors, text, isOnLight);
}

class _MainButtonTheme extends State<MainButton> {
  final List<Color> colors;
  final String text;
  final bool isOnLight;
  double _opacity = 1.0;
  double _containerWidth = 150;

  _MainButtonTheme(this.colors, this.text, this.isOnLight);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/'+text.toLowerCase().replaceAll(' ', ''));
          setState(() {
            _containerWidth = _containerWidth == 150 ? 200 : 150;
          });
        },
        child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            width: _containerWidth,
            height: 50,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: colors,
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                      color: Color(0XFF6078ea),
                      offset: Offset(0, 8),
                      blurRadius: 8)
                ]),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isOnLight
                      ? Icon(
                          Icons.play_circle_filled,
                          color: Color(0XFFB0BFDE),
                        )
                      : Container(),
                  AnimatedOpacity(
                      opacity: _opacity,
                      duration: Duration(milliseconds: 500),
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: 16,
                          color: isOnLight ? Color(0XFF7C8FB5) : Colors.white,
                          letterSpacing: 1,
                        ),
                      ))
                ],
              ),
            )));
  }
}
