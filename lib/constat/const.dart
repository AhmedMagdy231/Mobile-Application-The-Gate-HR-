import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum TypeOfToast{Success,Error,Warning}
dynamic kToken;
const kColor = Color(0xff253450);
const kFont1 = 'Oswald';
const kFont2 = 'Oswaldd';
const kFont3 = 'Oswaldddd';
const kFont4 = 'Oswalddd';
const kFontMain = 'Shippor';
const kColor2 = Color(0xff3756FF);

String kName='';
String? kTokenFcm = '';




String formatTime (timeStamp) {

  var TimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp);
  return DateFormat('hh:mm a').format(TimeStamp).toString();
}

String getStatusId({required status}){
  switch(status) {
    case 'Pending Approval': {
      return '1';
    }
    case 'Approval': {
      return '2';
    }
    case 'Declined': {
      return '0';
    }
    case 'Approved': {
      return '2';
    }
    case 'Pending Department Approval': {
      return '1';
    }
    case 'Pending HR Approval': {
      return '1';
    }
  }

  return '';
}
