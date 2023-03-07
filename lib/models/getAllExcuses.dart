import 'package:qr_application/cubit/cubit.dart';

class DataModelAllExcuses {
  late bool hasError;
  late List<dynamic> errors;
  late List<dynamic> messages;
  late DataExcuses? data;

  DataModelAllExcuses.fromJson(Map<String, dynamic> json) {
    hasError = json["hasError"];
    errors = json["errors"];
    messages = json["messages"];
    data = DataExcuses.fromJson(json["data"]);
  }
}

class DataExcuses {
  late int resultsTotal;
  late List<AllDataExcuses> results = [];

  List<String> listReason = [];
  late int maxPage;

  DataExcuses.fromJson(Map<String, dynamic> json) {
    resultsTotal = int.parse(json['resultsTotal']);
    maxPage = json['pageMax'];
    json['results'].forEach((element) {
      results.add(AllDataExcuses.fromJson(element));
    });



  }
}

class AllDataExcuses {
  late String HREXCUSEID;//
  late String hrexcuse_date;//
  late String hrexcuse_time;//
  late String hrexcuse_duration;//
  late String hrexcuse_description;
  late String hrexcuse_department_notes;
  late String hrexcuse_hr_notes;
  late String hrexcreason_name;//
  late String hrexcuse_status_string;//
  late String hrexcuse_department_status_string;
  late String hrexcuse_hr_status_string;
  late String hrexcuse_duration_type_string;//

  AllDataExcuses.fromJson(Map<String, dynamic> json) {
    HREXCUSEID = json['HREXCUSEID']??'';
    hrexcuse_date = json['hrexcuse_date']??'';
    hrexcuse_time = json['hrexcuse_time']??'';
    hrexcuse_duration = json['hrexcuse_duration']??'';
    hrexcuse_description = json['hrexcuse_description']??'';
    hrexcuse_department_notes = json['hrexcuse_department_notes']??'';
    hrexcuse_hr_notes = json['hrexcuse_hr_notes']??'';
    hrexcreason_name = json['hrexcreason_name']??'';
    hrexcuse_status_string = json['hrexcuse_status_string']??'';
    hrexcuse_department_status_string = json['hrexcuse_department_status_string']??'';
    hrexcuse_hr_status_string = json['hrexcuse_hr_status_string']??'';
    hrexcuse_duration_type_string = json['hrexcuse_duration_type_string']??'';
  }
}
