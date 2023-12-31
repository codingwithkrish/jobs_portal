/*
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = JobsModel.fromJson(map);
*/
class Job {
  String? id;
  String? company;
  String? position;
  String? status;
  String? workType;
  String? location;
  String? createdBy;
  int? v;

  Job({this.id, this.company, this.position, this.status, this.workType, this.location, this.createdBy, this.v});

  Job.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    company = json['company'];
    position = json['position'];
    status = json['status'];
    workType = json['workType'];
    location = json['location'];
    createdBy = json['createdBy'];
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = id;
    data['company'] = company;
    data['position'] = position;
    data['status'] = status;
    data['workType'] = workType;
    data['location'] = location;
    data['createdBy'] = createdBy;
    data['__v'] = v;
    return data;
  }
}

class JobsModel {
  int? totalJobs;
  List<Job?>? jobs;
  int? numOfPage;

  JobsModel({this.totalJobs, this.jobs, this.numOfPage});

  JobsModel.fromJson(Map<String, dynamic> json) {
    totalJobs = json['totalJobs'];
    if (json['jobs'] != null) {
      jobs = <Job>[];
      json['jobs'].forEach((v) {
        jobs!.add(Job.fromJson(v));
      });
    }
    numOfPage = json['numOfPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['totalJobs'] = totalJobs;
    data['jobs'] =jobs != null ? jobs!.map((v) => v?.toJson()).toList() : null;
    data['numOfPage'] = numOfPage;
    return data;
  }
}

