import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobs_portal/presentation/constansts/app_colors.dart';
import 'package:lottie/lottie.dart';

Widget textFormField(String label,TextEditingController textEditingController,bool isPass) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5.h),
    child: TextFormField(
      obscureText: isPass,
      controller: textEditingController,
      style: TextStyle(
        color: AppColors.greyColor, // Set the text color here
      ),
      decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.w.h),
          )),
    ),
  );
}
Widget animationJob()=> Lottie.network(
    "https://lottie.host/ac4373c5-01c2-4a4f-b768-291e4769bdf5/03oqfj5Ses.json",
    height: 200.h,
    width: 200.w);
Widget textWelcome()=> Text(
  "Welcome to Job Portal!",
  textAlign: TextAlign.center,
  style:
  TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
);
Widget textGetJob()=>  Text(
  "Get Your Job Easily...",
  textAlign: TextAlign.center,
  style: TextStyle(
      fontSize: 15.sp,
      color: AppColors.greyColor,
      fontWeight: FontWeight.w500),
);
Widget buttonAuth(String text,BuildContext context,VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 15.h),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: AppColors.purpleColor,borderRadius: BorderRadius.circular(10.w.h)),
      child: Text(text,style: TextStyle(color: AppColors.textColorDay,fontSize: 17.sp,fontWeight: FontWeight.w700),),
    ),
  );
}
