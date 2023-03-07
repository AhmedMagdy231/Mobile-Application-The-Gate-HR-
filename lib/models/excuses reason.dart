class DataModelExcuses {

  late bool hasError;
  late List<dynamic> errors;
  late List<dynamic> messages;
  late DataExcuses? data;

  DataModelExcuses.fromJson(Map<String,dynamic> json){
    hasError = json["hasError"];
    errors = json["errors"];
    messages = json["messages"];
    data = DataExcuses.fromJson(json["data"]);
   

  }

}

class DataExcuses {
  late int resultsTotal;
  late List<DataResultExcuses> results=[];
  List<String> listReason=[];
  DataExcuses.fromJson(Map<String, dynamic> json){
    resultsTotal = json['resultsTotal'];
    json['results'].forEach((element) {
      results.add(DataResultExcuses.fromJson(element));
      listReason.add(element['hrexcreason_name']);
    });
  }
}


class DataResultExcuses {
  late int excusesReasonId;
  late String excuses_reason_name;
  late int excusesReasonOrder;
  late int excusesReason_meeting;

  
  DataResultExcuses.fromJson(Map<String,dynamic> json){
    excusesReasonId = int.parse(json['HREXCREASONID']??'0');
    excuses_reason_name = json['hrexcreason_name']??'';
    excusesReasonOrder = int.parse(json['hrexcreason_order']??'0');
    excusesReason_meeting =int.parse(json['hrexcreason_meeting']??'0');
  }
}