part of 'jobs_bloc.dart';

@immutable
abstract class JobsState {}

class JobsInitial extends JobsState {}
class JobsLoading extends JobsState{}
class JobsGetFailure extends JobsState{}
class JobsGetSuccess extends JobsState{
  final JobsModel jobsModel;
  List<Job?>? jobs = [];
  JobsGetSuccess({required this.jobsModel});
}

class JobsNoMore extends JobsState{

}