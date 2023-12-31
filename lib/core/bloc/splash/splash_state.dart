part of 'splash_bloc.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState{}
class SplashTokenSuccess extends SplashState{}
class SplashTokenFailure extends SplashState{}