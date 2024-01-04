part of 'jobs_bloc.dart';

@immutable
abstract class JobsEvent {}

final class GetJobs extends JobsEvent {
  int page = 1;
  int limit = 10;
}

final class DeleteJobs extends JobsEvent {
  final String id;

  DeleteJobs({required this.id});
}
