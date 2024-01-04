import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../core/bloc/jobs/create/jobs_create_bloc.dart';
import '../../core/bloc/jobs/jobs_bloc.dart';
import '../constansts/app_colors.dart';
import '../constansts/app_dialogs.dart';
import '../constansts/app_utils.dart';
import 'jobs_widget.dart';

class JobsUpdate extends StatelessWidget {
  final JobsBloc jobsBloc;
  final String workType,status,id;
  TextEditingController textEditingControllerCompanyName;
  TextEditingController textEditingControllerCompanyPosition;
  TextEditingController textEditingControllerCompanyLocation;
   JobsUpdate({super.key,required this.textEditingControllerCompanyName,required this.textEditingControllerCompanyPosition,required this.textEditingControllerCompanyLocation, required this.workType, required this.status,required this.id,required this.jobsBloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: ()async{

          return true;
        },
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10.0.h),
            child: ListView(
              children: [
                widgetCreateTextField("Company Name", "Add Company Name",
                    textEditingControllerCompanyName),
                widgetCreateTextField("Position Name", "Add Position Name",
                    textEditingControllerCompanyPosition),
                widgetCreateTextField("Location of the Job", "Add Location",
                    textEditingControllerCompanyLocation),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Work-Type',
                        style: TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Expanded(
                      child: StreamBuilder(
                          stream: jobsBloc.outDropdown,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) return Container();
                            return DropdownButtonFormField(
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.black, width: 2),
                                    borderRadius: BorderRadius.circular(10.w.h)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.black, width: 2),
                                    borderRadius: BorderRadius.circular(10.w.h)),
                                filled: true,
                                fillColor: AppColors.purpleColor,
                              ),
                              dropdownColor: AppColors.purpleColor,
                              value: snapshot.data,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: jobsBloc.dropdownNames
                                  .map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(
                                    items,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                jobsBloc.setDropdown(value!);
                              },
                            );
                          }),
                    ),
                  ],
                ),
                SizedBox(height: 10.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Status',
                        style: TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Expanded(
                      child: StreamBuilder(
                          stream: jobsBloc.outStatusDropdown,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) return Container();
                            return DropdownButtonFormField(
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.black, width: 2),
                                    borderRadius: BorderRadius.circular(10.w.h)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.black, width: 2),
                                    borderRadius: BorderRadius.circular(10.w.h)),
                                filled: true,
                                fillColor: AppColors.purpleColor,
                              ),
                              dropdownColor: AppColors.purpleColor,
                              value: snapshot.data,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: jobsBloc.statusDropDownNames
                                  .map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(
                                    items,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                jobsBloc.setStatusDropdown(value!);
                              },
                            );
                          }),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: BlocConsumer<JobsBloc, JobsState>(
                    bloc: jobsBloc,
                    listener: (context, state) {
                      // TODO: implement listener
                      if (state is JobsUpdatedSuccess) {
                        AppUtils().showAlertDialog("Update", state.message);
                      }
                      if (state is JobsUpdatedFailure) {
                        AppUtils().showAlertDialog("Error", state.message);
                      }
                    },
                    builder: (context, state) {
                      if(state is JobsUpdatedSuccess){
                        return const Center(child: Text('Job Updated Successfully.'));
                      }
                      if(state is JobsUpdateLoading){
                        return const Center(child: CircularProgressIndicator(),);
                      }

                      return buttonCreateJobs('Update Jobs', context, () {
                        if (textEditingControllerCompanyName.text.isNotEmpty &&
                            textEditingControllerCompanyPosition
                                .text.isNotEmpty &&
                            textEditingControllerCompanyLocation
                                .text.isNotEmpty) {
                          jobsBloc.add(UpdateJobs(
                              companyName: textEditingControllerCompanyName.text,
                              positionName:
                              textEditingControllerCompanyPosition.text,
                              locationName:
                              textEditingControllerCompanyLocation.text, id: id));
                        } else {
                          AppDialogs().errorDialog(
                              "Please Fill All The Details", context);
                        }
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Update Jobs",
          style: TextStyle(
              color: AppColors.blackColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
