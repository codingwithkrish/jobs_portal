part of 'jobs_bloc.dart';

@immutable
abstract class JobsEvent {}
final class GetJobs extends JobsEvent{
final ScrollController scrollController ;
int page = 1;
int limit = 10;

GetJobs({required this.scrollController});

}