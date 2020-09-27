import 'dart:convert';

import 'package:dnm/models/RegisterScreenModel/SendOtpRequest.dart';
import 'package:dnm/models/RegisterScreenModel/ValidateOtpRequest.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OtpService {
  Future<Map<String, dynamic>> validateOtp(
      ValidateOtpRequest validateOtpRequest) async {
    http.Response response = await http.post(
        'http://35.238.212.200:8080/validateotp',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'mailid': validateOtpRequest.mailid,
          'otp': validateOtpRequest.otp
        }));
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }

  Future<http.Response> sendOtpToUser(SendOtpRequest sendOtpRequest) async {
    http.Response response =
        await http.post('http://35.238.212.200:8080/sendotp',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'mailid': sendOtpRequest.mailid,
            }));
    return response;
  }
}
