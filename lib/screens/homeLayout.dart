import 'package:badges/badges.dart' as ba;
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_application/constat/const.dart';
import 'package:qr_application/cubit/cubit.dart';
import 'package:qr_application/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QrScannerCubit,QrStates>(
      listener: (context, state){},
      builder: (context,state){
        var cubit = QrScannerCubit.get(context);
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        return Scaffold(
          backgroundColor: Colors.black,
          body: cubit.myScreen[cubit.currentIndex],
          bottomNavigationBar: CurvedNavigationBar(
            items: [

              Icon(Icons.qr_code_scanner_sharp, size: width*0.08),
              Icon(Icons.newspaper,size: width*0.08,),
              Icon(Icons.pending_actions,size: width*0.08,),
              cubit.userModel == null || cubit.userModel!.data!.new_hr_employees_notifications_count =='0'? Icon(Icons.notifications,size: width*0.08,): ba.Badge(

                badgeContent: Text(
                 ' ',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: kFontMain,
                    fontWeight: FontWeight.bold,

                  ),
                ),
                badgeColor: Colors.red,
                position: ba.BadgePosition.topEnd(top: -height*0.015, end: 2),
                child:  Icon(Icons.notifications,size: width*0.08,),
                ),

            ],
            backgroundColor: Colors.transparent,
            animationDuration: Duration(milliseconds: 300),
            height: height*0.07,
            index: cubit.currentIndex,
            onTap: (index){
              cubit.changePage(index);
            },
          ),
        );


      },

    );
  }
}
