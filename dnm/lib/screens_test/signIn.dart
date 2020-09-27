import 'package:dnm/constants/Common.dart';
import 'package:dnm/models/LoginScreenModel/AuthenticateRequest.dart';
import 'package:dnm/screens_test/navBar.dart';
import 'package:dnm/screens_test/signin/loginScreenService.dart';
import 'package:dnm/screens_test/welcomeUser/welcomeUser.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  static const String route = '/signin';

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailFieldController = TextEditingController();
  TextEditingController passwordFieldController = TextEditingController();
  bool _passwordVisible = false;
  bool _authSuccesful = false;
  String _error = "";
  LoginScreenService loginScreenService = LoginScreenService();
  AuthenticateModel authenticateModel;

  _setUserMailidPrefs(String mailid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
//    print(mailid);
    debugPrint("Logging User : "+mailid);
    prefs.setString("mailid", mailid);
  }

  Widget LoginForm() {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueGrey),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _getEmailField(),
          _getPasswordField(),
          _getLogInButton(),
        SizedBox(
            child: Text(
              _error,
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: Colors.red,
                  fontFamily: 'Open Sans',
                  fontSize: 10,
                  fontWeight: FontWeight.bold),
            )),
          _getForgotPasswordLabel()
        ],
      ),
    );
  }

  Widget _getEmailField() {
    return Container(
        padding: EdgeInsets.all(15),
        child: TextField(
          textAlign: TextAlign.left,
          autofocus: true,
          obscureText: false,
          controller: emailFieldController,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: Colors.amber,
                  style: BorderStyle.solid,
                ),
              )),
        ));
  }

  Widget _getPasswordField() {
    return Container(
        padding: EdgeInsets.all(15),
        child: TextField(
            obscureText: _passwordVisible,
            controller: passwordFieldController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color: Colors.amber,
                    style: BorderStyle.solid,
                  ),
                ),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Password",
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ))));
  }

  Widget _getLogInButton() {
    return Container(
        decoration: BoxDecoration(),
        child: FlatButton(
          color: Colors.black,
          textColor: Colors.white,
          onPressed: () async {
            authenticateModel = new AuthenticateModel(emailFieldController.text, passwordFieldController.text);
            Map<String, dynamic> data =
                await loginScreenService.authenticate(authenticateModel);
            if (data[Common.error] == null) {
              setState(() {
                _authSuccesful = true;
                debugPrint("Try Logging User : "+emailFieldController.text);

                _setUserMailidPrefs(emailFieldController.text);
              });

              Navigator.pushNamed(context, WelcomeUser.route);
            } else {
              setState(() {
                _error = data[Common.error];
              });
            }
          },
          child: Text('Log In'),
        ));
  }

  Widget _getForgotPasswordLabel() {
    return InkWell(
        onTap: () {},
        child: Container(
//        margin: EdgeInsets.symmetric(vertical: 20),
          padding: EdgeInsets.all(10),
          alignment: Alignment.bottomRight,
          child: Text(
            'Forgot Password?',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 120),
        child: Column(
          children: [
            NavBar(),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 80,
                          color: Color(0xFF7C8Fb5),
                          fontFamily: "Quicksand",
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 550),
                      child: Text(
                        "The login page allows a user to gain access to an application by entering their username and password or by authenticating using a social media login.r",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF7C8FB5)),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 550),
                      child: Text(
                        "- First field is emailid. Please enter your emailid there. Sample Emailid : example@provider.com",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF7C8FB5)),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 550),
                      child: Text(
                        "- Second fied is password. Please enter the respective password of your account",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF7C8FB5)),
                      ),
                    ),
                  ],
                ),
                LoginForm()
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
