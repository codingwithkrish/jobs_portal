
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobs_portal/presentation/auth/sign_in.dart';
import 'package:jobs_portal/presentation/constansts/app_colors.dart';
import 'package:jobs_portal/presentation/constansts/app_dialogs.dart';


import '../../core/bloc/auth/auth_bloc.dart';
import '../../core/helper/shared_value.dart';
import 'auth_widgets.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController _nameController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _confirmPasswordController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                          textFormField("Name", _nameController, false),
                          textFormField("Email", _emailController, false),
                          textFormField("Password", _passwordController, true),
                          textFormField("Confirm Password",
                              _confirmPasswordController, true)
                        ],
                      )),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.h),
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }
                      if (state is AuthSuccess) {
                        SharedValue().updateToken(state.authRegisterModel.token!);

                        return Center(
                            child: Text(state.authRegisterModel.message!));
                      }
                      return buttonAuth("Register...", context, () {
                        if (_nameController.text.isEmpty ||
                            _emailController.text.isEmpty ||
                            _passwordController.text.isEmpty ||
                            _confirmPasswordController.text.isEmpty) {
                          AppDialogs().errorDialog(
                              "Please Fill All The Details", context);
                          return;
                        } else if (!_emailController.text.contains("@")) {
                          AppDialogs().errorDialog(
                              "Please Enter Correct Email", context);
                          return;
                        } else if (_passwordController.text !=
                            _confirmPasswordController.text) {
                          AppDialogs().errorDialog(
                              "Password and Confirm Password Should Be Same",
                              context);
                          return;
                        }
                        context.read<AuthBloc>().add(AuthRegister(
                            _nameController.text,
                            _passwordController.text,
                            _emailController.text));
                      });
                    },
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(() => SignIn());
                  },
                  child: Text("Already Have Account? LogIn Here",
                      style: TextStyle(
                          color: AppColors.purpleColor, fontSize: 13.sp)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
