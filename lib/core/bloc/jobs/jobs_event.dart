part of 'jobs_bloc.dart';

@immutable
abstract class JobsEvent {}
final class GetJobs extends JobsEvent{
int page = 1;
int limit = 10;
}