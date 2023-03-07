import '../constat/const.dart';

class AnnouncementIDModel {
  late bool hasError;
  late List errors = [];
  late News data;

  AnnouncementIDModel.fromJson(Map<String, dynamic> json){
    hasError = json['hasError'];
    errors = json['errors'];
    data = News.fromJson(json['data']['results']);
  }
}

class News{

  late String ID;
  late String hrannouncement_name;
  late String hrannouncement_description;
  late String hrannouncement_pic;
  late String hrannouncement_time;
  late String hrannouncement_date;

  News.fromJson(Map<String,dynamic> json){
  ID= json['HRANNOUNCEMENTID']??'' ;
  hrannouncement_name = json['hrannouncement_name']??'' ;
  hrannouncement_description = json['hrannouncement_description']??'';
  hrannouncement_pic = json['hrannouncement_pic']??'';
  hrannouncement_time = formatTime(int.parse(json['hrannouncement_time']??'0'));
  hrannouncement_date= json['hrannouncement_date']??'';

  }

  }