part of 'jobs_create_bloc.dart';

@immutable
abstract class JobsCreateEvent {}

final class CreateJobs extends JobsCreateEvent {
  final String companyName;
  final String positionName;
  final String locationName;

  CreateJobs(
      {required this.companyName,
      required this.positionName,
      required this.locationName});
}

final class UpdateJobs extends JobsCreateEvent {
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
