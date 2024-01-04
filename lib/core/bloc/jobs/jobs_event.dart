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

final class UpdateJobs extends JobsEvent {
  final String companyName;
  final String positionName;
  final String locationName;

  final String id;

  UpdateJobs(
      {required this.companyName,
      required this.positionName,
      required this.locationName,
      required this.id});
}
