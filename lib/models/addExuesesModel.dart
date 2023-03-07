import 'package:qr_application/models/userModel.dart';

class AddExcusesModel {

  late bool hasError;
  late List<dynamic> errors;
  late List<dynamic> messages;


  AddExcusesModel.fromJson(Map<String,dynamic> json){
    hasError = json["hasError"]??'';
    errors = json["errors"]??'';
    messages = json["messages"]??'';
  }

}