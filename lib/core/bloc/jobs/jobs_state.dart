part of 'jobs_bloc.dart';

@immutable
abstract class JobsState {}

class JobsInitial extends JobsState {}
class JobsLoading extends JobsState{
 final List<Job?>? oldJobs;
final bool isFirstFetch;
  JobsLoading(this.oldJobs,{ this.isFirstFetch=false});

}
class JobsGetFailure extends JobsState{}
class JobsGetSuccess extends JobsState{

  final List<Job?>? jobs;
  JobsGetSuccess({required this.jobs});
}

class JobsDeletedSuccess extends JobsState{
final String message;

  JobsDeletedSuccess( {required this.message});
}
class JobsDeletedFailed  extends JobsState{
  final String message;

  JobsDeletedFailed({required this.message});

}