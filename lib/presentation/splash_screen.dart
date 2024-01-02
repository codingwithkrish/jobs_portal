import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:jobs_portal/presentation/jobs/jobs_home.dart';

import '../core/bloc/splash/splash_bloc.dart';
import 'auth/auth_widgets.dart';
import 'auth/sign_up.dart';

class SplashScreen extends StatelessWidget {
  final SplashBloc _splashBloc;
   SplashScreen({super.key}) : _splashBloc=SplashBloc(){
     _splashBloc.add(SplashCheckToken());
   }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<SplashBloc, SplashState>(
          bloc: _splashBloc,
          listener: (context, state) {
            // TODO: implement listener
            if(state is SplashTokenSuccess){
              _splashBloc.close();
              Get.offAll(()=>JobsHome());
            }
            if(state is SplashTokenFailure){
              _splashBloc.close();
              Get.offAll(()=>SignUp());
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Center(child: animationJob()), Center(child: textWelcome())],
            );
          },
        ),
      ),
    );
  }
}
