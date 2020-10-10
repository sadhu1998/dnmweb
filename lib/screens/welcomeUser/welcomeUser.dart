import 'package:donornearme/models/DonorListScreenModel/GetAvailableDonorsListRequest.dart';
import 'package:donornearme/models/OnOtpVerificationSuccessModel/GetCitiesListRequest.dart';
import 'package:donornearme/models/OnOtpVerificationSuccessModel/GetDistrictsListRequest.dart';
import 'package:donornearme/models/OnOtpVerificationSuccessModel/GetStatesListRequest.dart';
import 'package:donornearme/models/OnOtpVerificationSuccessModel/GetTownsListRequest.dart';
import 'package:donornearme/screens/register/RegisterService.dart';
import 'package:donornearme/screens/welcomeUser/DonorDetailModel.dart';
import 'package:donornearme/screens/welcomeUser/navBarUser.dart';
import 'package:donornearme/screens/welcomeUser/welcomeUserServices.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeUser extends StatefulWidget {
  static const String route = '/welcomeuser';

  @override
  _WelcomeUserState createState() => _WelcomeUserState();
}

class _WelcomeUserState extends State<WelcomeUser> {
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
  DonorRequestScreenService donorRequestScreenService =
      DonorRequestScreenService();
  WelcomeUserServices welcomeUserServices = WelcomeUserServices();
  List<DonorDetailModel> donorDetailsList = [];
  List<int> notifiedList = [];
  int no_of_pages = 0;
  List<int> pagesNumber = [];
  int currentPageNumber = 1;
  int rows_per_page = 5;
  bool _pressedSearch = false;
  bool _patientDetailsSubmitted = false;

  TextEditingController messageFieldController = new TextEditingController();
  TextEditingController _patientNameFieldController =
      new TextEditingController();
  TextEditingController _patientUnitsRequiredFieldController =
      new TextEditingController();
  TextEditingController _patiendSecondContactNumber =
      new TextEditingController();
  TextEditingController _patientHospitalFieldController =
      new TextEditingController();
  TextEditingController _patientSexFieldController =
      new TextEditingController();
  TextEditingController _patientContactNumberController =
      new TextEditingController();

  List<String> tableColumns = [
    "username",
    "bloodgroup",
    "city",
    "state",
    "Notify Donor"
  ];

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

  String mailid = "";
  bool mailIdAvailable = false;

  _getUserMailId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      mailid = prefs.get("mailid");
      debugPrint("Checking User : " + mailid);

