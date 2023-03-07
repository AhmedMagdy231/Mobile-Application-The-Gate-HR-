import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_application/components/componants.dart';
import 'package:qr_application/cubit/cubit.dart';
import 'package:qr_application/cubit/states.dart';
import 'package:qr_application/network/local/CashHelper.dart';
import 'package:qr_application/screens/FirstScreen.dart';

import '../constat/const.dart';
import '../network/end_points.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocProvider<QrScannerCubit>(
      create: (context) => QrScannerCubit()
        ..checkServes(context: context, height: height)
        ..userVerify(),
      child: BlocConsumer<QrScannerCubit, QrStates>(
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

          if (state is SignInSuccess) {
            print(state.model.hasError);
            print(state.model.errors);
            print(state.model.messages);
            print(state.model.data?.hremployee_email);
            if (state.model.hasError) {
              showDialoog(
                  context: context,
                  num: -1,
                  state: 'signin',
                  widget: Message(
                    message: state.model.errors,
                    size: height,
                  ));
            } else {
              showDialoog(
                  context: context,
                  num: 1,
                  state: 'signin',
                  widget: Message(
                    message: state.model.messages,
                    size: height,
                  ));
            }
          }
          if (state is SignOutSuccess) {
            if (state.model.hasError) {
              showDialoog(
                  context: context,
                  num: -1,
                  state: 'signout',
                  widget: Message(
                    message: state.model.errors,
                    size: height,
                  ));
            } else {
              showDialoog(
                  context: context,
                  num: 1,
                  state: 'signout',
                  widget: Message(
                    message: state.model.messages,
                    size: height,
                  ));
            }
          }
        },
        builder: (context, state) {
          var cubit = QrScannerCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('Attendance'),
              backgroundColor: Colors.black,
              actions: [
                Icon(Icons.qr_code_scanner_sharp),
                SizedBox(width: width*0.02,),

              ],

            ),
            backgroundColor: Colors.black,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: height * 0.02),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height * 0.05,
                      ),
                      ClipRRect(
                        child: Image.asset(
                          'images/scan1.png',
                          height: 200,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Text(
                        cubit.userModel == null? '': 'Welcome ${cubit.userModel!.data!.hremployee_fullname.split(' ')[0]},',
                        style: TextStyle(
                            fontSize: 25,
                            fontFamily: kFontMain,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Text(
                        'Make Your Attendance is Easy With QR Code.',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: kFontMain,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.1,
                      ),

                      cubit.onClick?Center(child: CircularProgressIndicator(color: kColor2,)):Container(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildElevatedButton(
                              color: kColor2,
                              width: width * 0.85,
                              height: height * 0.06,
                              text: 'CHECK IN',
                              fun: () async {
                                if (cubit.onClick == false) {
                                  cubit.changeOnClick();
                                  QrScannerCubit.get(context)
                                      .checkServes(
                                          context: context, height: height)
                                      .then((value) {
                                    if (value) {
                                      cubit.userVerify().then((value) {
                                        if (value == false) {
                                          QrScannerCubit.get(context).scanMe(
                                              context: context, state: SIGNIN);
                                        } else {
                                          cubit.changeOnClick();
                                        }
                                      });
                                    } else {
                                      cubit.changeOnClick();
                                    }
                                  });
                                }

                                print('Check IN');
                              },
                              icon: Icons.arrow_circle_right_outlined,
                            ),
                            SizedBox(
                              height: height * 0.04,
                            ),
                            buildElevatedButton(
                              color: kColor2,
                              width: width * 0.85,
                              height: height * 0.06,
                              text: 'CHECK OUT',
                              fun: () async {
                                if (cubit.onClick == false) {
                                  cubit.changeOnClick();
                                  QrScannerCubit.get(context)
                                      .checkServes(
                                          context: context, height: height)
                                      .then((value) {
                                    if (value) {
                                      cubit.userVerify().then((value) {
                                        if (value == false) {
                                          QrScannerCubit.get(context).scanMe(
                                              context: context, state: SIGNOUT);
                                        } else {
                                          cubit.changeOnClick();
                                        }
                                      });
                                    }else{
                                      cubit.changeOnClick();

                                    }
                                  });
                                }

                                print('Check OUt');
                              },
                              icon: Icons.arrow_circle_left_outlined,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }


}
