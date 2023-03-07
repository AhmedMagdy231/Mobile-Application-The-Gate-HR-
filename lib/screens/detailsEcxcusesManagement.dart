import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:qr_application/components/componants.dart';
import 'package:qr_application/constat/const.dart';
import 'package:qr_application/cubit/cubit.dart';
import 'package:qr_application/cubit/states.dart';


class DetailsExcusesManagementScreen extends StatelessWidget {
  final String id;

  DetailsExcusesManagementScreen({required this.id});

  static final GlobalKey<FormState>  formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;



    return BlocConsumer<QrScannerCubit,QrStates>(
      listener: (context,state){

        if(state is GetUpdateExcuseSuccess){
          if(state.updateExcuseState.hasError!){
            showDialoog(context: context, num: 0, state: '', widget: Message(message: state.updateExcuseState.errors!, size: height));
          }else{
            showDialoog(context: context, num: 1, state: '', widget: Message(message: state.updateExcuseState.messages!, size: height));

          }
        }
      },
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
                cubit.getDataExcuseManagementID(id: id);
              },
              child: cubit.getExcuseManagementID ==null || cubit.userModel == null?Center(child: CircularProgressIndicator(color: Colors.white,)) : Form(
                key: formKey,
                child: ListView(
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        builtItem(
                          width: width * 0.2,
                          mainText: 'ID',
                          text: cubit.getExcuseManagementID!.data!.results!.hREXCUSEID!,
                          Width: width,
                          Height: height,
                        ),
                        builtItem(
                          width: width * 0.5,
                          mainText: 'Name',
                          text: cubit.getExcuseManagementID!.data!.results!.hremployeeFullname!,
                          Width: width,
                          Height: height,
                        ),
                      ],
                    ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        builtItem(
                          width: width * 0.3,
                          mainText: 'Reason Name',
                          text: cubit.getExcuseManagementID!.data!.results!.hrexcreasonName!,
                          Width: width,
                          Height: height,
                        ),
                        builtItem(
                          width: width * 0.5,
                          mainText: 'Status',
                          text: cubit.getExcuseManagementID!.data!.results!.hrexcuseStatusString!,
                          Width: width,
                          Height: height,
                          color: getStatusId(status: cubit.getExcuseManagementID!.data!.results!.hrexcuseStatusString!) == '2'? Colors.green :
                         getStatusId(status:  cubit.getExcuseManagementID!.data!.results!.hrexcuseStatusString!) == '0'? Colors.red:Colors.grey,
                          colorText: Colors.white,
                        ),
                      ],
                    ),
                    cubit.getExcuseManagementID!.data!.results!.hrexcreasonName! == 'Meeting'?  Column(
                      children: [

                        SizedBox(height: height*0.005,),
                        buildElevatedButton(
                          width: width,
                          height: height*0.06,
                          text: 'View Location',
                          fun: ()async{
                            final availableMaps = await MapLauncher.installedMaps;
                            print(availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

                            await availableMaps.first.showMarker(
                              coords: Coords(double.parse(cubit.getExcuseManagementID!.data!.results!.hrexcusePositionY!), double.parse(cubit.getExcuseManagementID!.data!.results!.hrexcusePositionX!)),
                              title: "Ocean Beach",
                            );
                          },
                          icon: Icons.location_on,
                          color: Colors.white,
                          colorText: Colors.black,
                        ),
                        SizedBox(height: height*0.015,),

                      ],
                    ):SizedBox(),



                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        builtItem(
                          width: width * 0.3,
                          mainText: 'Duration',
                          text: cubit.getExcuseManagementID!.data!.results!.hrexcuseDuration!,
                          Width: width,
                          Height: height,
                        ),
                        builtItem(
                          width: width * 0.5,
                          mainText: 'Duration Type',
                          text: cubit.getExcuseManagementID!.data!.results!.hrexcuseDurationTypeString!,
                          Width: width,
                          Height: height,
                        ),
                      ],
                    ),
                    builtItem(
                      width: width,
                      mainText: 'Description',
                      text: cubit.getExcuseManagementID!.data!.results!.hrexcuseDescription!,
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
                          text: cubit.getExcuseManagementID!.data!.results!.hrexcuseTime!,
                          Width: width,
                          Height: height,
                        ),
                        builtItem(
                          width: width * 0.5,
                          mainText: 'Date',
                          text: cubit.getExcuseManagementID!.data!.results!.hrexcuseDate!,
                          Width: width,
                          Height: height,
                        ),
                      ],
                    ),

                    Text(
                      'Department Status',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: kFontMain,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5),
                    ),
                    SizedBox(height: height*0.01,),
                    cubit.userModel!.data!.hremployee_excuses_approve_admin == 1 || cubit.userModel!.data!.hremployee_excuses_approve_manager == 1?
                    DropdownButtonFormField2(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      isExpanded: true,
                      hint:  Text(
                        cubit.getExcuseManagementID!.data!.results!.hrexcuseDepartmentStatusString!,
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.grey,
                      ),
                      iconSize: 30,
                      buttonHeight: height*0.07,
                      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),

                      itemHeight: height*0.07,
                      dropdownMaxHeight: height*0.22,
                      scrollbarThickness: 10,
                      scrollbarAlwaysShow: true,
                      scrollbarRadius: Radius.circular(15),
                      items: ['Pending Approval','Approval','Declined']
                          .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontFamily: kFontMain,
                          ),
                        ),
                      ))
                          .toList(),

                      onChanged: (value) {

                       cubit.getExcuseManagementID!.data!.results!.hrexcuseDepartmentStatus = getStatusId(status: value);

                      },
                      onSaved: (value) {
                        print('on saved: ${value}');


                      },

                    ):buildItemContainer(
                        width: width,
                        text: cubit.getExcuseManagementID!.data!.results!.hrexcuseDepartmentStatusString!,
                        Width: width,
                        Height: height,
                       center: false,
                    ),
                    SizedBox(height: height*0.01,),
                    Text(
                      'Department Note',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: kFontMain,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5),
                    ),
                    SizedBox(height: height*0.01,),
                    cubit.userModel!.data!.hremployee_excuses_approve_admin == 1 || cubit.userModel!.data!.hremployee_excuses_approve_manager == 1?
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.text,
                      controller: cubit.descriptionControllerDepartment,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'type something here.....',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15),

                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15),
                        ),


                      ),

                    ):buildItemContainer(
                      width: width,
                      text: cubit.descriptionControllerDepartment.text,
                      Width: width,
                      Height: height,
                      center: false,
                    ),
                    SizedBox(height: height*0.01,),

                    Text(
                      'HR Status',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: kFontMain,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5),
                    ),
                    SizedBox(height: height*0.01,),
                   cubit.userModel!.data!.hremployee_excuses_approve_admin == 1 || cubit.userModel!.data!.hremployee_excuses_approve_hr == 1?
                   DropdownButtonFormField2(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      isExpanded: true,
                      hint:  Text(
                        cubit.getExcuseManagementID!.data!.results!.hrexcuseHrStatusString!,
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.grey,
                      ),
                      iconSize: 30,
                      buttonHeight: height*0.07,
                      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),

                      itemHeight: height*0.07,
                      dropdownMaxHeight: height*0.22,
                      scrollbarThickness: 10,
                      scrollbarAlwaysShow: true,
                      scrollbarRadius: Radius.circular(15),
                      items: ['Pending Approval','Approval','Declined']
                          .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontFamily: kFontMain,
                          ),
                        ),
                      ))
                          .toList(),

                      onChanged: (value) {
                        cubit.getExcuseManagementID!.data!.results!.hrexcuseHrStatus = getStatusId(status: value);
                        print( cubit.getExcuseManagementID!.data!.results!.hrexcuseHrStatus);
                      },

                    ):buildItemContainer(
                       width: width,
                       text: cubit.getExcuseManagementID!.data!.results!.hrexcuseHrStatusString!,
                       Width: width,
                       Height: height,
                       center: false,
                   ),
                    SizedBox(height: height*0.01,),
                    Text(
                      'HR Note',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: kFontMain,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5),
                    ),
                    SizedBox(height: height*0.01,),
                    cubit.userModel!.data!.hremployee_excuses_approve_admin == 1 || cubit.userModel!.data!.hremployee_excuses_approve_hr == 1?
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.text,
                      controller: cubit.descriptionControllerHR,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'type something here.....',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15),

                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15),
                        ),


                      ),

                    ):buildItemContainer(
                        width: width,
                        text: cubit.descriptionControllerHR.text,
                        Width: width,
                        Height: height,
                      center: false,
                    ),

                    SizedBox(height: height*0.03,),
                    Center(
                      child: state is GetUpdateExcuseLoading? CircularProgressIndicator(color: Colors.white,) : ElevatedButton(
                        onPressed: () {

                        cubit.postUpdateExcuse(
                            id: id,

                            dep_status: cubit.getExcuseManagementID!.data!.results!.hrexcuseDepartmentStatus,
                            dep_note: cubit.descriptionControllerDepartment.text,

                            hr_status: cubit.getExcuseManagementID!.data!.results!.hrexcuseHrStatus,
                            hr_note: cubit.descriptionControllerHR.text,
                        ).then((value)async{
                          await Future.delayed(Duration(seconds: 1));
                          cubit.getDataExcuseManagementID(id: id);
                        });

                        },
                        child: Text('Apply',style: TextStyle(color: Colors.black,fontFamily: kFontMain,fontWeight: FontWeight.bold),),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: width*0.2,vertical: height*0.015),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          elevation: 7,
                          shadowColor: Colors.white,

                        ),
                      ),

                    ),

                    SizedBox(height: height*0.05,),


                  ],
                ),
              ),
            ),
          ),
        );
      },

    );
  }





}
