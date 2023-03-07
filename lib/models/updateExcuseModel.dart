class UpdateExcuse {
  bool? hasError;
  List<dynamic>? errors;
  List<dynamic>? messages;
  Data? data;

  UpdateExcuse.fromJson(Map<String, dynamic> json) {
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
  int? hREXCUSEID;


  Results.fromJson(Map<String, dynamic> json) {
    hREXCUSEID = json['HREXCUSEID'];
  }


}