import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qr_application/components/componants.dart';
import 'package:qr_application/cubit/states.dart';
import 'package:qr_application/models/addExuesesModel.dart';
import 'package:qr_application/models/ExcuesBYID.dart';
import 'package:qr_application/models/announcementByID.dart';
import 'package:qr_application/models/announcementModel.dart';
import 'package:qr_application/models/notificationModel.dart';
import 'package:qr_application/models/updateExcuseModel.dart';
import 'package:qr_application/models/userModel.dart';
import 'package:qr_application/models/excuses%20reason.dart';
import 'package:qr_application/models/getAllExcuses.dart';
import 'package:qr_application/network/end_points.dart';
import 'package:qr_application/network/local/CashHelper.dart';
import 'package:qr_application/network/remote/dio_helper.dart';
import 'package:qr_application/screens/AttendenceScreen.dart';
import 'package:qr_application/screens/Excuses.dart';
import 'package:qr_application/screens/announcement.dart';
import 'package:qr_application/screens/getAllExcusesData.dart';
import 'package:qr_application/screens/notificationScreen.dart';

import '../constat/const.dart';
import '../models/ExcusesManagementByIdModel.dart';
import '../models/excuses_managments_model.dart';

class QrScannerCubit extends Cubit<QrStates> {
  QrScannerCubit() : super(QrInitialState());

  static QrScannerCubit get(context) => BlocProvider.of(context);
  String strQr = '';
  late UserData? userModel=null;
  Position? myLocation;
  late LocationPermission per;
  bool onClick = false;
  late AnnouncementModel? announcement = null;
  late DataModelExcuses? excData = null;
  late DataModelAllExcuses? allExcuses = null;
  late DataModelExcusesID? idExcuses = null;
  late AnnouncementIDModel? idAnnnouncement = null;
  late AddExcusesModel addExcusesModel;
  late GetAllExcusesManagement? getAllExcusesManagement = null;
  late GetExcuseManagementID? getExcuseManagementID = null;
  late UpdateExcuse? updateExcuse = null;
  late NotificationModel? notificationModel=null;
  var descriptionControllerDepartment = TextEditingController();
  var descriptionControllerHR = TextEditingController();
  int currentIndex = 0;
  List <Widget> myScreen = [
    AttendanceScreen(),
    Announcement(),
    GetAllExcuses(),
    NotificationScreen(),

  ];
  String selectedReason = '';
  String selectedDurationType = '';
  List<String> keys = <String>[
    'minutes',
    'hours',
    'days',
  ];


  void changePage(int index) {
    currentIndex = index;
    userVerify();
    emit(changePageIndex());
  }

  void changeOnClick() {
    onClick = !onClick;
    emit(changeClick());
  }

  Future<void> scanMe({context, required String state}) async {
    per = await Geolocator.checkPermission();

    if (per == LocationPermission.denied) {
      per = await Geolocator.requestPermission();
    }
    if (per != LocationPermission.denied) {
      myLocation = await Geolocator.getCurrentPosition();
      emit(getLocationSuccess());
      print(myLocation?.longitude);
      print(myLocation?.latitude);
      if (await checkInternet(context)) {
        emit(QrScannerLoading());
        strQr = '';

        FlutterBarcodeScanner.scanBarcode(
            '#2A99CF', 'Cancel', true, ScanMode.QR).then((value) {
          strQr = value;
          print(strQr);
          print(
              "*************************************************************************************");
          if (strQr == '-1')
            emit(QrScannerCancel());
          else {
            if (state == LOGIN) {
              userLogin(loginHash: strQr);
            }
            else if (state == SIGNIN) {
              userSignIn(timeHash: strQr);
            }
            else if (state == SIGNOUT) {
              userSignOUT(timeHash: strQr);
            }
          }
          changeOnClick();
        }).catchError((error) {
          print(error.toString());

          emit(QrScannerError(msg: error.toString()));
        });
      }
    }
  }

