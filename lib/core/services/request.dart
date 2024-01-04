import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../helper/shared_value.dart';
import 'error_handling.dart';

class Request {
  final _baseUrl = dotenv.env['BASE_URL'];
  final _apiVersion = dotenv.env['VERSION'];
  final _errorHandling = ErrorHandling();
  final Duration _timeOut = Duration(seconds: 60);

  Future<dynamic> postData(
    url,
    body, {
    Map<String, String?>? queryParams,
  }) async {
    log(_baseUrl! + _apiVersion! + url);
    try {
      http.Response response = await http
          .post(Uri.parse(_baseUrl! + _apiVersion! + url),
              headers: await _getHeaders(), body: jsonEncode(body))
          .timeout(_timeOut, onTimeout: () async {
        return await _errorHandling.manageErrors(_timeoutResponse());
      });

      return await _errorHandling.manageErrors(response);
    } catch (err) {
      log(err.toString());
      if (err is SocketException) {
        return await _errorHandling.manageErrors(_timeoutResponse());
      } else {
        return await _errorHandling.manageErrors(_errorResponse());
      }
    }
  }

  Future<dynamic> getData(String url,
      {Map<String, String?>? queryParams}) async {
    log(_baseUrl! + _apiVersion! + url);

    try {
      http.Response response = await http
          .get(Uri.parse(_baseUrl! + _apiVersion! + url),
              headers: await _getHeaders())
          .timeout(_timeOut, onTimeout: () async {
        return await _errorHandling.manageErrors(_timeoutResponse());
      });

      return await _errorHandling.manageErrors(response);
    } catch (err) {
      log(err.toString());
      if (err is SocketException) {
        return await _errorHandling.manageErrors(_timeoutResponse());
      } else {
        return await _errorHandling.manageErrors(_errorResponse());
      }
    }
  }

  Future<dynamic> deleteData(String url,
      {Map<String, String?>? queryParams}) async {
    try {
      http.Response response = await http
          .delete(Uri.parse(_baseUrl! + _apiVersion! + url),
              headers: await _getHeaders())
          .timeout(_timeOut, onTimeout: () async {
        return await _errorHandling.manageErrors(_timeoutResponse());
      });

      return await _errorHandling.manageErrors(response);
    } catch (err) {
      log(err.toString());
      if (err is SocketException) {
        return await _errorHandling.manageErrors(_timeoutResponse());
      } else {
        return await _errorHandling.manageErrors(_errorResponse());
      }
    }
  }

  Future<dynamic> updateData(url,
  body, {
  Map<String, String?>? queryParams,})async{
    log(_baseUrl! + _apiVersion! + url);
    try {
      http.Response response = await http
          .patch(Uri.parse(_baseUrl! + _apiVersion! + url),
          headers: await _getHeaders(), body: jsonEncode(body))
          .timeout(_timeOut, onTimeout: () async {
        return await _errorHandling.manageErrors(_timeoutResponse());
      });

      return await _errorHandling.manageErrors(response);
    } catch (err) {
      log(err.toString());
      if (err is SocketException) {
        return await _errorHandling.manageErrors(_timeoutResponse());
      } else {
        return await _errorHandling.manageErrors(_errorResponse());
      }
    }
  }
  http.Response _timeoutResponse() {
    return http.Response(
      jsonEncode({
        "success": false,
        "message": "Please check your network connection and try again."
      }),
      401,
      headers: {'Content-Type': 'application/json'},
    );
  }

  http.Response _errorResponse() {
    return http.Response(
      jsonEncode(
          {"success": false, "message": "Some Error Occurred At Our End"}),
      401,
      headers: {'Content-Type': 'application/json'},
    );
  }

  Future<Map<String, String>> _getHeaders() async {
    //  SharedPreferences prefs = await SharedPreferences.getInstance();
    // printWrapped(prefs.getString('token') ?? '');

    var token = SharedValue().getToken();
    if (token!.isNotEmpty) {
      return {
        "Content-Type": "application/json",
        'Authorization': "Bearer $token"
      };
    }
    return {"Content-Type": "application/json"};
  }
}
