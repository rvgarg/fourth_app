import 'dart:convert';

import 'package:fourth_app/user.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<User?> login([var email, var pwd]) async {
    print(email);
    email ??= "anupam.verma@mail.vinove.com";
    pwd ??= "Ravi@1234";
    print(pwd);

    var json = <dynamic, dynamic>{
      "email": email,
      "password": pwd,
      "deviceId": '56545',
      "deviceType": "trty",
      "osVersion": "dfwer",
      "lat": "ww",
      "lng": "qeq56"
    };
    var response = await http.post(
        Uri.parse('http://sabarni.n1.iworklab.com/api/auth/login'),
        body: json,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Accept": "application/json",
          "Access-Control-Allow-Credentials": 'true',
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS",
          "Access-Control_Allow_Origin": "*"
        });
    if (response.body != '') {
      print(response.body);
      Map<dynamic, dynamic> map = jsonDecode(response.body);
      return User.fromJson(map);
    } else {
      throw Exception('Failed login');
    }
  }
}
