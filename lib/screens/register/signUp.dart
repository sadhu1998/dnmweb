import 'package:donornearme/constants/Common.dart';
import 'package:donornearme/models/OnOtpVerificationSuccessModel/AddUserRequest.dart';
import 'package:donornearme/models/OnOtpVerificationSuccessModel/GetCitiesListRequest.dart';
import 'package:donornearme/models/OnOtpVerificationSuccessModel/GetDistrictsListRequest.dart';
import 'package:donornearme/models/OnOtpVerificationSuccessModel/GetStatesListRequest.dart';
import 'package:donornearme/models/OnOtpVerificationSuccessModel/GetTownsListRequest.dart';
import 'package:donornearme/models/RegisterScreenModel/SendOtpRequest.dart';
import 'package:donornearme/models/RegisterScreenModel/ValidateOtpRequest.dart';
import 'package:donornearme/screens/homepage/navBar.dart';
import 'package:donornearme/screens/register/RegisterService.dart';
import 'package:donornearme/screens/register/enterOtpAlert.dart';
import 'package:donornearme/screens/register/otpService.dart';
import 'package:donornearme/screens/signin/signIn.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SignUp extends StatefulWidget {
  static const String route = '/signup';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailFieldController = TextEditingController();
  TextEditingController passwordFieldController = TextEditingController();
  TextEditingController fullNameFieldController = TextEditingController();
  TextEditingController mobileNumberFieldController = TextEditingController();
  String country;
  String state;
  String district;
  String city;
  String town;
  String pincode;
  List<String> countriesList = ['India'];
  List<String> statesList = [];
  List<String> districtsList = [];
  List<String> citiesList = [];
  List<String> townsList = [];
  String bloodGroup;
  List<String> bloodGroupsList = [];
  OtpService otpService = OtpService();
  DonorRequestScreenService donorRequestScreenService =
      DonorRequestScreenService();
  EnterOtpAlert enterOtpAlert;

  bool _isVerifield = false;
  bool _pressedRegister = false;
  bool _passwordVisible = false;
  String _otpError = "";

  @override
  void initState() {
    super.initState();
    _getBloodGroupsList();
  }

  _getBloodGroupsList() async {
    Map<String, dynamic> data =
        await donorRequestScreenService.getBloodGroupsList();
    bloodGroupsList = [];
    setState(() {
      var jsonList = data['bloodGroupsList']['blood_group'];
      for (String x in jsonList) {
        bloodGroupsList.add(x);
      }
    });
  }

  Widget RegisterForm() {
    return _isVerifield == true
        ? Container(
            width: 300,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueGrey),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _getCountryField(),
                _getStateField(statesList),
                _getDistrictField(districtsList),
                _getCityField(citiesList),
                _getTownField(townsList),
                _getRegisterAfterVerificationButton(),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          )
        : Container(
            width: 300,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueGrey),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _getFullNameField(),
                _getEmailField(),
                _getPasswordField(),
                _getMobileNumberField(),
                _getBloodGroupField(),
                _getRegisterButton(),
                SizedBox(
                  height: 20,
                )
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

  Widget _getFullNameField() {
    return Container(
        padding: EdgeInsets.all(15),
        child: TextField(
          textAlign: TextAlign.left,
          autofocus: true,
          obscureText: false,
          controller: fullNameFieldController,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Full Name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: Colors.amber,
                  style: BorderStyle.solid,
                ),
              )),
        ));
  }

  Widget _getMobileNumberField() {
    return Container(
        padding: EdgeInsets.all(15),
        child: TextField(
          keyboardType: TextInputType.number,
          textAlign: TextAlign.left,
          autofocus: true,
          obscureText: false,
          controller: mobileNumberFieldController,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Mobile Number",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: Colors.amber,
                  style: BorderStyle.solid,
                ),
              )),
        ));
  }

  Widget _getBloodGroupField() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
          width: 270,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: Colors.black26, style: BorderStyle.solid),
          ),
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: DropdownButton<String>(
            isExpanded: true,
            value: bloodGroup,
            underline: SizedBox(),
            hint: Text(
              'Blood Group',
            ),
            icon: Icon(Icons.keyboard_arrow_down),
            iconSize: 24,
            elevation: 16,
            onChanged: (String newValue) {
              setState(() {
                bloodGroup = newValue;
              });
            },
            items:
                bloodGroupsList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )),
    );
  }

  Widget _getCountryField() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: 270,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Colors.black26, style: BorderStyle.solid),
        ),
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: DropdownButton<String>(
          isExpanded: true,
          value: country,
          underline: SizedBox(),
          hint: Text(
            'Country',
          ),
          icon: Icon(Icons.keyboard_arrow_down),
          iconSize: 24,
          elevation: 16,
          onChanged: (String newValue) async {
            GetStatesListRequest getStatesListRequest =
                new GetStatesListRequest();
            getStatesListRequest.country = newValue;
            Map<String, dynamic> data = await donorRequestScreenService
                .getStatesList(getStatesListRequest);
            setState(() {
              country = newValue;
              var jsonList = data['statesList']['states'];
              statesList = [];
              for (String x in jsonList) {
                statesList.add(x);
              }
            });
          },
          items: countriesList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _getStateField(List<String> statesList) {
    return Container(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          width: 270,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: Colors.black26, style: BorderStyle.solid),
          ),
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: DropdownButton<String>(
            isExpanded: true,
            value: state,
            underline: SizedBox(),
            hint: Text(
              'State',
            ),
            icon: Icon(Icons.keyboard_arrow_down),
            iconSize: 24,
            elevation: 16,
            onChanged: (String newValue) async {
              GetDistrictsListRequest getDistrictsListRequest =
                  new GetDistrictsListRequest();
              getDistrictsListRequest.state = newValue;
              Map<String, dynamic> data = await donorRequestScreenService
                  .getDistrictsList(getDistrictsListRequest);
              setState(() {
                state = newValue;
                districtsList = [];
                var jsonList = data['districtsList']['districts'];
                for (String x in jsonList) {
                  districtsList.add(x);
                }
              });
            },
            items: statesList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ));
  }

  Widget _getDistrictField(List<String> districtsList) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Container(
        width: 270,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Colors.black26, style: BorderStyle.solid),
        ),
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: DropdownButton<String>(
          isExpanded: true,
          value: district,
          underline: SizedBox(),
          hint: Text(
            'District',
          ),
          icon: Icon(Icons.keyboard_arrow_down),
          iconSize: 24,
          elevation: 16,
          onChanged: (String newValue) async {
            GetCitiesListRequest getCitiesListRequest =
                new GetCitiesListRequest();
            getCitiesListRequest.district = newValue;
            Map<String, dynamic> data = await donorRequestScreenService
                .getCitiesList(getCitiesListRequest);
            setState(() {
              district = newValue;
              var jsonList = data['citiesList']['city'];
              List<String> citiesListtemp = [];
              for (String x in jsonList) {
                citiesListtemp.add(x);
              }
              citiesList = citiesListtemp;
            });
          },
          items: districtsList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _getCityField(List<String> citiesList) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Container(
        width: 270,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Colors.black26, style: BorderStyle.solid),
        ),
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: DropdownButton<String>(
          isExpanded: true,
          value: city,
          underline: SizedBox(),
          hint: Text(
            'City',
          ),
          icon: Icon(Icons.keyboard_arrow_down),
          iconSize: 24,
          elevation: 16,
          onChanged: (String newValue) async {
            GetTownsListRequest getTownsListRequest = new GetTownsListRequest();
            getTownsListRequest.city = newValue;
            Map<String, dynamic> data = await donorRequestScreenService
                .getTownsList(getTownsListRequest);
            setState(() {
              city = newValue;
              townsList = [];
              var jsonList = data['townsList']['town'];
              for (String x in jsonList) {
                townsList.add(x);
              }
            });
          },
          items: citiesList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _getTownField(List<String> townsList) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Container(
        width: 270,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Colors.black26, style: BorderStyle.solid),
        ),
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: DropdownButton<String>(
          isExpanded: true,
          value: town,
          underline: SizedBox(),
          hint: Text(
            'Town',
          ),
          icon: Icon(Icons.keyboard_arrow_down),
          iconSize: 24,
          elevation: 16,
          onChanged: (String newValue) async {
            Map<String, dynamic> data =
                await donorRequestScreenService.getBloodGroupsList();
            bloodGroupsList = [];
            setState(() {
              town = newValue;
              bloodGroupsList = [];
              var jsonList = data['bloodGroupsList']['blood_group'];
              for (String x in jsonList) {
                bloodGroupsList.add(x);
              }
            });
          },
          items: townsList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _getRegisterButton() {
    return Container(
        decoration: BoxDecoration(),
        child: FlatButton(
          color: Colors.black,
          textColor: Colors.white,
          onPressed: () {
            SendOtpRequest sendOtpRequest =
                SendOtpRequest(emailFieldController.text);
            otpService.sendOtpToUser(sendOtpRequest);
            getOTPVerifyAlertPage(context, emailFieldController.text);
          },
          child: Text('Register'),
        ));
  }

  Widget _getRegisterAfterVerificationButton() {
    return Container(
        decoration: BoxDecoration(),
        child: FlatButton(
          color: Colors.black,
          textColor: Colors.white,
          onPressed: () async {
            AddUserRequest addUserRequest = new AddUserRequest(
                bloodGroup,
                city,
                country,
                district,
                "true",
                emailFieldController.text,
                passwordFieldController.text,
                mobileNumberFieldController.text,
                pincode,
                "true",
                state,
                town,
                fullNameFieldController.text,
                "");

            Map<String, dynamic> addedData =
                await donorRequestScreenService.addUserToDb(addUserRequest);
            if (addedData['status'] ==
                'Added User Succesfully. Please sign in to continue') {
              Navigator.pushNamed(context, SignIn.route);
            } else {
              print('Failed to add User');
            }
          },
          child: Text('Register'),
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
            _isVerifield
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Register",
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
                              "Please enter details of your location so that even u can help someone!",
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xFF7C8FB5)),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 550),
                            child: Text(
                              "- First field is country. Please enter your country there. Sample Emailid : example@provider.com",
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xFF7C8FB5)),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 550),
                            child: Text(
                              "- Second field is state. Please enter the state",
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xFF7C8FB5)),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 550),
                            child: Text(
                              "- Second field is District. Please enter the District",
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xFF7C8FB5)),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 550),
                            child: Text(
                              "- Second field is City. Please enter the City",
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xFF7C8FB5)),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 550),
                            child: Text(
                              "- Second field is Town. Please enter the Town",
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xFF7C8FB5)),
                            ),
                          )
                        ],
                      ),
                      RegisterForm()
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Register",
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
                              "Please enter the following details to register yourself as a donor/reciepient",
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xFF7C8FB5)),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 550),
                            child: Text(
                              "- First field is emailid. Please enter your emailid there. Sample Emailid : example@provider.com",
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xFF7C8FB5)),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 550),
                            child: Text(
                              "- Second field is password. Please enter the respective password of your account",
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xFF7C8FB5)),
                            ),
                          ),
                        ],
                      ),
                      RegisterForm()
                    ],
                  ),
          ],
        ),
      ),
    ));
  }

  getOTPVerifyAlertPage(BuildContext context, String mailid) {
    Alert(
        context: context,
        title: "Please Enter OTP",
        content: Column(
          children: <Widget>[
            OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width / 5,
              style: TextStyle(fontSize: 20),
              textFieldAlignment: MainAxisAlignment.spaceEvenly,
              onCompleted: (pin) async {
                ValidateOtpRequest validateOtpRequest =
                    ValidateOtpRequest(mailid, pin);
                Map<String, dynamic> valMap =
                    await otpService.validateOtp(validateOtpRequest);
                if (valMap[Common.error] == null) {
                  setState(() {
                    _isVerifield = true;
                    Navigator.pop(context);
                  });
                } else {
                  setState(() {
                    _otpError = valMap[Common.error];
                    wrongOtpEnteredAlert();
                  });
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 550),
              child: Text(
                "Please enter OTP to Continue",
                style: TextStyle(fontSize: 16, color: Color(0xFF7C8FB5)),
              ),
            ))
          ],
        ),
        buttons: []).show();
  }

  wrongOtpEnteredAlert() {
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
