import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_application/components/componants.dart';
import 'package:qr_application/cubit/cubit.dart';
import 'package:qr_application/cubit/states.dart';
import 'package:qr_application/screens/DeatilsAnnouncement.dart';
import 'package:badges/badges.dart' as ba;
import '../constat/const.dart';
import '../network/end_points.dart';
import '../network/local/CashHelper.dart';
import 'details.dart';
import 'detailsEcxcusesManagement.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    QrScannerCubit.get(context).userVerify().then((value){
      QrScannerCubit.get(context).getAllNotification(page: 1);
    });


    print('heeeeeeeeeeereeeeeeeeeeeee agina');


    return BlocConsumer<QrScannerCubit, QrStates>(
      listener: (context, state) {
        if (state is verifyUserSuccess) {
          if (state.model.hasError) {
            CashHelper.removeData(key: 'token');
            CashHelper.removeData(key: 'name');
            kToken = '';
            kName = '';
            showDialoog(
                context: context,
                num: 0,
                state: VERIFY,
                widget: Message(
                  message: [
                    'Your id not found in system please go to HR to scan again',
                  ],
                  size: height,
                ));
          }
        }

      },
      builder: (context, state) {
        var cubit = QrScannerCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: Text('Notification'),
            actions: [

              ba.Badge(

                badgeContent: Text(
                  cubit.userModel == null?'':cubit.userModel!.data!.new_hr_employees_notifications_count,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: kFontMain,
                    fontWeight: FontWeight.bold,

                  ),
                ),
                badgeColor: Colors.red,
                position: ba.BadgePosition.topEnd(top: height*0.02, end: 0),
                child:  Icon(Icons.notifications,size: width*0.09,),
              ),
              SizedBox(width: width*0.05,),


            ],
            backgroundColor: Colors.black,
            elevation: 8,
            shadowColor: Colors.white,
          ),

          body: cubit.notificationModel == null
             || cubit.notificationModel?.data == null ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(
                  color: Colors.white,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Loading data please wait',
                  style: TextStyle(
                      color: Colors.white70, fontFamily: kFontMain),
                ),
              ],
            ),
          )
              : cubit.notificationModel!.data!.results!.length ==0?
          RefreshIndicator(
            onRefresh: ()async{
              cubit.checkInternet(context);
              cubit.getAllNotification(page: 1);
            },
            child: ListView(

              children: [
                SizedBox(height: height*0.35,),
                Center(
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  const[
                        Icon(Icons.notifications_off_outlined,size: 50,color: Colors.white,),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'You don\'t have any notification yet',
                          style: TextStyle(color: Colors.white70,fontFamily: kFontMain),
                        ),
                      ],
                    )),
              ],
            ),
          ) :
          ListView(
            children: [

              Container(
                height: height*0.82,
                child: RefreshIndicator(
                  onRefresh: ()async{
                    cubit.userVerify();
                    cubit.getAllNotification(page: 1);
                  },
                  child: ListView.builder(
                      itemCount:
                      cubit.notificationModel!.data!.results!.length,
                      itemBuilder: (context, index) {
                        return index %2 ==0? FadeInRight(
                          from: width,

                          child: GestureDetector(
                            onTap: ()async{
                              String action = cubit.notificationModel!.data!.results![index].notificationAction!;
                              String not_id = cubit.notificationModel!.data!.results![index].notificationActionid!;
                              if(action == 'hr_excuses'){
                                cubit.getExcuseID(id: not_id);
                                navigateTo(context, ExcuseDetailsScreen(id: not_id,));
                                cubit.postUpdateNotification(id: cubit.notificationModel!.data!.results![index].nOTIFICATIONID!);

                              }
                              else if(action == 'hr_announcements'){
                                cubit.getAnnouncementID(id: not_id);
                                navigateTo(context, Details(id: not_id));
                                cubit.postUpdateNotification(id: cubit.notificationModel!.data!.results![index].nOTIFICATIONID!);

                              }
                              else if(action == 'hr_excuses_managements' || action == 'hr_excuses_management' ){

                                navigateTo(context, DetailsExcusesManagementScreen(id: not_id,));
                                cubit.userVerify();
                                cubit.getDataExcuseManagementID(id: not_id);
                                cubit.postUpdateNotification(id: cubit.notificationModel!.data!.results![index].nOTIFICATIONID!);

                              }
                              else if (action == ''){
                                print(action);
                                cubit.postUpdateNotification(id: cubit.notificationModel!.data!.results![index].nOTIFICATIONID!);

                              }

                            },
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                width: width,
                                height: height * 0.15,
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.03,
                                    vertical: height * 0.015),
                                decoration: BoxDecoration(
                                  color: cubit.notificationModel!.data!
                                      .results![index].notificationRead ==
                                      '0'
                                      ? Colors.white
                                      : Colors.white60,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 35,
                                      backgroundImage:
                                      AssetImage('images/en.png'),
                                      backgroundColor: Colors.black,
                                    ),
                                    SizedBox(
                                      width: width * 0.03,
                                    ),
                                    Container(
                                      width: width * 0.55,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            cubit.notificationModel!.data!
                                                .results![index].notificationMsg!,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily: kFontMain,
                                              fontSize: 13,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textDirection: TextDirection.ltr,
                                          ),
                                          Text(
                                            cubit
                                                .notificationModel!
                                                .data!
                                                .results![index]
                                                .notificationDate!,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: kFontMain,
                                                fontSize: 13,
                                                color: cubit
                                                    .notificationModel!
                                                    .data!
                                                    .results![index]
                                                    .notificationRead ==
                                                    '0'
                                                    ? Colors.grey
                                                    : Colors.black87),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.015,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        getNotification(
                                            status: cubit.notificationModel!.data!
                                                .results![index].notificationIcon),
                                        SizedBox(height: 5,),
                                        Text(
                                          formatTime(int.parse(cubit.notificationModel!.data!
                                              .results![index].notificationTime!)),
                                          style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ): FadeInLeft(
                          from: width,

                          child: GestureDetector(
                            onTap: ()async{
                              String action = cubit.notificationModel!.data!.results![index].notificationAction!;
                              String not_id = cubit.notificationModel!.data!.results![index].notificationActionid!;
                              if(action == 'hr_excuses'){
                                cubit.getExcuseID(id: not_id);
                                navigateTo(context, ExcuseDetailsScreen(id: not_id,));
                                cubit.postUpdateNotification(id: cubit.notificationModel!.data!.results![index].nOTIFICATIONID!);

                              }
                              else if(action == 'hr_announcements'){
                                cubit.getAnnouncementID(id: not_id);
                                navigateTo(context, Details(id: not_id));
                                cubit.postUpdateNotification(id: cubit.notificationModel!.data!.results![index].nOTIFICATIONID!);

                              }
                              else if(action == 'hr_excuses_managements' || action == 'hr_excuses_management' ){

                                navigateTo(context, DetailsExcusesManagementScreen(id: not_id,));
                                cubit.userVerify();
                                cubit.getDataExcuseManagementID(id: not_id);
                                cubit.postUpdateNotification(id: cubit.notificationModel!.data!.results![index].nOTIFICATIONID!);

                              }
                              else if (action == ''){
                                print(action);
                                cubit.postUpdateNotification(id: cubit.notificationModel!.data!.results![index].nOTIFICATIONID!);

                              }

                            },
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                width: width,
                                height: height * 0.15,
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.03,
                                    vertical: height * 0.015),
                                decoration: BoxDecoration(
                                  color: cubit.notificationModel!.data!
                                      .results![index].notificationRead ==
                                      '0'
                                      ? Colors.white
                                      : Colors.white60,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 35,
                                      backgroundImage:
                                      AssetImage('images/en.png'),
                                      backgroundColor: Colors.black,
                                    ),
                                    SizedBox(
                                      width: width * 0.03,
                                    ),
                                    Container(
                                      width: width * 0.55,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            cubit.notificationModel!.data!
                                                .results![index].notificationMsg!,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily: kFontMain,
                                              fontSize: 13,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textDirection: TextDirection.ltr,
                                          ),
                                          Text(
                                            cubit
                                                .notificationModel!
                                                .data!
                                                .results![index]
                                                .notificationDate!,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: kFontMain,
                                                fontSize: 13,
                                                color: cubit
                                                    .notificationModel!
                                                    .data!
                                                    .results![index]
                                                    .notificationRead ==
                                                    '0'
                                                    ? Colors.grey
                                                    : Colors.black87),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.015,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        getNotification(
                                            status: cubit.notificationModel!.data!
                                                .results![index].notificationIcon),
                                        SizedBox(height: 5,),
                                        Text(
                                            formatTime(int.parse(cubit.notificationModel!.data!
                                                .results![index].notificationTime!)),
                                          style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget getNotification({required status}) {
    switch (status) {
      case 'check':
        {
          return Icon(
            Icons.check,
            size: 35,
          );
        }
      case 'exclamation':
        {
          return Icon(
            Icons.info_outline,
            size: 35,
          );
        }
      case 'times':
        {
          return Icon(
            Icons.close,
            size: 35,
          );
        }
    }

    return Icon(Icons.notifications);
  }
}
