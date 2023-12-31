import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../helper/shared_value.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashCheckToken>(_checkSplash);
  }
   void _checkSplash(SplashCheckToken event,Emitter<SplashState> emit)async{
    emit(SplashLoading());
   await Future.delayed(Duration(seconds: 3));

      String token = SharedValue().getToken()!;
      log(token);
      if(token!=''){
        log("I am insidw");
        emit(SplashTokenSuccess());
      }else{
        emit(SplashTokenFailure());
      }

  }
}
