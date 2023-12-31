import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:jobs_portal/core/services/request.dart';
class JobServices{
  final String _jobs = dotenv.env['GET_JOBS']!;
  dynamic getJobs(int page,int limit)async{
    try{
    http.Response response = await Request().getData('$_jobs?page=$page&limit=$limit');
    return response.body;
    }catch(e){
      log(e.toString());
      return null;
    }
  }

}