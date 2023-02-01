import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login_nodejs/config.dart';
import 'package:login_nodejs/models/login_request_model.dart';
import 'package:login_nodejs/models/register_response_model.dart';
import 'package:login_nodejs/services/shared_service.dart';
import '../models/login_response_model.dart';
import '../models/register_request_model.dart';

class ApiService {
  static var client = http.Client();

  //For logging in the user.
  static Future<bool> login(LoginRequestModel model) async {
    Map<String, String> requestHeaders = {'Content-type': 'application/json'};

    var url = Uri.http(Config.apiUrl, Config.loginApi);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      await SharedService.setLoginDetails(
        loginResponseModel(response.body),
      );
      return true;
    } else {
      return false;
    }
  }

  //For Registering the user
  static Future<RegisterResponseModel> register(
      RegisterRequestModel model) async {
    Map<String, String> requestHeaders = {'Content-type': 'application/json'};

    var url = Uri.http(Config.apiUrl, Config.registerApi);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    return registerResponseModel(response.body);
  }

  //For getting the loggedIn user information
  static Future<String> getUserProfile() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data?.token}'
    };

    var url = Uri.http(Config.apiUrl, Config.userProfileApi);

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return '';
    }
  }
}
