import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:jobs_portal/core/services/jobs/jobs_services.dart';
import 'package:jobs_portal/model/jobs_model.dart';
import 'package:meta/meta.dart';

part 'jobs_event.dart';
part 'jobs_state.dart';

class JobsBloc extends Bloc<JobsEvent, JobsState> {
  JobsBloc() : super(JobsInitial()) {
    on<GetJobs>(_getJobs);
  }

  FutureOr<void> _getJobs(GetJobs event, Emitter<JobsState> emit) async{
    event.scrollController.addListener(() async {
      if(event.scrollController.position.maxScrollExtent==event.scrollController.offset){
        emit(JobsLoading());

        var result =await JobServices().getJobs(event.page,event.limit);
        if(result!=null){
          JobsModel jobsModel = JobsModel.fromJson(jsonDecode(result));

          emit(JobsGetSuccess(jobsModel: jobsModel));
        }else{
          emit(JobsGetFailure());
        }
      }
    });



  }
}
