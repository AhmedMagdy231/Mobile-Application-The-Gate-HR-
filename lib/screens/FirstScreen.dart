import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:qr_application/components/componants.dart';
import 'package:qr_application/constat/const.dart';
import 'package:qr_application/cubit/cubit.dart';
import 'package:qr_application/cubit/states.dart';
import 'package:qr_application/network/local/CashHelper.dart';
import '../network/end_points.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocProvider<QrScannerCubit>(
      create: (context) =>
          QrScannerCubit()..checkServes(context: context, height: height),
      child: BlocConsumer<QrScannerCubit, QrStates>(
          listener: (context, state) async {
        if (state is QrLoginSuccess) {
          if (state.model.hasError != true) {
           await CashHelper.putData(key: 'token', value: state.model.data!.hremployee_accesstoken);
           await CashHelper.putData(key: 'name', value: state.model.data!.hremployee_fullname.split(" ")[0]);
            kName= CashHelper.getData(key: 'name');
            kToken = CashHelper.getData(key: 'token');

            showDialoog(
                context: context,
                num: 1,
                state: LOGIN,
                widget: Message(
                  message: state.model.messages,
                  size: height,
                ));
          } else {
            showDialoog(
                context: context,
                num: 0,
                state: LOGIN,
                widget: Message(
                  message: state.model.errors,
                  size: height,
                ));
          }
        }
      }, builder: (context, state) {
        var cubit = QrScannerCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildImageScanner(height, width),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Text(
                    'Q - S C A N',
                    style: TextStyle(
                        color: Color(0xff3293E6),
                        fontSize: 23,
                        fontFamily: kFontMain,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Text(
                    'Please Scan QR Code From HR To\nOpen Application',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: kFontMain,
                        fontSize: 18,
                        color: Colors.white70),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  cubit.onClick?CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {


                            if(cubit.onClick == false)
                            {
                              cubit.changeOnClick();
                              QrScannerCubit.get(context).checkServes(
                                  context: context, height: height).then((
                                  value){

                                  if(value){
                                  QrScannerCubit.get(context)
                                      .scanMe(context: context, state: LOGIN);
                                  }else{
                                    cubit.changeOnClick();

                                  }

                              });
                            }
                          },
                          child: Text(
                            'SCAN ME',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                fontFamily: kFontMain),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff3293E6),
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 0.2,
                                vertical: height * 0.02),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                          ),
                        ),

                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Container buildImageScanner(double height, double width) {
    return Container(
      height: height * 0.2,
      width: width * 0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        // border: Border.all(color: Colors.white70,width: 0.5),

      ),
      child: ClipRRect(
        child: Image.asset(
          'images/scan.gif',
          fit: BoxFit.contain,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
