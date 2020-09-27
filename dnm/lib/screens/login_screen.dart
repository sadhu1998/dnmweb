import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailFieldController = TextEditingController();
  TextEditingController passwordFieldController = TextEditingController();
  bool _passwordVisible = false;
  double _formProgress = 0;
  bool _loginClick = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red[50],
        appBar: AppBar(
          title: Text("Donor Near Me"),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                child: SizedBox(
              width: 400,
              height: 400,
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2.0)),
                  child: ListView.builder(
                    itemCount: 20,
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return userNotificationsView(index);
                    },
                  )),
            )),
            Expanded(
                child: SizedBox(
                    width: 400,
                    child: ListView(
                      children: [
                        Text("Welcome To Donor Near Me"),
                        Container(
                          child: Image.asset('assets/logo.png'),
                        )
                      ],
                    ))),
            Expanded(
                child: SizedBox(
                    width: 400,
                    height: 400,
                    child: Card(
                      child: Center(child: getForm()),
                    )))
          ],
        ));
  }

  Widget getForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
                child: _loginClick == true
                    ? _logUiButtonOnClick()
                    : _logUiButton()),
            Expanded(
                child: _loginClick == false
                    ? _regUiButtonOnClick()
                    : _regUiButton())
          ],
        ),
        Expanded(
//          flex: 1,
          child: _loginClick == true ? LoginForm() : RegisterForm(),
        )
      ],
    );
  }

  Widget _logUiButton() {
    return Container(
        decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: Color.fromRGBO(0, 83, 79, 1), width: 3.0),
              right:
                  BorderSide(color: Color.fromRGBO(0, 83, 79, 1), width: 3.0),
              bottom:
                  BorderSide(color: Color.fromRGBO(0, 83, 79, 1), width: 3.0),
              left:
                  BorderSide(color: Color.fromRGBO(0, 83, 79, 1), width: 3.0)),
        ),
        child: FlatButton(
          color: Colors.white,
          textColor: Colors.black,
          onPressed: () {
            setState(() {
              _loginClick = true;
            });
          },
          child: Text('Log In'),
        ));
  }

  Widget _logUiButtonOnClick() {
    return Container(
        decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: Color.fromRGBO(0, 83, 79, 1), width: 3.0),
              right:
                  BorderSide(color: Color.fromRGBO(0, 83, 79, 1), width: 3.0),
              left:
                  BorderSide(color: Color.fromRGBO(0, 83, 79, 1), width: 3.0)),
        ),
        child: FlatButton(
          color: Colors.white,
          textColor: Colors.black,
          onPressed: () {
            setState(() {
              _loginClick = true;
            });
          },
          child: Text('Log In'),
        ));
  }

  Widget _regUiButton() {
    return Container(
        decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(color: Color.fromRGBO(0, 83, 79, 1), width: 3.0),
              top: BorderSide(color: Color.fromRGBO(0, 83, 79, 1), width: 3.0),
              right:
                  BorderSide(color: Color.fromRGBO(0, 83, 79, 1), width: 3.0),
              left:
                  BorderSide(color: Color.fromRGBO(0, 83, 79, 1), width: 3.0)),
        ),
        child: FlatButton(
          color: Colors.white,
          textColor: Colors.black,
          onPressed: () {
            setState(() {
              _loginClick = false;
            });
          },
          child: Text('Register'),
        ));
  }

  Widget _regUiButtonOnClick() {
    return Container(
        decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: Color.fromRGBO(0, 83, 79, 1), width: 3.0),
              right:
                  BorderSide(color: Color.fromRGBO(0, 83, 79, 1), width: 3.0),
              left:
                  BorderSide(color: Color.fromRGBO(0, 83, 79, 1), width: 3.0)),
        ),
        child: FlatButton(
          color: Colors.white,
          textColor: Colors.black,
          onPressed: () {
            setState(() {
              _loginClick = false;
            });
          },
          child: Text('Register'),
        ));
  }

  Widget RegisterForm() {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(color: Color.fromRGBO(0, 83, 79, 1), width: 3.0),
              right:
                  BorderSide(color: Color.fromRGBO(0, 83, 79, 1), width: 3.0),
              left:
                  BorderSide(color: Color.fromRGBO(0, 83, 79, 1), width: 3.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Text("Reg")],
        ));
  }

  Widget LoginForm() {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(color: Color.fromRGBO(0, 83, 79, 1), width: 3.0),
              right:
                  BorderSide(color: Color.fromRGBO(0, 83, 79, 1), width: 3.0),
              left:
                  BorderSide(color: Color.fromRGBO(0, 83, 79, 1), width: 3.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _getEmailField(),
            _getPasswordField(),
            _getLogInButton(),
            _getForgotPasswordLabel()
          ],
        ));
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
            obscureText: !_passwordVisible,
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
        child: FlatButton(
      color: Colors.black,
      textColor: Colors.white,
      onPressed: () {
        setState(() {});
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

  Widget userNotificationsView(int index) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 0.1),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/logo.png'),
          ),
          title: Text('Notification ' + index.toString()),
          subtitle: Text('SubTitle ' + index.toString()),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {},
          onLongPress: () {},
        ));
  }
}