      if (mailid != null) {
        mailIdAvailable = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserMailId();
    _getBloodGroupsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: mailIdAvailable == true
                ? Stack(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _getNavBar(),
//                          SampleFlex(),
                          Expanded(child: _getBody())
                        ],
                      )
                    ],
                  )
                : Container(
                    child: Text("Please Log In"),
                  )));
  }

  Widget _getNavBar() {
    return Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.redAccent,
          border: Border.all(color: Colors.black),
        ),
        child: NavBarUser());
  }

  Widget SampleFlex() {
    return Container(
      child: Row(
        children: [
          Container(
            color: Colors.black,
            width: double.infinity,
            height: 3,
          ),
        ],
      ),
    );
  }

  Widget _getBody() {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://i0.wp.com/saintpolicesystems.com/wp-content/uploads/2018/06/blue-light-backgrounds-background-opera-image-graphics-community-speeddials.jpg?w=1440"),
                    fit: BoxFit.cover),
                border: Border(
                    right: BorderSide(
                        color: Color.fromRGBO(0, 83, 79, 1), width: 3.0))),
            width: double.infinity,
            child: Center(
              child: Column(
                children: [
                  _getCountryField(),
                  _getStateField(statesList),
                  _getDistrictField(districtsList),
                  _getCityField(citiesList),
                  _getTownField(townsList),
                  _getBloodGroupField(),
                  _getSearchButton(),
                ],
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            width: double.infinity,
            height: 50,
          ),
        ),
        Flexible(
            flex: 8,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://wallpaperaccess.com/full/817598.jpg"),
                          fit: BoxFit.cover),
                      border: Border.all(color: Colors.black26, width: 1.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(flex: 5, child: _getPatientDetails()),
                      Flexible(flex: 1, child: _submitMessageButton())
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                  width: double.infinity,
                ),
                _getTableOfDonorsAvailable(),
                _pressedSearch ? _getPaginationRow() : Container()
              ],
            )),
        Flexible(
          flex: 1,
          child: Container(
            width: double.infinity,
            height: 50,
          ),
        )
      ],
    ));
  }

  Widget _getPatientDetails() {
    return Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1000),
          child: Text(
            "Please enter details of reciepient. These details will be sent to donors to their registered mail and phonenumber..",
            style: TextStyle(fontSize: 16, color: Color(0xFF7C8FB5)),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(flex: 2, child: _getPatientNameTextField()),
            Flexible(flex: 1, child: SizedBox()),
            Flexible(flex: 2, child: _getPatientSexTextField()),
            Flexible(flex: 1, child: SizedBox()),
            Flexible(flex: 2, child: _getPatientHospitalTextField()),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(flex: 2, child: _getPatientUnitsRequiredTextField()),
            Flexible(flex: 1, child: SizedBox()),
            Flexible(flex: 2, child: _getPatientContactNumberTextField()),
            Flexible(flex: 1, child: SizedBox()),
            Flexible(flex: 2, child: _getPatientSecondNumberTextField()),
          ],
        )
      ],
    );
  }

  Widget _getPatientNameTextField() {
    return Container(
        child: TextField(
      maxLines: 1,
      textAlign: TextAlign.left,
      autofocus: true,
      obscureText: false,
      controller: _patientNameFieldController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Patient Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Colors.amber,
              style: BorderStyle.solid,
            ),
          )),
    ));
    ;
  }

  Widget _getPatientSexTextField() {
    return Container(
        child: TextField(
      maxLines: 1,
      textAlign: TextAlign.left,
      autofocus: true,
      obscureText: false,
      controller: _patientSexFieldController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Sex- Male/Female",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Colors.amber,
              style: BorderStyle.solid,
            ),
          )),
    ));
    ;
  }

  Widget _getPatientHospitalTextField() {
    return Container(
        child: TextField(
      maxLines: 1,
      textAlign: TextAlign.left,
      autofocus: true,
      obscureText: false,
      controller: _patientHospitalFieldController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Name of the Hospital",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Colors.amber,
              style: BorderStyle.solid,
            ),
          )),
    ));
    ;
  }

  Widget _getPatientUnitsRequiredTextField() {
    return Container(
        child: TextField(
      maxLines: 1,
      textAlign: TextAlign.left,
      autofocus: true,
      obscureText: false,
      controller: _patientUnitsRequiredFieldController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "No.of Units?",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Colors.amber,
              style: BorderStyle.solid,
            ),
          )),
    ));
    ;
  }

  Widget _getPatientSecondNumberTextField() {
    return Container(
        child: TextField(
      maxLines: 1,
      textAlign: TextAlign.left,
      autofocus: true,
      obscureText: false,
      controller: _patiendSecondContactNumber,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Contact No 2",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Colors.amber,
              style: BorderStyle.solid,
            ),
          )),
    ));
    ;
  }

  Widget _getPatientContactNumberTextField() {
    return Container(
        child: TextField(
      maxLines: 1,
      textAlign: TextAlign.left,
      autofocus: true,
      obscureText: false,
      controller: _patientContactNumberController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Contact No 1",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Colors.amber,
              style: BorderStyle.solid,
            ),
          )),
    ));
    ;
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

  Widget _getSearchButton() {
    return Container(
        decoration: BoxDecoration(),
        child: FlatButton(
          color: Colors.black,
          textColor: Colors.white,
          onPressed: () async {
            GetAvailableDonorsListRequest getAvailableDonorsListRequest =
                GetAvailableDonorsListRequest();
//            getAvailableDonorsListRequest.town = town;
//            getAvailableDonorsListRequest.bloodGroup = bloodGroup;
//            getAvailableDonorsListRequest.city = city;
//            getAvailableDonorsListRequest.district = district;
//            getAvailableDonorsListRequest.state = state;
//            getAvailableDonorsListRequest.country = country;
//
            getAvailableDonorsListRequest.town = "Nalgonda";
            getAvailableDonorsListRequest.bloodGroup = "O POSITIVE";
            getAvailableDonorsListRequest.city = "Nalgonda";
            getAvailableDonorsListRequest.district = "Nalgonda";
            getAvailableDonorsListRequest.state = "Telangana";
            getAvailableDonorsListRequest.country = "India";

            Map<String, dynamic> data = await welcomeUserServices
                .getAvailableDonors(getAvailableDonorsListRequest);

            List<DonorDetailModel> tempDonorDetailsList = [];
            List<dynamic> donorMap = data['donorsList'];
            for (Map<String, dynamic> eachDonor in donorMap) {
              DonorDetailModel donorDetailModel =
                  DonorDetailModel.fromJson(eachDonor);
              tempDonorDetailsList.add(donorDetailModel);
            }

            int t_no_of_pages = tempDonorDetailsList.length <= rows_per_page
                ? 1
                : (tempDonorDetailsList.length ~/ rows_per_page) + 1;
            debugPrint("No.of Pages = " + t_no_of_pages.toString());

            List<int> t_pageNumber = [];
//            no_of_pages = 5;
            for (int i = 1; i <= t_no_of_pages; i++) {
              t_pageNumber.add(i);
            }

            setState(() {
              List<int> tempNotify = [];
              for (int i = 0; i < tempDonorDetailsList.length; i++) {
                tempNotify.add(0);
              }
              notifiedList = tempNotify;
              donorDetailsList = tempDonorDetailsList;
              _pressedSearch = true;
              no_of_pages = t_no_of_pages;
              pagesNumber = t_pageNumber;
            });
          },
          child: Text('Search'),
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

  Widget _getTableOfDonorsAvailable() {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        SingleChildScrollView(
          child: Table(
              border: TableBorder.all(color: Colors.black),
              children: _pressedSearch
                  ? [
                        TableRow(
                            decoration: BoxDecoration(
                              color: Color(0xFFB0BFDE),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0, 4),
                                    blurRadius: 4)
                              ],
                            ),
                            children: [
                              TableCell(
                                  child: FlatButton(
                                onPressed: () {},
                                color: Colors.white,
                                child: Text(
                                  "User Name",
                                  style: TextStyle(
                                      fontFamily: "Quicksand",
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                              )),
                              TableCell(
                                  child: FlatButton(
                                onPressed: () {},
                                color: Colors.white,
                                child: Text(
                                  "Town",
                                  style: TextStyle(
                                      fontFamily: "Quicksand",
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                              )),
                              TableCell(
                                  child: FlatButton(
                                onPressed: () {},
                                color: Colors.white,
                                child: Text(
                                  "District",
                                  style: TextStyle(
                                      fontFamily: "Quicksand",
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                              )),
                              TableCell(
                                  child: FlatButton(
                                onPressed: () {},
                                color: Colors.white,
                                child: Text(
                                  "Blood Group",
                                  style: TextStyle(
                                      fontFamily: "Quicksand",
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                              )),
                              TableCell(
                                  child: FlatButton(
                                onPressed: () {},
                                color: Colors.white,
                                child: Text(
                                  "Notify",
                                  style: TextStyle(
                                      fontFamily: "Quicksand",
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                              )),
                            ])
                      ] +
                      forEachDonor(donorDetailsList, notifiedList)
                  : [
                      TableRow(
                          decoration: BoxDecoration(
                            color: Color(0xFFB0BFDE),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0, 4),
                                  blurRadius: 4)
                            ],
                          ),
                          children: [
                            TableCell(
                                child: FlatButton(
                              onPressed: () {},
                              color: Colors.white,
                              child: Text(
                                "User Name",
                                style: TextStyle(
                                    fontFamily: "Quicksand",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            )),
                            TableCell(
                                child: FlatButton(
                              onPressed: () {},
                              color: Colors.white,
                              child: Text(
                                "Town",
                                style: TextStyle(
                                    fontFamily: "Quicksand",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            )),
                            TableCell(
                                child: FlatButton(
                              onPressed: () {},
                              color: Colors.white,
                              child: Text(
                                "District",
                                style: TextStyle(
                                    fontFamily: "Quicksand",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            )),
                            TableCell(
                                child: FlatButton(
                              onPressed: () {},
                              color: Colors.white,
                              child: Text(
                                "Blood Group",
                                style: TextStyle(
                                    fontFamily: "Quicksand",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            )),
                            TableCell(
                                child: FlatButton(
                              onPressed: () {},
                              color: Colors.white,
                              child: Text(
                                "Notify",
                                style: TextStyle(
                                    fontFamily: "Quicksand",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            )),
                          ])
                    ]),
        ),
      ],
    );
  }

  List<TableRow> forEachDonor(
      List<DonorDetailModel> donorDetailsList, List<int> notifiedList) {
    List<TableRow> eachRow = [];
    int startlimit = currentPageNumber == 1
        ? 0
        : rows_per_page * (currentPageNumber - 1) - 1;
    int endlimit = startlimit + 5 < donorDetailsList.length
        ? startlimit + 5
        : donorDetailsList.length;

    debugPrint("Start Limit :" + startlimit.toString());
    debugPrint("End Limit :" + endlimit.toString());

    for (int j = startlimit; j < endlimit; j++) {
      bool _bluecolor = j % 2 == 0;
      DonorDetailModel donorDetail = donorDetailsList[j];
      eachRow.add(TableRow(
          decoration: BoxDecoration(
              color: _bluecolor ? Colors.blue[50] : Colors.black12),
          children: [
            TableCell(child: Center(child: Text(donorDetail.username))),
            TableCell(child: Center(child: Text(donorDetail.city))),
            TableCell(child: Center(child: Text(donorDetail.city))),
            TableCell(child: Center(child: Text(donorDetail.bloodgroup))),
            TableCell(
                child: Center(
                    child: notifiedList[j] == 0
                        ? _getNotifyButton(donorDetail, j)
                        : _getPostNotifyButton(donorDetail, j)))
          ]));
    }
    return eachRow;
  }

  _showAlert(String title, String description) {
    showDialog<void>(
      context: context,
      builder: (_) {
        return Container(
          child: SimpleDialog(
            title: Text(title),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Text(description)],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _getNotifyButton(DonorDetailModel donorDetailModel, int j) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _patientDetailsSubmitted
              ? notifiedList[j] = 1
              : _showAlert(
                  "Failed", "Please submit details of patient to notify donor");
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        height: 40,
        margin: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: Color(0xFFB0BFDE),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 4), blurRadius: 4)
          ],
        ),
        child: Center(
          child: AnimatedOpacity(
            opacity: 1.0,
            duration: Duration(milliseconds: 500),
            child: Text(
              "Notify",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontFamily: "Quicksand",
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getPostNotifyButton(DonorDetailModel donorDetailModel, int j) {
    return GestureDetector(
      onTap: () {
        setState(() {});
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        height: 40,
        margin: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: Color(0xFFB0BFDE),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 4), blurRadius: 4)
          ],
        ),
        child: Center(
          child: AnimatedOpacity(
            opacity: 1.0,
            duration: Duration(milliseconds: 500),
            child: Text(
              "Notified",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontFamily: "Quicksand",
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }

  Widget _submitMessageButton() {
    return Padding(
        padding: EdgeInsets.only(left: 30),
        child: FlatButton(
          onPressed: () {
            if (_patientUnitsRequiredFieldController.text == null ||
                _patientDetailsSubmitted == null ||
                _patientHospitalFieldController == null ||
                _patiendSecondContactNumber == null ||
                _patientContactNumberController == null ||
                _patientNameFieldController == null ||
                _patientSexFieldController == null ||
                _patientUnitsRequiredFieldController.text == "" ||
                _patientDetailsSubmitted == "" ||
                _patientHospitalFieldController == "" ||
                _patiendSecondContactNumber == "" ||
                _patientContactNumberController == "" ||
                _patientNameFieldController == "" ||
                _patientSexFieldController == "") {
              _showAlert("Missing Field", "Please enter all the details.");
            } else {
              setState(() {
                _patientDetailsSubmitted = true;
                debugPrint("Submitted Details Succesfully");
                _showAlert("Successful", "Details Submitted Succesfully. Please click on Notify Donor to notify Donor");
              });
            }
          },
          color: Colors.white,
          child: Text(
            "Submit",
            style: TextStyle(
                fontFamily: "Quicksand",
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
        ));
  }

  Widget _getPaginationRow() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
//              Padding(
//                padding: const EdgeInsets.all(8.0),
//                child: _getLeftArrowButton(),
//              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [...boxForEveryPage()],
                ),
              ),
//              Padding(
//                padding: const EdgeInsets.all(8.0),
//                child: _getRightArrowButton(),
//              )
            ],
          )
        ],
      ),
    );
  }

  List<Widget> boxForEveryPage() {
    return pagesNumber
        .map((item) => item.toString() == currentPageNumber.toString()
            ? Container(
                width: 50,
                height: 30,
                decoration: BoxDecoration(border: Border.all(width: 3)),
                child: FlatButton(
                  onPressed: () {
                    print(item);
                    setState(() {
                      currentPageNumber = item;
                    });
                  },
                  color: Colors.white,
                  child: Text(
                    item.toString(),
                    style: TextStyle(
                        fontFamily: "Quicksand",
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
              )
            : Container(
                width: 50,
                height: 30,
                decoration: BoxDecoration(border: Border.all()),
                child: FlatButton(
                  onPressed: () {
                    print(item);
                    setState(() {
                      currentPageNumber = item;
                    });
                  },
                  color: Colors.white,
                  child: Text(
                    item.toString(),
                    style: TextStyle(
                        fontFamily: "Quicksand",
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
              ))
        .toList();
  }

  Widget _getLeftArrowButton() {
    return Container(
      width: 60,
//      height: 40,
      decoration: BoxDecoration(border: Border.all(width: 3)),
      child: FlatButton.icon(
        icon: Icon(
          Icons.chevron_left,
          size: 15,
        ),
        onPressed: () {
          setState(() {
            currentPageNumber =
                currentPageNumber == 1 ? 1 : currentPageNumber - 1;
          });
        },
        color: Colors.white,
        label: Text(''),
      ),
    );
  }

  Widget _getRightArrowButton() {
    return Container(
      width: 60,
//      height: 40,
      decoration: BoxDecoration(border: Border.all(width: 3)),
      child: FlatButton.icon(
        icon: Icon(
          Icons.chevron_right,
          size: 15,
        ),
        onPressed: () {
          setState(() {
            currentPageNumber = currentPageNumber == no_of_pages
                ? no_of_pages
                : currentPageNumber + 1;
          });
        },
        color: Colors.white,
        label: Text(''),
      ),
    );
  }
}
