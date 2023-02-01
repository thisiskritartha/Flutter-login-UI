import 'dart:convert';

LoginResponseModel loginResponseModel(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  String? message;
  Data? data;

  LoginResponseModel({this.message, this.data});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? username;
  String? email;
  String? password;
  String? date;
  String? id;
  String? token;

  Data(
      {this.username,
      this.email,
      this.password,
      this.date,
      this.id,
      this.token});

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    password = json['password'];
    date = json['date'];
    id = json['id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['username'] = username;
    data['email'] = email;
    data['password'] = password;
    data['date'] = date;
    data['id'] = id;
    data['token'] = token;
    return data;
  }
}
