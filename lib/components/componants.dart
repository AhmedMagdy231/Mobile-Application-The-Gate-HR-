import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qr_application/cubit/cubit.dart';
import 'package:qr_application/screens/FirstScreen.dart';
import 'package:qr_application/screens/DeatilsAnnouncement.dart';

import '../constat/const.dart';
import '../models/announcementModel.dart';
import '../screens/AttendenceScreen.dart';
import '../screens/homeLayout.dart';

void navigateTo(context, widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void navigateToToFinish(context, widget) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}

void showDialoog({
  required BuildContext context,
  required int num,
  required String state,
  required widget,
}) {
  AwesomeDialog(
    dismissOnBackKeyPress: false,
    context: context,
    dialogType: num == 1
        ? DialogType.SUCCES
        : num == 0
            ? DialogType.ERROR
            : DialogType.WARNING,
    animType: AnimType.SCALE,
    title: 'Dialog Title',
    body: widget,
    btnOkColor: num==1?Colors.green:num==0?Colors.red:Color(0xffFFB61C),
    btnOkOnPress: () {
      if (num == 1 && state == 'login') {
        navigateToToFinish(context, HomeLayout());
      }
      if (num == 0 && state == 'verifyToken') {
        navigateToToFinish(context, FirstScreen());
      }
      if (num == 1 && state == 'AddExc') {
        Navigator.pop(context);
        QrScannerCubit.get(context).getAllExcusesData(page: 1);
      }
    },
  ).show();
}

class Message extends StatelessWidget {
  final List<dynamic> message;
  var size;

  Message({required this.message, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size * 0.07 * message.length,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => Row(
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      '${message[index]}',
                      style: TextStyle(fontFamily: kFontMain),
                    ),
                  ),
                ],
              ),
          separatorBuilder: (context, index) => SizedBox(
                height: size * 0.01,
              ),
          itemCount: message.length),
    );
  }
}
Widget servesConnection(String message, IconData icon) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        message,
        style: TextStyle(fontFamily: kFontMain),
      ),
      Icon(icon)
    ],
  );
}
class bothWifiLocation extends StatelessWidget {
  const bothWifiLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                    child: Text(
                  'Please Check Your Internet  ',
                  style: TextStyle(fontFamily: kFontMain),
                )),
                Icon(Icons.wifi),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Text(
                  'Please Open Your Location  ',
                  style: TextStyle(fontFamily: kFontMain),
                )),
                Icon(Icons.location_on),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Container buildElevatedButton({
  required double width,
  required double height,
  required String text,
  required VoidCallback fun,
  required IconData icon,
  required Color color,
  Color? colorText,
}) {
  return Container(
    width: width,
    height: height,
    child: ElevatedButton.icon(
      icon: Icon(icon,color: colorText,),
      onPressed: fun,
      label: Text(
        text,
        style: TextStyle(fontFamily: kFontMain, fontWeight: FontWeight.bold,color: colorText),
      ),
      style: ElevatedButton.styleFrom(
        primary: color,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    ),
  );
}


Widget ItemNews({width, news, context}) {
  return GestureDetector(
    onTap: (){
      QrScannerCubit.get(context).getAnnouncementID(id: news.ID);
      navigateTo(context, Details(id: news.ID,));

    },
    child: Padding(
      padding: EdgeInsets.all(width * 0.04),
      child: Row(
        children: [
          Container(
            width: width*0.25,
            height: width*0.25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl:
                news.hrannouncement_pic,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator(color: Colors.white,)),
                errorWidget: (context, url, error) => Icon(
                  Icons.error,
                  color: Colors.red,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              height: width*0.25,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  Text(
                    news.hrannouncement_name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width*0.045,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                      fontFamily: kFontMain
                    ),
                    maxLines: 2,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Row(
                        children: [
                          Icon(
                            Icons.alarm,
                            color: Colors.grey,
                            size: width*0.038,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            news.hrannouncement_time,
                            style: TextStyle(color: Colors.grey,fontSize: width*0.038,fontFamily: kFontMain),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.date_range,
                            color: Colors.grey,
                            size: width*0.038,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            news.hrannouncement_date,
                            style: TextStyle(color: Colors.grey,fontSize: width*0.038,fontFamily: kFont4),
                          ),
                        ],
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}


Column builtItem(
    {required width,
      required String mainText,
      height,
      Color? color,
      Color? colorText,
      required String text,center,required Width,required Height}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        mainText,
        style: TextStyle(
            color:  Colors.white,
            fontFamily: kFontMain,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5),
      ),
      Container(
        width: width,
        height: height,
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color?? color,
          border: Border.all(color: Colors.white, width: 0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Width*0.05,vertical: Height*0.014),
          child: Text(
            text,
            style: TextStyle(
              color: colorText ?? Colors.grey,
              fontFamily: kFontMain,
            ),
            textAlign: center==null? TextAlign.center:null,
          ),
        ),
      ),
    ],
  );
}


Widget buildItemContainer(
    {required width,
      required text,
      height,
      Color? color,
      Color? colorText,
      center,
      required Width,
      required Height
    }){
  return Container(
    width: width,
    height: height,
    margin: EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
      color: color?? color,
      border: Border.all(color: Colors.white, width: 0.3),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: Width*0.05,vertical: Height*0.014),
      child: Text(
        text,
        style: TextStyle(
          color: colorText ?? Colors.grey,
          fontFamily: kFontMain,
        ),
        textAlign: center==null? TextAlign.center:null,
      ),
    ),
  );
}