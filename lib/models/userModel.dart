class UserData {

  late bool hasError;
  late List<dynamic> errors;
  late List<dynamic> messages;
  late UserModel? data;

  UserData.fromJson(Map<String,dynamic> json){
    hasError = json["hasError"];
    errors = json["errors"];
    messages = json["messages"];
    if (json["data"] is Map)
    data = UserModel.fromJson(json["data"]["results"]??{});
    else
      data = null;

  }

}


class UserModel {
  late String HREMPLOYEEID;
  late String  hremployee_fullname;
  late String  hremployee_nationalid;
  late String  hremployee_email;
  late String hremployee_phone;
  late String hremployee_accesstoken;
  late int hremployee_excuses_approve_admin;
  late int hremployee_excuses_approve_hr;
  late int hremployee_excuses_approve_manager;
  late String new_hr_employees_notifications_count;
  late String hremployee_firebase_accesstoken;
  bool show = false;

  UserModel.fromJson(Map<String,dynamic> json){

    HREMPLOYEEID = json['HREMPLOYEEID']??'';
    hremployee_fullname =json['hremployee_fullname']??'';
    hremployee_nationalid = json['hremployee_nationalid']??'';
    hremployee_email = json['hremployee_email']??'';
    hremployee_phone = json['hremployee_phone']??'';
    hremployee_accesstoken =  json['hremployee_accesstoken']??'';
    hremployee_excuses_approve_admin = json['hremployee_excuses_approve_admin']??0;
    hremployee_excuses_approve_hr = json['hremployee_excuses_approve_hr']??0;
    hremployee_excuses_approve_manager = json['hremployee_excuses_approve_manager']??0;
    new_hr_employees_notifications_count = json['new_hr_employees_notifications_count']??'0';
    hremployee_firebase_accesstoken = json['hremployee_firebase_accesstoken']??'';


    if(hremployee_excuses_approve_manager == 1 || hremployee_excuses_approve_hr ==1 ){
      show = true;
      print('adimn: ${show}');
      print('notification: ${new_hr_employees_notifications_count}');
    }

  }

}

