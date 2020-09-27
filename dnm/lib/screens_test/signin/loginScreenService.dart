import 'dart:convert';
import 'package:dnm/constants/Common.dart';
import 'package:dnm/models/LoginScreenModel/AuthenticateRequest.dart';
import 'package:http/http.dart' as http;

class LoginScreenService {
  Future<Map<String, dynamic>> authenticate(
      AuthenticateModel authenticateModel) async {
    http.Response response = await http.post(
        Common.apiEndPoint + '/authenticate',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'mailid': authenticateModel.mailid,
          'password': authenticateModel.password
        }));
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }

}
