import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobs_portal/presentation/constansts/app_colors.dart';

import '../../core/bloc/jobs/jobs_bloc.dart';
import '../../model/jobs_model.dart';
import '../constansts/app_utils.dart';
import 'jobs_add.dart';
import 'jobs_update.dart';
import 'jobs_widget.dart';

class JobsHome extends StatelessWidget {
  final JobsBloc _jobsBloc;
  ScrollController scrollController = ScrollController();

  JobsHome({super.key}) : _jobsBloc = JobsBloc() {
    _jobsBloc.add(GetJobs());
  }
  void loadMore() {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          _jobsBloc.add(GetJobs());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    loadMore();
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
            if (state is JobsDeletedSuccess) {
              AppUtils().showAlertDialog("Deleted", state.message);
            }
            if (state is JobsDeletedFailed) {
              AppUtils().showAlertDialog("Error", state.message);
            }
          },
          builder: (context, state) {
            if (state is JobsLoading && state.isFirstFetch) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (state is JobsGetFailure) {
              return Center(
                child: Text(
                  "Unable To Fetch Data , Please Retry After Some Time or Add New Jobs",
                  textAlign: TextAlign.center,
                ),
              );
            }
            List<Job?>? listJobs = <Job>[];
            bool isLoading = false;
            if (state is JobsLoading) {
              listJobs = state.oldJobs;
              isLoading = true;
            }
            if (state is JobsGetSuccess) {
              listJobs = state.jobs;
            }

            return listJobs!.isNotEmpty
                ? ListView.separated(
                    controller: scrollController,
                    itemBuilder: (context, i) {
                      if (i < listJobs!.length) {
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
                                listJobs![i]!.position!,
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
                                    'Company : ' + listJobs[i]!.company!,
                                    style: TextStyle(
                                        color: AppColors.textColorDark,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(listJobs[i]!.location!,
                                      style: TextStyle(
                                          color: AppColors.textColorDark,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500))
                                ],
                              ),
                              Text("Status : ${listJobs[i]!.status}",
                                  style: TextStyle(
                                      color: AppColors.textColorDark,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400)),
                              Text("WorkType : ${listJobs[i]!.workType}",
                                  style: TextStyle(
                                      color: AppColors.textColorDark,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400)),
                              buttonDelete("Update this Job", context, () {
                                Get.to(() => JobsUpdate(
                                      textEditingControllerCompanyName:
                                          TextEditingController(
                                              text: listJobs![i]!.company),
                                      textEditingControllerCompanyPosition:
                                          TextEditingController(
                                              text: listJobs![i]!.position),
                                      textEditingControllerCompanyLocation:
                                          TextEditingController(
                                              text: listJobs![i]!.location),
                                      workType: listJobs![i]!.workType!,
                                      status: listJobs![i]!.status!,
                                      id: listJobs[i]!.id!,
                                      jobsBloc: _jobsBloc,
                                    ));
                              }),
                              SizedBox(
                                height: 10.h,
                              ),
                              buttonDelete("Delete", context, () {
                                _jobsBloc
                                    .add(DeleteJobs(id: listJobs![i]!.id!));
                              })
                            ],
                          ),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                    separatorBuilder: (context, i) {
                      return SizedBox.shrink();
                    },
                    itemCount: listJobs.length + (isLoading ? 1 : 0))
                : Center(
                    child: Text("Oppss No Job Found , Add New Jobs"),
                  );
          },
        ),
      ),
    );
  }
}
