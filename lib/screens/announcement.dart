import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:qr_application/constat/const.dart';
import 'package:qr_application/cubit/cubit.dart';
import 'package:qr_application/cubit/states.dart';

import '../components/componants.dart';
import '../models/announcementModel.dart';
import '../network/end_points.dart';
import '../network/local/CashHelper.dart';

class Announcement extends StatelessWidget {
  const Announcement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int ind=1;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    QrScannerCubit.get(context).getNews(page: 1);
    return   BlocConsumer<QrScannerCubit, QrStates>(
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
              appBar: AppBar(
                title: Text(
                  'Announcement',

                ),
                elevation: 2,
                shadowColor: Colors.white,
                backgroundColor: Colors.black,
                //elevation: 6,
                // shadowColor: Colors.white,
              ),
              backgroundColor: Colors.black,
              body: Center(

                child: cubit.announcement==null? RefreshIndicator(
                  onRefresh: ()async{
                    cubit.checkInternet(context);
                    cubit.getNews(page: 1);
                  },
                  child: ListView(
                    children: [
                      Center(
                          child:  Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:  [
                              SizedBox(height: height*0.4,),
                              CircularProgressIndicator(
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Loading data please wait ',
                                style: TextStyle(color: Colors.white70,fontFamily: kFontMain),
                              ),
                            ],
                          )),
                    ],
                  ),
                ):
                 cubit.announcement!.data.results.length == 0?
                 RefreshIndicator(
                   onRefresh: ()async{
                     cubit.checkInternet(context);
                     cubit.getNews(page: ind);
                   },
                   child: ListView(

                     children: [
                       SizedBox(height: height*0.35,),
                       Center(
                           child:  Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children:  const[
                               Icon(Icons.newspaper_outlined,size: 50,color: Colors.white,),
                               SizedBox(
                                 height: 20,
                               ),
                               Text(
                                 'You don\'t have any announcement yet',
                                 style: TextStyle(color: Colors.white70,fontFamily: kFontMain),
                               ),
                             ],
                           )),
                     ],
                   ),
                 )
                     : ListView(
                      children: [
                        Container(
                          height: height*0.72,

                          child: state is! announcementLoading? RefreshIndicator(
                            onRefresh: ()async{

                              cubit.getNews(page: ind);


                            },
                            child: ListView.separated(

                                itemBuilder: (context, index) => ItemNews(
                                    width: width,
                                    news: cubit.announcement!.data.results[index],
                                    context: context,
                                ),
                                separatorBuilder: (context, index) => SizedBox(
                                      child: Divider(
                                        thickness: 2,
                                        color: Colors.grey.shade800,
                                      ),
                                    ),
                                itemCount: cubit.announcement!.data.results.length,
                            ),
                          ):Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(color: Colors.white,),
                            ],
                          ),
                        ),
                        Container(
                          width: width,
                          padding:
                          EdgeInsets.symmetric(horizontal: width * 0.02),
                          child: NumberPaginator(

                            numberPages: cubit.announcement?.data.maxPage??0,
                            onPageChange: (int index) {
                              ind = index + 1;
                              print(ind);
                              print('============');
                              print(index);
                              QrScannerCubit.get(context).checkInternet(context).then((value){
                                QrScannerCubit.get(context)
                                    .getNews(page: ind);
                              });

                            },
                            // initially selected index
                            initialPage: ind-1,
                            // default height is 48

                      buttonShape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            buttonSelectedForegroundColor: Colors.black,
                            buttonUnselectedForegroundColor: Colors.white,
                            buttonUnselectedBackgroundColor: Colors.grey,
                            buttonSelectedBackgroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
              ),
            );
          },


    );
  }
}

