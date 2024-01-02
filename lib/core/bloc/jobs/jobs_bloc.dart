import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:jobs_portal/core/services/jobs/jobs_services.dart';
import 'package:jobs_portal/model/jobs_model.dart';
import 'package:meta/meta.dart';

part 'jobs_event.dart';
part 'jobs_state.dart';

class JobsBloc extends Bloc<JobsEvent, JobsState> {
  int page = 1;
  JobsBloc() : super(JobsInitial()) {
    on<GetJobs>(_getJobs);
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
