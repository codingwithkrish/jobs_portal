import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobs_portal/presentation/constansts/app_colors.dart';

import '../../core/bloc/jobs/jobs_bloc.dart';
import 'jobs_add.dart';

class JobsHome extends StatelessWidget {
  final JobsBloc _jobsBloc;
  ScrollController scrollController = ScrollController();


  JobsHome({super.key}) : _jobsBloc = JobsBloc() {
    _jobsBloc.add(GetJobs(scrollController: scrollController));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => JobsAdd());
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: BlocConsumer<JobsBloc, JobsState>(
          bloc: _jobsBloc,
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is JobsLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (state is JobsGetSuccess) {
              return state.jobsModel.totalJobs != 0
                  ? ListView.separated(
                controller: scrollController,
                      itemBuilder: (context, i) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 10.h),
                          decoration: BoxDecoration(
                              color: AppColors.niceColor,
                              borderRadius: BorderRadius.circular(10.w.h)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 10.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.jobsModel.jobs![i]!.position!,
                                style: TextStyle(
                                    color: AppColors.textColorDay,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Company : ' +
                                        state.jobsModel.jobs![i]!.company!,
                                    style: TextStyle(
                                        color: AppColors.textColorDark,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(state.jobsModel.jobs![i]!.location!,
                                      style: TextStyle(
                                          color: AppColors.textColorDark,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500))
                                ],
                              ),
                              Text(
                                  "Status : ${state.jobsModel.jobs![i]!.status}",
                                  style: TextStyle(
                                      color: AppColors.textColorDark,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400)),
                              Text(
                                  "WorkType : ${state.jobsModel.jobs![i]!.workType}",
                                  style: TextStyle(
                                      color: AppColors.textColorDark,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400))
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, i) {
                        return SizedBox.shrink();
                      },
                      itemCount: state.jobsModel.totalJobs!)
                  : Center(
                      child: Text("Oppss No Job Found , Add New Jobs"),
                    );
            }
            if (state is JobsGetFailure) {
              return Center(
                child: Text(
                    "Unable To Fetch Data , Please Retry After Some Time or Add New Jobs"),
              );
            }
            return Text("data");
          },
        ),
      ),
    );
  }
}
