import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:qr_application/components/componants.dart';
import 'package:qr_application/constat/const.dart';
import 'package:qr_application/cubit/cubit.dart';
import 'package:qr_application/cubit/states.dart';

import '../models/announcementModel.dart';

class Details extends StatelessWidget {
  final String? id;
   Details({required this.id});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    //cubit.getAnnouncementID(id: id);
    return BlocConsumer<QrScannerCubit,QrStates>(
      listener: (context, state) {

      },
      builder: (context,state){
        var cubit = QrScannerCubit.get(context);



        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text('Details',),
          ),
          backgroundColor: Colors.black,

          body: cubit.idAnnnouncement==null? Center(child: CircularProgressIndicator(color: Colors.white,),): RefreshIndicator(
            onRefresh: ()async{
              cubit.getAnnouncementID(id: id);

            },
            child: ListView(

              children: [
                ItemNews(width: width,news: cubit.idAnnnouncement?.data,context: context),
                Divider(color: Colors.grey,),
                Padding(
                  padding:  EdgeInsets.all(width * 0.04),
                  child: Html(
                    data: cubit.idAnnnouncement?.data.hrannouncement_description,
                    style: {
                      'body':Style(
                          fontSize: FontSize(17),
                          color: Colors.white,
                          fontFamily: kFontMain,

                      )
                    },
                  ),
                ),
                Divider(color: Colors.grey,),


              ],
            ),
          ),


        );
      },
    );
  }
}
