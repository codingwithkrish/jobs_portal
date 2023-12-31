part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class AuthSuccess extends AuthState{
  final AuthRegisterModel authRegisterModel;
  AuthSuccess({required this.authRegisterModel});
}
class AuthFailure extends AuthState{}
class AuthLoading extends AuthState{

}
class AuthSuccessLogin extends AuthState{
final LoginModel loginModel;
AuthSuccessLogin({required this.loginModel});
}