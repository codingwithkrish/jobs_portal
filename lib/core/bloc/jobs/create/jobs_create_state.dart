part of 'jobs_create_bloc.dart';

@immutable
abstract class JobsCreateState {}

class JobsCreateInitial extends JobsCreateState {}
class CreateJobsLoading extends JobsCreateState{}
class JobsCreatedSuccess extends JobsCreateState{
  final Job job;

  JobsCreatedSuccess({required this.job});
}
class JobsCreatedFailure extends JobsCreateState{}