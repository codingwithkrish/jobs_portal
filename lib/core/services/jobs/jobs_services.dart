import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:jobs_portal/core/services/request.dart';
class JobServices{
  final String _jobs = dotenv.env['GET_JOBS']!;
  final String _createJobs = dotenv.env['CREATE_JOBS']!;
  final String _deleteJobs = dotenv.env['DELETE_JOBS']!;
  dynamic getJobs(int page,int limit)async{
    try{
    http.Response response = await Request().getData('$_jobs?page=$page&limit=$limit');
    return response.body;
    }catch(e){
      log(e.toString());
      return null;
    }
  }
  dynamic createJobs(String companyName,String positionName,String locationName,String workType)async{
   var body={
     "company": companyName,
     "position":positionName,
     "location":locationName,
     "workType":workType
   };
    try{
      http.Response response = await Request().postData('$_jobs$_createJobs',body);
      return response.body;
    }catch(e){
      log(e.toString());
      return null;
    }
  }
  dynamic deleteJobs(String id)async{
    http.Response response = await Request().deleteData('$_jobs$_deleteJobs/$id');
    return response.body;

  }

}