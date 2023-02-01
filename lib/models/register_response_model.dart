import 'dart:convert';

RegisterResponseModel registerResponseModel(String str) =>
    RegisterResponseModel.fromJson(json.decode(str));

class RegisterResponseModel {
  String? message;
  Data? data;

  RegisterResponseModel({this.message, this.data});

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? date;
  String? id;

  Data({this.username, this.email, this.date, this.id});

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    date = json['date'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['email'] = email;
    data['date'] = date;
    data['id'] = id;
    return data;
  }
}
