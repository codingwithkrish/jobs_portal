/*
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = AuthRegister.fromJson(map);
*/
import 'dart:convert';
import 'dart:developer';

class AuthRegisterModel {
  bool? success;
  String? message;
  User? user;
  String? token;

  AuthRegisterModel({this.success, this.message, this.user, this.token});

  AuthRegisterModel.fromString(String response){

    AuthRegisterModel.fromJson(jsonDecode(response));
  }
  AuthRegisterModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    user = json['user'] != null ? User?.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    data['message'] = message;
    data['user'] = user!.toJson();
    data['token'] = token;
    return data;
  }
}

class User {
  String? name;
  String? email;
  String? location;

  User({this.name, this.email, this.location});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['email'] = email;
    data['location'] = location;
    return data;
  }
}

