import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobs_portal/core/helper/shared_value.dart';

import '../../core/bloc/auth/auth_bloc.dart';
import '../constansts/app_colors.dart';
import '../constansts/app_dialogs.dart';
import '../constansts/app_utils.dart';
import '../jobs/jobs_home.dart';
import 'auth_widgets.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              animationJob(),
              textWelcome(),
              textGetJob(),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        textFormField("Email", _emailController, false),
                        textFormField("Password", _passwordController, true),
                      ],
                    )),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.h),
                child: BlocConsumer<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                    if (state is AuthSuccessLogin) {

                      return Center(child: Text(state.loginModel.message!));
                    }
                    return buttonAuth("LogIn...", context, () {
                      if (_emailController.text.isEmpty ||
                          _passwordController.text.isEmpty) {
                        AppDialogs().errorDialog(
                            "Please Fill All The Details", context);
                        return;
                      } else if (!_emailController.text.contains("@")) {
                        AppDialogs()
                            .errorDialog("Please Enter Correct Email", context);
                        return;
                      }
                      context.read<AuthBloc>().add(AuthLogin(
                            _emailController.text,
                            _passwordController.text,
                          ));
                    });
                  }, listener: (BuildContext context, AuthState state) {
                    if(state is AuthSuccessLogin){
                      SharedValue().updateToken(state.loginModel.token!);
                      AppUtils().showAlertDialog("Success", state.loginModel.message!);
                    print(state.loginModel.message!);
                      Get.offAll(()=>JobsHome());

                    }
                },
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("Don't Have Account? SignUp Here",
                    style: TextStyle(
                        color: AppColors.purpleColor, fontSize: 13.sp)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