  Future<bool> checkInternet(context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      showDialoog(context: context,
          num: -1,
          state: 'internet',
          widget: servesConnection(
              "Please Active Your Internet  ", Icons.wifi_off_rounded));
      return false;
    }
    return true;
  }

  void userLogin({required String loginHash}) {
    print('Heere we are in User LOgin');
    emit(QrLoginLoading());
    DioHelper.postData(
      url: hr,


      data: {
        'dataType': 'post',
        'dataCommand': LOGIN,
        'loginHash': loginHash,
      },

    ).then((value) {
      print(value.data);
      userModel = UserData.fromJson(value.data);
      if (userModel!.data != null)
        print(userModel!.data?.hremployee_accesstoken);


      emit(QrLoginSuccess(model: userModel!));
    });
  }

  Future<bool> userVerify() async {
    emit(verifyUserLoading());
    await DioHelper.postData(
      url: hr,
      token: kToken,
      data: {
        'dataType': 'post',
        'dataCommand': VERIFY,

      },

    ).then((value) async {
      print(value.data);
      userModel = UserData.fromJson(value.data);
      print('++++++++ TOKEN IS : ${userModel!.data!.hremployee_accesstoken}');
      print('++++++++  notfication is : ${userModel!.data!.new_hr_employees_notifications_count}');

      if(kTokenFcm != userModel!.data!.hremployee_firebase_accesstoken){

         kTokenFcm = await FirebaseMessaging.instance.getToken();
         postUpdateTokenFcm(tokenFcm: kTokenFcm!);

      }



      emit(verifyUserSuccess(model: userModel!));
    });
    return userModel!.hasError;
  }

  void userSignIn({required String timeHash}) async {
    emit(SignInLoading());


    DioHelper.postData(
      url: hr,
      data: {
        'dataType': 'post',
        'dataCommand': SIGNIN,
        'timeHash': timeHash,
        'positionX': myLocation?.longitude,
        'positionY': myLocation?.latitude,

      },
      token: kToken,
    ).then((value) {
      print('888888888888888888888888888888888888888888888888');
      print(value.data);
      print('888888888888888888888888888888888888888888888888');
      userModel = UserData.fromJson(value.data);


      emit(SignInSuccess(model: userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(SignInError());
    });
  }

  void userSignOUT({required String timeHash}) {
    emit(SignOutLoading());
    DioHelper.postData(
      url: hr,
      data: {
        'dataType': 'post',
        'dataCommand': SIGNOUT,
        'timeHash': timeHash,
         'positionX': myLocation?.longitude,
        'positionY': myLocation?.latitude,

      },
      token: kToken,
    ).then((value) {
      print(value.data);
      userModel = UserData.fromJson(value.data);

      emit(SignOutSuccess(model: userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(SignOutError());
    });
  }

  Future<bool> checkLocation(context) async {
    bool serves;
    serves = await Geolocator.isLocationServiceEnabled();
    if (serves == false) {
      showDialoog(context: context,
          num: -1,
          state: 'location',
          widget: servesConnection(
              "Please Open Your Location", Icons.location_on));
    }
    else {
      print('opeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeen');
      LocationPermission per;
      per = await Geolocator.checkPermission();
      print(per);
      if (per == LocationPermission.denied) {
        per = await Geolocator.requestPermission();
      }
    }

    return serves;
  }


  Future<bool> checkServes({required context, required height}) async {
    bool internet = true;
    bool location = true;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      internet = false;
    }
    location = await Geolocator.isLocationServiceEnabled();


    if (!internet && !location) {
      showDialoog(context: context,
          num: -1,
          state: 'serves',
          widget: bothWifiLocation());
    }
    else if (!internet) {
      checkInternet(context);
      print('internet');
    }
    else if (!location) {
      checkLocation(context);
    }

    return internet && location;
  }


  Future<void> getNews({required page}) async {
    //announcement = null;
    emit(announcementLoading());
    DioHelper.postData(
        url: hrAnn,
        token: kToken,
        data: {
          'dataType': 'post',
          'dataCommand': NEWS,
          'page': page

        }

    ).then((value) {
      announcement = AnnouncementModel.fromJson(value.data);
      print(value.data);

      emit(announcementSucess());
    });
  }


  Future<void> getExcReason() async {
    if(excData == null){
      print('exuses data is null ');
    }else{
      print('exuses data is not null ');
    }
   if (excData == null) {
      emit(ExcReasonLoading());

      DioHelper.postData(
        url: exReason,
        token: kToken,
        data: {
          'dataType': 'post',
          'dataCommand': NEWS,

        },

      ).then((value) {
        print(value.data);
        excData = DataModelExcuses.fromJson(value.data);
        emit(ExcReasonSuccess());
      }).catchError((error) {
        print(error.toString());
        emit(ExcReasonError());
      });
    }
  }

  Future<void> addExcuses({required  id,required int meetingId,required duration,required durationType,required description,}) async {
    emit(AddExcusesLoading());
    if (meetingId == 1) {
      per = await Geolocator.checkPermission();

      if (per == LocationPermission.denied) {
        per = await Geolocator.requestPermission();
      }
      if (per != LocationPermission.denied) {
        myLocation = await Geolocator.getCurrentPosition();
      }
      print(myLocation?.longitude);
      print(myLocation?.latitude);
    }
   await DioHelper.postData(
      token: kToken,
        data: {
          'dataType': 'post',
          'dataCommand': EXCUSESADD,
          'reasonId': id,
          'duration' : duration,
          'durationType': durationType,
          'description' : description,
          'positionX': meetingId==1? myLocation!.longitude:'',
          'positionY': meetingId==1? myLocation!.latitude:'',


        },
        url: excuses
    ).then((value){
     print(value.data);
     addExcusesModel = AddExcusesModel.fromJson(value.data);
     emit(AddExcusesSuccess(addExcusesModel:  addExcusesModel));
     changeOnClick();

      print('done');



    }).catchError((error){
      print(error.toString());
      emit(AddExcusesError());
      changeOnClick();

    });

  }

  Future<void> getAllExcusesData({required int page})async{
    // allExcuses = null;
    emit(GetAllExcusesLoading());
  await DioHelper.postData(
      token: kToken,
        data: {
        'dataType':'post',
        'dataCommand': READALL,
        'page': page.toString(),
        },
        url: excuses,
    ).then((value){

      allExcuses = DataModelAllExcuses.fromJson(value.data);
      emit(GetAllExcusesSuccess());
      allExcuses!.data!.results.forEach((element) {
        print(element.HREXCUSEID);
      });
    }).catchError((error){
      emit(GetAllExcusesError());
  });
    print('=============================================================================================');





  }

  Future<void> getExcuseID({required id}) async {
    idExcuses = null;
    emit(GetIDExcusesLoading());
    print(id);
    DioHelper.postData(
        url: excuses,
        token: kToken,
        data: {
          'dataType': 'post',
          'dataCommand': READID,
          'id': id,

        }

    ).then((value) {
      idExcuses = DataModelExcusesID.fromJson(value.data);
      print(value.data);
      emit(GetIDExcusesSuccess());
    });
  }

  Future<void> getAnnouncementID({required id}) async {
    idAnnnouncement = null;
    emit(GetIDAnnouncementLoading());
    print(id);
    DioHelper.postData(
        url: hrAnn,
        token: kToken,
        data: {
          'dataType': 'post',
          'dataCommand': READID,
          'id': id,

        }

    ).then((value) {
      idAnnnouncement = AnnouncementIDModel.fromJson(value.data);
      print(value.data);
      emit(GetIDAnnouncementSuccess());
    });
  }


  Future<void> getAllExcusesManagementData({required int page})async{
    // allExcuses = null;
    emit(GetExcusesManagementsLoading());
    await DioHelper.postData(
      token: kToken,
      data: {
        'dataType':'post',
        'dataCommand': READALL,
        'page': page,
      },
      url: EXCUSES_MANAGEMENTS,
    ).then((value){

      getAllExcusesManagement = GetAllExcusesManagement.fromJson(value.data);

      emit(GetExcusesManagementsSuccess());
    }).catchError((error){
      emit(GetExcusesManagementsError());
    });
    print('=============================================================================================');
  }



  Future<void> getDataExcuseManagementID({required id}) async {
    getExcuseManagementID = null;
    emit(GetIDExcusesManagementLoading());
    print(id);
    DioHelper.postData(
        url: EXCUSES_MANAGEMENTS,
        token: kToken,
        data: {
          'dataType': 'post',
          'dataCommand': READID,
          'id': id,
        }

    ).then((value) {
      getExcuseManagementID = GetExcuseManagementID.fromJson(value.data);
      descriptionControllerDepartment.text = getExcuseManagementID!.data!.results!.hrexcuseDepartmentNotes!;
      descriptionControllerHR.text = getExcuseManagementID!.data!.results!.hrexcuseHrNotes!;
      emit(GetIDExcusesManagementSuccess());
      print(getExcuseManagementID!.data!.results!.hrexcuseStatusString);
    }).catchError((error){
      print(error);
      emit(GetIDExcusesManagementError());
    });
  }



  Future<void> postUpdateExcuse({required id,required dep_status,required dep_note,required hr_status,required hr_note}) async {

    emit(GetUpdateExcuseLoading());
    print(id);
    DioHelper.postData(
        url: EXCUSES_MANAGEMENTS,
        token: kToken,
        data: {
          'dataType': 'post',
          'dataCommand': 'updateId',
          'id': id,
          'hrexcuse_department_status': dep_status,
          'hrexcuse_department_notes': dep_note,
          'hrexcuse_hr_status': hr_status,
          'hrexcuse_hr_notes': hr_note,
        }

    ).then((value) {

      updateExcuse = UpdateExcuse.fromJson(value.data);

      emit(GetUpdateExcuseSuccess(updateExcuseState: updateExcuse!));
    }).catchError((error){
      print(error);
      emit(GetUpdateExcuseError());
    });

  }


  Future<void> getAllNotification({required int page})async{
   //notificationModel = null;
    emit(GetNotificationLoading());
    await DioHelper.postData(
      token: kToken,
      data: {
        'dataType':'post',
        'dataCommand': READALL,
        'page': page,
      },
      url: NOTIFICATION,
    ).then((value){

      notificationModel = NotificationModel.fromJson(value.data);

      emit(GetNotificationSuccess());
    }).catchError((error){
      emit(GetNotificationError());
    });

  }


  Future<void> postUpdateNotification({required id})async{


   emit(GetUpdateNotificationLoading());
    await DioHelper.postData(
      token: kToken,
      data: {
        'dataType':'post',
        'dataCommand': 'updateId',
        'id' : id,

      },
      url: NOTIFICATION,
    ).then((value)async{
      print(value.data);

      getAllNotification(page: 1);
      userVerify();

    }).catchError((error){
      emit(GetUpdateNotificationError());
    });

  }


  Future<void> postUpdateTokenFcm({required String tokenFcm})async{
    emit(GetUpdateTokenFcmLoading());
    DioHelper.postData(
        data: {
          'dataType':'post',
          'dataCommand': 'firebaseTokenUpdate',
          'firebaseToken' : tokenFcm,

        },
        url: hr,
      token: kToken,
    ).then((value){
      print(value.data);
      emit(GetUpdateTokenFcmSuccess());

    }).catchError((error){
      emit(GetUpdateTokenFcmError());

    });

  }
}