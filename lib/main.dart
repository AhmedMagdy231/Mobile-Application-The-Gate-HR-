import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_application/cubit/cubit.dart';
import 'package:qr_application/cubit/states.dart';
import 'package:qr_application/network/local/CashHelper.dart';
import 'package:qr_application/network/remote/dio_helper.dart';
import 'package:qr_application/screens/FirstScreen.dart';
import 'package:qr_application/screens/homeLayout.dart';
import 'bloc_observer.dart';
import 'constat/const.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CashHelper.init();
  late Widget firstWidget;
  //MTY1ODY3ODMwMGRtOTI1NDUzNnd5cDJnYmpkdjVrdm1zdmY2eHNiM2JmNGNya2R4OGZrbjh2bm5zcXpnOXlrOGpzejdyNGc3cno=
 // CashHelper.putData(key: 'token', value: 'MTY2ODM4MTg4NW5idGIzdjg5dnk1dDdnYjJoNmR0N3ZjYnRmNnZkbW5ra2czejM5eHA4Nnprczd5Mjc4NGRncTV5anF2cW5ieHA=');
 // CashHelper.removeData(key: 'token');
  kToken = CashHelper.getData(key: 'token');
  kName = CashHelper.getData(key: 'name')??'';

  kTokenFcm = await FirebaseMessaging.instance.getToken();


  print('++++++++++++++++++++++++++++++++++++');
  print(kToken);
  print('++++++++++++++++++++++++++++++++++++++');

  if (kToken != null) { firstWidget = HomeLayout();}
  else {

    firstWidget = FirstScreen();
  }
  runApp(MyApp(
    widget: firstWidget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget widget;

  MyApp({required this.widget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QrScannerCubit>(
      create: (context)=> kToken == null? QrScannerCubit(): QrScannerCubit()..getNews(page: 1)..getAllExcusesData(page: 1)..userVerify()..getAllNotification(page: 1),
      child: BlocConsumer<QrScannerCubit,QrStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: widget,
          );
        },
      ),

    );
  }
}
