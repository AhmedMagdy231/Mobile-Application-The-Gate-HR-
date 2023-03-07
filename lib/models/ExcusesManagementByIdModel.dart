class GetExcuseManagementID {
  bool? hasError;
  List<dynamic>? errors;
  List<dynamic>? messages;
  Data? data;



  GetExcuseManagementID.fromJson(Map<String, dynamic> json) {
    hasError = json['hasError'];
    errors = json['errors'];
    messages = json['messages'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

}

class Data {
  String? tokenReceived;
  Results? results;


  Data.fromJson(Map<String, dynamic> json) {
    tokenReceived = json['tokenReceived'];
    results =
    json['results'] != null ? new Results.fromJson(json['results']) : null;
  }

}

class Results {
  String? hREXCUSEID;
  String? hREMPLOYEEID;
  String? hREXCREASONID;
  String? hrexcuseStatus;
  String? hrexcuseDate;
  String? hrexcuseTime;
  String? hrexcuseDuration;
  String? hrexcuseDurationType;
  String? hrexcuseDescription;
  String? hrexcuseDepartmentStatus;
  String? hrexcuseDepartmentStatusUserid;
  String? hrexcuseDepartmentNotes;
  String? hrexcuseHrStatus;
  String? hrexcuseHrStatusUserid;
  String? hrexcuseHrNotes;
  String? hrexcusePositionX;
  String? hrexcusePositionY;
  String? hrexcreasonName;
  String? hrexcreasonNameAr;
  String? hrexcreasonDisplayseq;
  String? hrexcreasonMeeting;
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
  String? hrexcuseStatusString;
  String? hrexcuseDepartmentStatusString;
  String? hrexcuseHrStatusString;
  String? hrexcuseDurationTypeString;


  Results.fromJson(Map<String, dynamic> json) {
    hREXCUSEID = json['HREXCUSEID'];
    hREMPLOYEEID = json['HREMPLOYEEID'];
    hREXCREASONID = json['HREXCREASONID'];
    hrexcuseStatus = json['hrexcuse_status'];
    hrexcuseDate = json['hrexcuse_date'];
    hrexcuseTime = json['hrexcuse_time'];
    hrexcuseDuration = json['hrexcuse_duration'];
    hrexcuseDurationType = json['hrexcuse_duration_type'];
    hrexcuseDescription = json['hrexcuse_description'];
    hrexcuseDepartmentStatus = json['hrexcuse_department_status'];
    hrexcuseDepartmentStatusUserid = json['hrexcuse_department_status_userid'];
    hrexcuseDepartmentNotes = json['hrexcuse_department_notes'];
    hrexcuseHrStatus = json['hrexcuse_hr_status'];
    hrexcuseHrStatusUserid = json['hrexcuse_hr_status_userid'];
    hrexcuseHrNotes = json['hrexcuse_hr_notes'];
    hrexcusePositionX = json['hrexcuse_position_x'];
    hrexcusePositionY = json['hrexcuse_position_y'];
    hrexcreasonName = json['hrexcreason_name'];
    hrexcreasonNameAr = json['hrexcreason_name_ar'];
    hrexcreasonDisplayseq = json['hrexcreason_displayseq'];
    hrexcreasonMeeting = json['hrexcreason_meeting'];
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
    hrexcuseStatusString = json['hrexcuse_status_string'];
    hrexcuseDepartmentStatusString = json['hrexcuse_department_status_string'];
    hrexcuseHrStatusString = json['hrexcuse_hr_status_string'];
    hrexcuseDurationTypeString = json['hrexcuse_duration_type_string'];
  }


}