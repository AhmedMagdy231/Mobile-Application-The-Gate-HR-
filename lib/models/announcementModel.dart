import 'package:qr_application/constat/const.dart';

class AnnouncementModel{
  late bool hasError;
  late List errors=[];
  late DataModelAnnouncement data;
  
  AnnouncementModel.fromJson(Map<String,dynamic> json){
    hasError = json['hasError'];
    errors = json['errors'];
    data = DataModelAnnouncement.fromJson(json['data']);


  }


}

class DataModelAnnouncement{
  late int resultsTotal;
  late int maxPage;
  late List<News> results=[];
  DataModelAnnouncement.fromJson(Map<String,dynamic> json){


    resultsTotal = json['resultsTotal'];
    maxPage = json['pageMax']??0;
    json['results'].forEach((element){
      results.add(News.fromJson(element));
    });
    
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
    ID= json['HRANNOUNCEMENTID']??'';
    hrannouncement_name = json['hrannouncement_name'] ??'';
    hrannouncement_description = json['hrannouncement_description']??'';
    hrannouncement_pic = json['hrannouncement_pic']??'';
    hrannouncement_time = formatTime(int.parse(json['hrannouncement_time']??'0'));
    hrannouncement_date= json['hrannouncement_date']??'';

  }

}