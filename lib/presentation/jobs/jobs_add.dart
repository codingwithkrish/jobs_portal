import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobs_portal/core/bloc/jobs/jobs_bloc.dart';

import '../../core/bloc/jobs/create/jobs_create_bloc.dart';
import '../constansts/app_colors.dart';
import '../constansts/app_dialogs.dart';
import 'jobs_widget.dart';

class JobsAdd extends StatelessWidget {
  final JobsCreateBloc _jobsCreateBloc;
  TextEditingController textEditingControllerCompanyName =
      TextEditingController();
  TextEditingController textEditingControllerCompanyPosition =
      TextEditingController();
  TextEditingController textEditingControllerCompanyLocation =
      TextEditingController();

  JobsAdd({super.key}) : _jobsCreateBloc = JobsCreateBloc() {
    _jobsCreateBloc.setDropdown("full-time");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: ()async{
          _jobsCreateBloc.close();
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
                          stream: _jobsCreateBloc.outDropdown,
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
                              items: _jobsCreateBloc.dropdownNames
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
                                _jobsCreateBloc.setDropdown(value!);
                              },
                            );
                          }),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: BlocConsumer<JobsCreateBloc, JobsCreateState>(
                    bloc: _jobsCreateBloc,
                    listener: (context, state) {
                      // TODO: implement listener
                      if(state is JobsCreatedSuccess){
                        _jobsCreateBloc.close();
                        Get.back();
                      }
                    },
                    builder: (context, state) {
                      if(state is JobsCreatedSuccess){
                        return const Center(child: Text('Job Created Successfully.'));
                      }
                      if(state is CreateJobsLoading){
                        return const Center(child: CircularProgressIndicator(),);
                      }

                      return buttonCreateJobs('Create Jobs', context, () {
                        if (textEditingControllerCompanyName.text.isNotEmpty &&
                            textEditingControllerCompanyPosition
                                .text.isNotEmpty &&
                            textEditingControllerCompanyLocation
                                .text.isNotEmpty) {
                          _jobsCreateBloc.add(CreateJobs(
                              companyName: textEditingControllerCompanyName.text,
                              positionName:
                                  textEditingControllerCompanyPosition.text,
                              locationName:
                                  textEditingControllerCompanyLocation.text));
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
          "Crate Jobs",
          style: TextStyle(
              color: AppColors.blackColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
