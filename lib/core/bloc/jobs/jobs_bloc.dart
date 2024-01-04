import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:jobs_portal/core/services/jobs/jobs_services.dart';
import 'package:jobs_portal/model/jobs_model.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';


part 'jobs_event.dart';
part 'jobs_state.dart';

class JobsBloc extends Bloc<JobsEvent, JobsState> {
  int page = 1;
  List<String> statusDropDownNames=['pending', 'reject', 'interview'];
  final _dropdownStatusNames = BehaviorSubject<String>.seeded("pending");
  Stream<String> get outStatusDropdown=>_dropdownStatusNames.stream;
  Function(String) get inStatusDropdown=>_dropdownStatusNames.sink.add;
  String get getStatusDropdown =>_dropdownStatusNames.value;
  void setStatusDropdown(String name){
    _dropdownStatusNames.value = name;
  }
  List<String> dropdownNames = [
    'full-time',
    'part-time',
    'internship',
    'contract'
  ];

  final _dropdownValue = BehaviorSubject<String>.seeded("full-time");
  Stream<String> get outDropdown => _dropdownValue.stream;
  Function(String) get inDropdown => _dropdownValue.sink.add;
  String get getDropdown => _dropdownValue.value;
  void setDropdown(String name) {
    _dropdownValue.value = name;
  }
  JobsBloc() : super(JobsInitial()) {
    on<GetJobs>(_getJobs);
    on<DeleteJobs>(_deleteJobs);
    on<UpdateJobs>(_updateJob);
  }

  _updateJob(UpdateJobs event,Emitter<JobsState> emit)async{
    if(state is JobsLoading ||state is JobsUpdateLoading) return;
    final currentState = state;
    List<Job?> oldJobs = <Job>[];
    if(currentState is JobsGetSuccess){
      oldJobs = currentState.jobs!;
    }
emit(JobsUpdateLoading());
    var body ={
      "company": event.companyName,
      "position": event.positionName,
      "status": _dropdownStatusNames.value,
      "workType": _dropdownValue.value,
      "location":event.locationName


    };

    var result = await JobServices().updateJobs(event.id, body);
    if(result!=null){
      for(int i = 0;i<oldJobs.length;i++){
        if(oldJobs[i]!.id== event.id){
          Job? newJob = Job.fromJson(jsonDecode(result)["updateJob"]);
          oldJobs[i]=newJob;

          emit(JobsUpdatedSuccess(message: "Updated The Job"));
          await Future.delayed(Duration(seconds: 1));
          emit(JobsGetSuccess(jobs: oldJobs));

          return;

        }
      }

    }else{

      emit(JobsUpdatedFailure(message: "Failed To Update"));
      await Future.delayed(Duration(seconds: 1));
      emit(JobsGetSuccess(jobs: oldJobs));

    }


  }
  void _deleteJobs(DeleteJobs event,Emitter<JobsState> emit)async{
    if(state is JobsLoading) return;
    final currentState = state;
    List<Job?> oldJobs = <Job>[];
    if(currentState is JobsGetSuccess){
      oldJobs = currentState.jobs!;
    }
    emit(JobsLoading(oldJobs,isFirstFetch: true));

    var result = await JobServices().deleteJobs(event.id);
    print(result);
    if(result!=null){
      for(int i = 0;i<oldJobs.length;i++){
        if(oldJobs[i]!.id== event.id){
          oldJobs.removeAt(i);
          emit(JobsDeletedSuccess(message: jsonDecode(result)["message"]));
        }
      }
      await Future.delayed(Duration(seconds: 1));
      emit(JobsGetSuccess(jobs: oldJobs));
    }else{
      
      emit(JobsDeletedFailed(message: "Failed To Delete"));
      await Future.delayed(Duration(seconds: 1));
      emit(JobsGetSuccess(jobs: oldJobs));
    }

  }
  FutureOr<void> _getJobs(GetJobs event, Emitter<JobsState> emit) async {

    if (state is JobsLoading) return;
    final currentState = state;

    List<Job?> oldPost = <Job>[];
    if (currentState is JobsGetSuccess) {
      oldPost = currentState.jobs!;
    }
    emit(JobsLoading(oldPost, isFirstFetch: page == 1));
    var result = await JobServices().getJobs(page, event.limit);
    if (result != null) {
      JobsModel jobsModel = JobsModel.fromJson(jsonDecode(result));
      page++;
      log("Page${page}");
      final jobsNew = (state as JobsLoading).oldJobs;
      jobsNew!.addAll(jobsModel.jobs!);
      emit(JobsGetSuccess(jobs: jobsNew));
    } else {
      emit(JobsGetFailure());
    }
  }
}
