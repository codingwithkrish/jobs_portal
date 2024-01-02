import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:jobs_portal/model/jobs_model.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../../../services/jobs/jobs_services.dart';

part 'jobs_create_event.dart';
part 'jobs_create_state.dart';

class JobsCreateBloc extends Bloc<JobsCreateEvent, JobsCreateState> {
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

  JobsCreateBloc() : super(JobsCreateInitial()) {
    on<CreateJobs>(_createJobs);
  }
  _createJobs(CreateJobs event, Emitter<JobsCreateState> emit) async{
    emit(CreateJobsLoading());
    var result = await  JobServices().createJobs(event.companyName, event.positionName, event.locationName, _dropdownValue.value);
    if(result!=null){
      Job job = Job.fromJson(jsonDecode(result)['job']);
      emit(JobsCreatedSuccess(job: job));
    }else{
      emit(JobsCreatedFailure());
    }
  }
}
