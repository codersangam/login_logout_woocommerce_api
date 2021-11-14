import 'dart:convert';

LoginResponseModel loginResponseFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  bool? success;
  int? statusCode;
  String? code;
  String? message;
  Data? data;

  LoginResponseModel(
      {this.success, this.code, this.data, this.message, this.statusCode});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    code = json['code'];
    message = json['message'];
    data = json['data'].length > 0 ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['statusCode'] = statusCode;
    data['code'] = code;
    data['message'] = message;

    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? token;
  int? id;
  String? email;
  String? niceName;
  String? firstName;
  String? lastName;
  String? displayName;

  Data(
      {this.displayName,
      this.email,
      this.firstName,
      this.id,
      this.lastName,
      this.niceName,
      this.token});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    email = json['email'];
    displayName = json['displayName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    niceName = json['nicename'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['id'] = id;
    data['email'] = email;
    data['nicename'] = niceName;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['displayName'] = displayName;

    return data;
  }
}
