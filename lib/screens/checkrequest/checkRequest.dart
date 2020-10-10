import 'file:///F:/web/dnm/lib/models/BloodRequestListModel/BloodRequestsModel.dart';
import 'package:donornearme/screens/checkrequest/Body.dart';
import 'package:donornearme/screens/checkrequest/navBarCheckReq.dart';
import 'package:flutter/material.dart';
import 'package:donornearme/models/BloodRequestListModel/GetBloodRequestListRequest.dart';
import 'package:donornearme/screens/checkrequest/GetBloodRequestService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckRequest extends StatefulWidget {
  static String route = '/bloodrequests';

  @override
  _CheckRequestState createState() => _CheckRequestState();
}

class _CheckRequestState extends State<CheckRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        child: Stack(
          children: [
            Column(
              children: [_getNavBar(context), Expanded(child: Body())],
            ),
          ],
        ),
      ),
    );
  }

  Widget _getNavBar(BuildContext context) {
    return Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.redAccent,
          border: Border.all(color: Colors.black),
        ),
        child: NavBarCheckReq());
  }
}
