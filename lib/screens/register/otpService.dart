import 'dart:convert';
import 'package:donornearme/constants/Common.dart';
import 'package:donornearme/models/RegisterScreenModel/SendOtpRequest.dart';
import 'package:donornearme/models/RegisterScreenModel/ValidateOtpRequest.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OtpService {
  Future<Map<String, dynamic>> validateOtp(
      ValidateOtpRequest validateOtpRequest) async {
    http.Response response = await http.post(
        Common.apiEndPoint+ '/validateotp',
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
        await http.post(Common.apiEndPoint + '/sendotp',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'mailid': sendOtpRequest.mailid,
            }));
    return response;
  }
}
