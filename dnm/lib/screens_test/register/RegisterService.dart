import 'dart:convert';
import 'package:dnm/constants/Common.dart';
import 'package:dnm/models/OnOtpVerificationSuccessModel/AddUserRequest.dart';
import 'package:dnm/models/OnOtpVerificationSuccessModel/GetCitiesListRequest.dart';
import 'package:dnm/models/OnOtpVerificationSuccessModel/GetDistrictsListRequest.dart';
import 'package:dnm/models/OnOtpVerificationSuccessModel/GetStatesListRequest.dart';
import 'package:dnm/models/OnOtpVerificationSuccessModel/GetTownsListRequest.dart';

import 'package:http/http.dart' as http;

class DonorRequestScreenService {
  Future<Map<String, dynamic>> getStatesList(
      GetStatesListRequest getStatesListRequest) async {
    var response = await http.get(Common.apiEndPoint +
        '/areas/list/states?country=' +
        getStatesListRequest.country);
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }

  Future<Map<String, dynamic>> getDistrictsList(
      GetDistrictsListRequest getDistrictsListRequest) async {
    var response = await http.get(Common.apiEndPoint +
        '/areas/list/districts?state=' +
        getDistrictsListRequest.state);
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }

  Future<Map<String, dynamic>> getCitiesList(
      GetCitiesListRequest getCitiesListRequest) async {
    var response = await http.get(Common.apiEndPoint +
        '/areas/list/cities?district=' +
        getCitiesListRequest.district);
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }

  Future<Map<String, dynamic>> getTownsList(
      GetTownsListRequest getTownsListRequest) async {
    var response = await http.get(Common.apiEndPoint +
        '/areas/list/towns?city=' +
        getTownsListRequest.city);
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }

  Future<Map<String, dynamic>> getBloodGroupsList() async {
    var response = await http.get(Common.apiEndPoint + '/list/bloodgroups');
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }

  Future<Map<String, dynamic>> addUserToDb(AddUserRequest addUserRequest) async {
    http.Response response =
    await http.post('http://35.238.212.200:8080/addUser',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'bloodgroup': addUserRequest.bloodgroup,
          'city': addUserRequest.city,
          'country': addUserRequest.country,
          'district': addUserRequest.district,
          'mail_notification': addUserRequest.mail_notification,
          'mailid': addUserRequest.mailid,
          'password': addUserRequest.password,
          'phonenumber': addUserRequest.phonenumber,
          'pincode': addUserRequest.pincode,
          'sms_notification': addUserRequest.sms_notification,
          'state': addUserRequest.state,
          'town': addUserRequest.town,
          'username': addUserRequest.username,
          'fcmtoken': addUserRequest.fcmtoken
        }));

    print("Add User Response " + response.body);
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }

}
