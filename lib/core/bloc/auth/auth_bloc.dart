import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:jobs_portal/presentation/constansts/app_utils.dart';
import 'package:meta/meta.dart';

import '../../../model/aut_register.dart';
import '../../../model/login_model.dart';
import '../../services/authentication/auth_services.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthRegister>(_registerUser);
    on<AuthLogin>(_loginUser);
  }
  void _registerUser(AuthRegister event,Emitter<AuthState> emit)async{
    emit(AuthLoading());
    var result =await AuthServices().registerUser(event.name, event.email, event.password);
    if(result!=null){

      AuthRegisterModel authRegister =  AuthRegisterModel.fromJson(jsonDecode(result));

      emit(AuthSuccess(authRegisterModel: authRegister));

    }else{
      emit(AuthFailure());
    }
  }
  void _loginUser(AuthLogin event,Emitter<AuthState> emit)async{
    emit(AuthLoading());
    var result =await AuthServices().loginUser(event.email,event.password);
    if(result!=null){
      LoginModel loginModel = LoginModel.fromJson(jsonDecode(result));
      emit(AuthSuccessLogin(loginModel: loginModel));
    }else{
      emit(AuthFailure());
    }
  }
}
