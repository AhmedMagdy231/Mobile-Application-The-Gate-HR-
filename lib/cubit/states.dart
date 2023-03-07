import 'package:qr_application/models/addExuesesModel.dart';
import 'package:qr_application/models/updateExcuseModel.dart';
import 'package:qr_application/models/userModel.dart';
import 'package:qr_application/models/excuses%20reason.dart';

abstract class QrStates{}

class QrInitialState extends QrStates{}

class QrScannerLoading extends QrStates{}

class QrScannerSuccess extends QrStates{}

class QrScannerCancel extends QrStates{}

class QrScannerError extends QrStates{
  final String msg;

  QrScannerError({required this.msg});

}

class QrLoginLoading extends QrStates{}
class QrLoginSuccess extends QrStates{
   final UserData model;

  QrLoginSuccess({required this.model});



}
class QrLoginError extends QrStates{}

class verifyUserLoading extends QrStates{}
class verifyUserSuccess extends QrStates{
  final UserData model;

  verifyUserSuccess({required this.model});

}
class verifyUserError extends QrStates{}

class SignInLoading extends QrStates{}
class SignInSuccess extends QrStates{
  final UserData model;

  SignInSuccess({required this.model});
}
class SignInError extends QrStates{}

class  SignOutLoading extends QrStates{}
class  SignOutSuccess extends QrStates{
  final UserData model;

  SignOutSuccess({required this.model});
}
class SignOutError extends QrStates{}

class getLocationSuccess extends QrStates{}
class changeClick extends QrStates{}

class announcementLoading extends QrStates{}
class announcementSucess extends QrStates{}
class announcementError extends QrStates{}

class changePageIndex extends QrStates{}


class ExcReasonLoading extends QrStates{}
class ExcReasonSuccess extends QrStates{}
class ExcReasonError extends QrStates{}

class AddExcusesLoading extends QrStates{}
class AddExcusesSuccess extends QrStates{
  final AddExcusesModel addExcusesModel;
  AddExcusesSuccess({required this.addExcusesModel});
}
class AddExcusesError extends QrStates{}


class GetAllExcusesLoading extends QrStates{}
class GetAllExcusesSuccess extends QrStates{}
class GetAllExcusesError extends QrStates{}


class GetIDExcusesLoading extends QrStates{}
class GetIDExcusesSuccess extends QrStates{}
class GetIDExcusesError extends QrStates{}

class GetIDAnnouncementLoading extends QrStates{}
class GetIDAnnouncementSuccess extends QrStates{}
class GetIDAnnouncementError extends QrStates{}


class GetExcusesManagementsLoading extends QrStates{}
class GetExcusesManagementsSuccess extends QrStates{}
class GetExcusesManagementsError extends QrStates{}


class GetIDExcusesManagementLoading extends QrStates{}
class GetIDExcusesManagementSuccess extends QrStates{}
class GetIDExcusesManagementError extends QrStates{}


class GetUpdateExcuseLoading extends QrStates{}
class GetUpdateExcuseSuccess extends QrStates{
  final UpdateExcuse updateExcuseState;
  GetUpdateExcuseSuccess({required this.updateExcuseState});
}
class GetUpdateExcuseError extends QrStates{}


class GetNotificationLoading extends QrStates{}
class GetNotificationSuccess extends QrStates{}
class GetNotificationError extends QrStates{}

class GetUpdateNotificationLoading extends QrStates{}
class GetUpdateNotificationSuccess extends QrStates{}
class GetUpdateNotificationError extends QrStates{}

class GetUpdateTokenFcmLoading extends QrStates{}
class GetUpdateTokenFcmSuccess extends QrStates{}
class GetUpdateTokenFcmError extends QrStates{}
