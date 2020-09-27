import 'package:flutter/cupertino.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';

class EnterOtpAlert {
  Widget getOTPVerifyAlertPage(BuildContext context) {
    Alert(
        context: context,
        title: "Please Enter OTP",
        content: Column(
          children: <Widget>[
            OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width,
              style: TextStyle(fontSize: 20),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              onCompleted: (pin) {
                print("OTP");
              },
            ),
            Container(
              child: Text(
                  "OTP has been sent to the registered mailid. Please verify to continue",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black)),
            )
          ],
        ),
        buttons: []).show();
  }

  Widget wrongOtpEnteredAlert(BuildContext context) {
    Alert(
        context: context,
        title: "Verify OTP",
        desc: "OTP Entered is Wrong",
        buttons: [
          DialogButton(
            color: Colors.red,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Re-Enter OTP",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ]).show();
  }
}
