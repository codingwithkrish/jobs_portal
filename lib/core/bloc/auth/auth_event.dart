part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

final class AuthRegister extends AuthEvent{
  final String name;
  final String email;
  final String password;
  AuthRegister(this.name,this.password,this.email);
}

final class AuthLogin extends AuthEvent{
  final String email;
  final String password;
  AuthLogin(this.email,this.password);
}