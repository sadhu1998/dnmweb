import 'dart:convert';
import 'package:donornearme/models/BloodRequestListModel/GetBloodRequestListRequest.dart';
import 'package:donornearme/constants/Common.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetBloodRequestService {
  Future<Map<String, dynamic>> getBloodRequestsList(
      GetBloodRequestListRequest getBloodRequestListRequest) async {
    String baseUrl = Common.apiEndPoint+"/getbloodrequests?mailid="+getBloodRequestListRequest.mailid;
    debugPrint("Hitting EndPoint :" +baseUrl);
    http.Response response = await http.get(baseUrl);
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }
}
