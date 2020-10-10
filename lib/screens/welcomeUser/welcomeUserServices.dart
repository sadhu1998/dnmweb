import 'dart:convert';

import 'package:donornearme/constants/Common.dart';
import 'package:donornearme/models/DonorListScreenModel/GetAvailableDonorsListRequest.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class WelcomeUserServices{
  Future<Map<String, dynamic>> getAvailableDonors(
      GetAvailableDonorsListRequest getAvailableDonorsListRequest) async {
    var response = await http.get(Common.apiEndPoint +
        '/getdonors/available?country=' +
        getAvailableDonorsListRequest.country +
        '&state=' +
        getAvailableDonorsListRequest.state +
        '&district=' +
        getAvailableDonorsListRequest.district +
        '&city=' +
        getAvailableDonorsListRequest.city +
        '&bloodgroup=' +
        getAvailableDonorsListRequest.bloodGroup +
        '&town=' +
        getAvailableDonorsListRequest.town);
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }
}