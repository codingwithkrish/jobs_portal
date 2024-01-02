import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constansts/app_colors.dart';

Widget widgetCreateTextField(String text,String label,TextEditingController textEditingController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        text,
        style: TextStyle(
            color: AppColors.blackColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w400),
      ),
      SizedBox(height: 10.h,),
      TextFormField(

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
      SizedBox(height: 15.h,),
    ],
  );
}

Widget buttonCreateJobs(String text,BuildContext context,VoidCallback onTap) {
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