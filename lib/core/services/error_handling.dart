import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../../presentation/constansts/app_utils.dart';
class ErrorHandling {
  final GlobalKey<NavigatorState> navigatorKey =
       GlobalKey<NavigatorState>();
 dynamic manageErrors(http.Response response) {
    log("Status Code ${response.statusCode}");
    log("Body ${response.body}");

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      print("object");
      return response;
    } else {

      Map<String, dynamic> result = jsonDecode(response.body);
      AppUtils().showAlertDialog("Error", result["message"]);

      return null;
    }
  }
}
