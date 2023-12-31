import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jobs_portal/core/services/request.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  String auth = dotenv.env['AUTH']!;
  String register = dotenv.env['REGISTER']!;
  String login = dotenv.env['LOGIN']!;
  dynamic registerUser(String name, String email, String password) async {
    try {
      var body = {"name": name, "email": email, "password": password};
      http.Response response = await Request().postData(auth + register, body);

      return response.body;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  dynamic loginUser(String email,String password)async{
    try{
      var body = {"email":email,"password":password};
      http.Response response = await Request().postData(auth+login, body);
      return response.body;
    }catch (e){
      log(e.toString());
      return null;
    }
  }
}
