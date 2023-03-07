class NotificationModel {
  bool? hasError;
  List<dynamic>? errors;
  List<dynamic>? messages;
  Data? data;

  NotificationModel({this.hasError, this.errors, this.messages, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    hasError = json['hasError'];
    data = json['data'] != null && hasError == false? new Data.fromJson(json['data']) : null;
  }

}

class Data {
  String? tokenReceived;
  String? resultsTotal;
  List<Results>? results;
  int? pageCurrent;
  int? pagePrev;
  int? pageNext;
  int? pageMax;



  Data.fromJson(Map<String, dynamic> json) {
    tokenReceived = json['tokenReceived'];
    resultsTotal = json['resultsTotal'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
    pageCurrent = json['pageCurrent'];
    pagePrev = json['pagePrev'];
    pageNext = json['pageNext'];
    pageMax = json['pageMax'];
  }


}

class Results {
  String? nOTIFICATIONID;
  String? hREMPLOYEEID;
  String? notificationDate;
  String? notificationTime;
  String? notificationRead;
  String? notificationMsg;
  String? notificationMsgAr;
  String? notificationLabel;
  String? notificationIcon;
  String? notificationAction;
  String? notificationActionid;
  String? bRANCHID;
  String? hRDEPARTMENTID;
  String? hRATTDEVICEID;
  String? hremployeeUserid;
  String? hremployeeFullname;
  String? hremployeeNationalid;
  String? hremployeePosition;
  String? hremployeeBirthdate;
  String? hremployeeBankNum;
  String? hremployeeEmail;
  String? hremployeePhone;
  String? hremployeeStatus;
  String? hremployeeSalary;
  String? hremployeeAdvances;
  String? hremployeeCommissions;
  String? hremployeeCustodiesCash;
  String? hremployeeCustodiesOther;
  String? hremployeePenaltiesCash;
  String? hremployeePenaltiesDays;
  String? hremployeeBonusesCash;
  String? hremployeeBonusesDays;
  String? hremployeeAttendid;
  String? hremployeeType;
  String? hremployeeSubcontract;
  String? hremployeeRegularHours;
  String? hremployeeOvertimeHoursRate;
  String? hremployeeRegularAttendTime;
  String? hremployeeRegularLeaveTime;
  String? hremployeeAllowanceHousing;
  String? hremployeeAllowanceTransport;
  String? hremployeeAllowanceCommunications;
  String? hremployeeAllowances;
  String? hremployeeDaySalaryCalcMode;
  String? hremployeeAccesstoken;
  String? hremployeeAccesstokenTime;
  String? hremployeeAccesstokenConnected;
  String? hremployeeQrHash;
  String? hremployeeQrTime;
  String? hremployeeQrFilename;



  Results.fromJson(Map<String, dynamic> json) {
    nOTIFICATIONID = json['NOTIFICATIONID'];
    hREMPLOYEEID = json['HREMPLOYEEID'];
    notificationDate = json['notification_date'];
    notificationTime = json['notification_time'];
    notificationRead = json['notification_read'];
    notificationMsg = json['notification_msg'];
    notificationMsgAr = json['notification_msg_ar'];
    notificationLabel = json['notification_label'];
    notificationIcon = json['notification_icon'];
    notificationAction = json['notification_action'];
    notificationActionid = json['notification_actionid'];
    bRANCHID = json['BRANCHID'];
    hRDEPARTMENTID = json['HRDEPARTMENTID'];
    hRATTDEVICEID = json['HRATTDEVICEID'];
    hremployeeUserid = json['hremployee_userid'];
    hremployeeFullname = json['hremployee_fullname'];
    hremployeeNationalid = json['hremployee_nationalid'];
    hremployeePosition = json['hremployee_position'];
    hremployeeBirthdate = json['hremployee_birthdate'];
    hremployeeBankNum = json['hremployee_bank_num'];
    hremployeeEmail = json['hremployee_email'];
    hremployeePhone = json['hremployee_phone'];
    hremployeeStatus = json['hremployee_status'];
    hremployeeSalary = json['hremployee_salary'];
    hremployeeAdvances = json['hremployee_advances'];
    hremployeeCommissions = json['hremployee_commissions'];
    hremployeeCustodiesCash = json['hremployee_custodies_cash'];
    hremployeeCustodiesOther = json['hremployee_custodies_other'];
    hremployeePenaltiesCash = json['hremployee_penalties_cash'];
    hremployeePenaltiesDays = json['hremployee_penalties_days'];
    hremployeeBonusesCash = json['hremployee_bonuses_cash'];
    hremployeeBonusesDays = json['hremployee_bonuses_days'];
    hremployeeAttendid = json['hremployee_attendid'];
    hremployeeType = json['hremployee_type'];
    hremployeeSubcontract = json['hremployee_subcontract'];
    hremployeeRegularHours = json['hremployee_regular_hours'];
    hremployeeOvertimeHoursRate = json['hremployee_overtime_hours_rate'];
    hremployeeRegularAttendTime = json['hremployee_regular_attend_time'];
    hremployeeRegularLeaveTime = json['hremployee_regular_leave_time'];
    hremployeeAllowanceHousing = json['hremployee_allowance_housing'];
    hremployeeAllowanceTransport = json['hremployee_allowance_transport'];
    hremployeeAllowanceCommunications =
    json['hremployee_allowance_communications'];
    hremployeeAllowances = json['hremployee_allowances'];
    hremployeeDaySalaryCalcMode = json['hremployee_day_salary_calc_mode'];
    hremployeeAccesstoken = json['hremployee_accesstoken'];
    hremployeeAccesstokenTime = json['hremployee_accesstoken_time'];
    hremployeeAccesstokenConnected = json['hremployee_accesstoken_connected'];
    hremployeeQrHash = json['hremployee_qr_hash'];
    hremployeeQrTime = json['hremployee_qr_time'];
    hremployeeQrFilename = json['hremployee_qr_filename'];
  }


}