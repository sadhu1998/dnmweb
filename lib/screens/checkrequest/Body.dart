import 'package:donornearme/models/BloodRequestListModel/GetBloodRequestListRequest.dart';
import 'package:donornearme/models/BloodRequestListModel/BloodRequestsModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'GetBloodRequestService.dart';

class Body extends StatefulWidget {
  @override
  _BodyScreen createState() => _BodyScreen();
}

class _BodyScreen extends State<Body> {
  List<BloodRequestor> requestorsList = [];
  String mailid;
  bool mailIdAvailable = false;
  int rows_per_page = 5;
  int endlimitIfAvailable = 0;
  int currentPageNumber = 1;
  bool reqAvailable = false;

  @override
  void initState() {
    _getBloodRequestsList(mailid);
  }

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

  _getBloodRequestsList(String mailid) async {
//    _getUserMailId();
    GetBloodRequestListRequest getBloodRequestListRequest =
        new GetBloodRequestListRequest("prudhvik.1996@gmail.com");
    GetBloodRequestService getBloodRequestService =
        new GetBloodRequestService();
    Map<String, dynamic> data = await getBloodRequestService
        .getBloodRequestsList(getBloodRequestListRequest);
    var jsonList = data['requestsList'];
    List<BloodRequestor> tempList = [];
    for (Map x in jsonList) {
      BloodRequestor bloodRequestor = BloodRequestor.fromMap(x);
      tempList.add(bloodRequestor);
    }
    setState(() {
      requestorsList = tempList;
      if (!requestorsList.isEmpty) {
        reqAvailable = true;
        endlimitIfAvailable = requestorsList.length;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "http://www.mqa.co.ls/wpimages/wp427929f8_06.png"),
                fit: BoxFit.cover)),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  Flexible(
                      flex: 3,
                      child: reqAvailable
                          ? _getTableOfDonorsAvailable()
                          : Container()),
                  Flexible(
                    flex: 1,
                    child: SizedBox(),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getTableOfDonorsAvailable() {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(),
        child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: TableBorder.all(color: Colors.black),
            children: [
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
                forEachDonor(requestorsList)),
      ),
    );
  }

  List<TableRow> forEachDonor(List<BloodRequestor> requestorsList) {
    List<TableRow> eachRow = [];
    debugPrint("RequestorList length :" + requestorsList.length.toString());
    int startlimit = 0;
    int endlimit =
        requestorsList.length != null ? requestorsList.length - 1 : 0;

    for (int j = startlimit; j < endlimit; j++) {
      bool _bluecolor = j % 2 == 0;
      BloodRequestor bloodRequest = requestorsList[j];
      eachRow.add(TableRow(
          decoration:
              BoxDecoration(color: _bluecolor ? Colors.blue[50] : Colors.white),
          children: [
            TableCell(child: Center(child: Text(bloodRequest.username))),
            TableCell(child: Center(child: Text(bloodRequest.bloodgroup))),
            TableCell(child: Center(child: Text(bloodRequest.recipient_id))),
            TableCell(child: Center(child: Text(bloodRequest.bloodgroup))),
            TableCell(
                child: Center(child: _getContactInfoButton(bloodRequest, j)))
          ]));
    }
    return eachRow;
  }

  Widget _getContactInfoButton(BloodRequestor bloodRequestor, int j) {
    return Center(
        child: IconButton(
      splashRadius: 1,
      color: Colors.black38,
      icon: Icon(Icons.info),
      onPressed: () {
        debugPrint("Fetching Info of " + bloodRequestor.username);
        _reciepientDetailView(bloodRequestor);
      },
    ));
  }

  _reciepientDetailView(BloodRequestor bloodRequestor) {
    showDialog<void>(
      context: context,
      builder: (_) {
        return Container(
          child: SimpleDialog(
            title: Text(bloodRequestor.username),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(bloodRequestor.message)
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: SimpleDialogOption(
                      onPressed: () => print(0),
                      child: OutlineButton(
                        onPressed: () {
                          debugPrint("Thankyou!");
                        },
                        child: Text(
                          "Thanks!!",
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  showEndGamePopUp() {
    showDialog<void>(
      context: context,
      builder: (_) {
        return Container(
          child: SimpleDialog(
            backgroundColor: Colors.red,
            elevation: 2.0,
            title: Text(
              "wins!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                height: 1.5,
              ),
            ),
            children: <Widget>[
              Row(children: <Widget>[
                Expanded(
                    child: SimpleDialogOption(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Play again"),
                )),
              ]),
              Row(
                children: <Widget>[
                  Expanded(
                    child: SimpleDialogOption(
                      onPressed: () => print(0),
                      child: Text("Exit"),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
