import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_application/constat/const.dart';
import 'package:qr_application/cubit/cubit.dart';
import 'package:qr_application/cubit/states.dart';

import '../components/componants.dart';
import '../models/getAllExcuses.dart';

class ExcuseDetailsScreen extends StatelessWidget {
 final String id;
  ExcuseDetailsScreen({required this.id});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;



    return BlocConsumer<QrScannerCubit,QrStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = QrScannerCubit.get(context);


        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            elevation: 3,
            shadowColor: Colors.white,
            title: Text('Details Excuse ${id}'),
            backgroundColor: Colors.black,
          ),
          body: Padding(
            padding: EdgeInsets.all(20),
            child: RefreshIndicator(
              onRefresh: ()async{
                cubit.getExcuseID(id: cubit.idExcuses!.data!.HREXCUSEID);
              },
              child: cubit.idExcuses ==null?Center(child: CircularProgressIndicator(color: Colors.white,)) : ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      builtItem(
                        width: width * 0.3,
                        mainText: 'Reason Name',
                        text: cubit.idExcuses!.data!.hrexcreason_name,
                        Width: width,
                        Height: height,
                      ),
                      builtItem(
                        width: width * 0.5,
                        mainText: 'Status',
                        text: cubit.idExcuses!.data!.hrexcuse_status_string,
                        Width: width,
                        Height: height,
                        colorText: Colors.white,
                        color: getStatusId(status: cubit.idExcuses!.data!.hrexcuse_status_string) == '2' ? Colors.green :
                        getStatusId(status: cubit.idExcuses!.data!.hrexcuse_status_string) == '0'? Colors.red : Colors.grey,

                      ),
                    ],
                  ),

                  SizedBox(height: height*0.01,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      builtItem(
                        width: width * 0.3,
                        mainText: 'Duration',
                        text: cubit.idExcuses!.data!.hrexcuse_duration,
                        Width: width,
                        Height: height,
                      ),
                      builtItem(
                        width: width * 0.5,
                        mainText: 'Duration Type',
                        text: cubit.idExcuses!.data!.hrexcuse_duration_type_string,
                        Width: width,
                        Height: height,
                      ),
                    ],
                  ),
                  builtItem(
                    width: width,
                    mainText: 'Description',
                    text: cubit.idExcuses!.data!.hrexcuse_description,
                    center: 1,
                    Width: width,
                    Height: height,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      builtItem(
                        width: width * 0.3,
                        mainText: 'Time',
                        text: cubit.idExcuses!.data!.hrexcuse_time,
                        Width: width,
                        Height: height,
                      ),
                      builtItem(
                        width: width * 0.5,
                        mainText: 'Date',
                        text: cubit.idExcuses!.data!.hrexcuse_date,
                        Width: width,
                        Height: height,
                      ),
                    ],
                  ),


                  builtItem(
                    width: width,
                    mainText: 'Department Status',
                    text: cubit.idExcuses!.data!.hrexcuse_department_status_string,
                    center: 1,
                    Width: width,
                    Height: height,
                  ),
                  builtItem(
                    width: width,
                    mainText: 'Department Note',
                    text: cubit.idExcuses!.data!.hrexcuse_department_notes,
                    center: 1,
                    Width: width,
                    Height: height,
                  ),

                  builtItem(
                    width: width,
                    mainText: 'HR Status',
                    text: cubit.idExcuses!.data!.hrexcuse_status_string,
                    center: 1,
                    Width: width,
                    Height: height,
                  ),
                  builtItem(
                    width: width,
                    mainText: 'HR Note',
                    text: cubit.idExcuses!.data!.hrexcuse_hr_notes,
                    center: 1,
                    Width: width,
                    Height: height,
                  ),
                ],
              ),
            ),
          ),
        );
      },

    );
  }




}
