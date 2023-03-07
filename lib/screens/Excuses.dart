import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_application/components/componants.dart';
import 'package:qr_application/constat/const.dart';
import 'package:qr_application/cubit/cubit.dart';
import 'package:qr_application/cubit/states.dart';

class Excuses extends StatelessWidget {

  static final GlobalKey<FormState>  formKey = GlobalKey<FormState>();
  var timeController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;



    return  BlocConsumer<QrScannerCubit,QrStates>(
        listener: (context,state){
          if(state is AddExcusesSuccess){
            if(state.addExcusesModel.hasError){
              showDialoog(context: context, num: 0, state: 'AddExc', widget: Message(message: state.addExcusesModel.errors, size: height));
            }else{
              showDialoog(context: context, num: 1, state: 'AddExc', widget: Message(message: state.addExcusesModel.messages, size: height));

            }
          }
        },

        builder: (context,state){
          var cubit = QrScannerCubit.get(context);

          if(cubit.excData == null){
            cubit.getExcReason();
          }
          return Scaffold(
              appBar: AppBar(
                title: Text('Add Excuses'),
                elevation: 2.0,
                shadowColor: Colors.white,
                backgroundColor: Colors.black,
              ),
              backgroundColor: Colors.black,
              body: cubit.excData != null? Padding(
                padding: EdgeInsets.all(width * 0.08),
                child: Form(
                  key: formKey,
                  child: ListView(
                    children: [
                      Text(
                        'Choose Reason Of Excuses',
                        style: TextStyle(color: Colors.white, fontFamily: kFontMain,fontSize: 17,fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: height*0.015,),
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
                        hint: const Text(
                          'Select Your Reason Excuses',
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
                        items: cubit.excData!.data!.listReason
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
                        validator: (value) {
                          if (value == null) {
                            return 'Please Select Reason Excuses';
                          }
                        },
                        onChanged: (value) {
                          cubit.selectedReason = value.toString();
                          print(cubit.selectedReason);
                        },
                        onSaved: (value) {
                          cubit.selectedReason = value.toString();


                        },

                      ),
                      SizedBox(height: height*0.02,),
                      Text(
                        'Duration',
                        style: TextStyle(color: Colors.white, fontFamily: kFontMain,fontSize: 17,fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: height*0.015,),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Colors.white),
                        validator: (value){
                          try{
                            if(int.parse(value.toString()) is! int){
                            }
                          }catch(error){
                            return 'Please Enter Number Only';
                          }


                        },
                        controller: timeController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
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
                          suffixIcon: Icon(Icons.access_time,color: Colors.grey,),

                        ),

                      ),
                      SizedBox(height: height*0.02,),
                      Text(
                        'Duration Type',
                        style: TextStyle(color: Colors.white, fontFamily: kFontMain,fontSize: 17,fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: height*0.015,),
                      DropdownButtonFormField2(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(

                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),

                          ),
                        ),
                        isExpanded: true,
                        hint: const Text(
                          'Select Your Duration Type',
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
                        items: cubit.keys
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
                        validator: (value) {
                          if (value == null) {
                            return 'Please Select Duration Type';
                          }
                        },
                        onChanged: (value) {
                          cubit.selectedDurationType = value.toString();
                        },
                        onSaved: (value) {
                          cubit.selectedDurationType = value.toString();


                        },
                      ),

                      SizedBox(height: height*0.02,),
                      Text(
                        'Description',
                        style: TextStyle(color: Colors.white, fontFamily: kFontMain,fontSize: 17,fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: height*0.015,),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,

                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.text,
                        controller: descriptionController,
                        maxLines: 4,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Please Enter Description';
                          }

                        },
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

                      ),


                      SizedBox(height: height*0.03,),
                      Center(
                        child: cubit.onClick?CircularProgressIndicator(color: Colors.white,):ElevatedButton(
                          onPressed: () async{

                            print(cubit.selectedReason);
                            print(cubit.selectedDurationType);
                             if(formKey.currentState!.validate()) {
                             //  print(selectedReason);
                             //  print(selectedDurationType);
                               if (cubit.onClick == false) {
                                 cubit.changeOnClick();
                                 cubit.checkServes(
                                     context: context, height: height).then((
                                     value) async {
                                   if (value) {

                                     int id=0;
                                     int meetingId=0;
                                     int duType = 0;
                                     cubit.excData!.data!.results.forEach((element) {

                                       if(element.excuses_reason_name == cubit.selectedReason){
                                         id = element.excusesReasonId;
                                         meetingId = element.excusesReason_meeting;
                                       }

                                     });

                                     for(int i =0 ; i<cubit.keys.length;i++){
                                       if(cubit.selectedDurationType == cubit.keys[i]){
                                         duType = i+1;
                                         break;
                                       }
                                     }

                                     print(id);
                                     print(duType);

                                    await cubit.addExcuses(
                                         id: id.toString(),
                                         meetingId: meetingId,
                                         duration: timeController.text,
                                         durationType: duType.toString(),
                                         description: descriptionController.text,
                                     ).then((value){
                                       print('Finaaaaaaaaaaaaaaaaly done');


                                     });
                                   } else {
                                     cubit.changeOnClick();
                                   }
                                 });
                               }
                             }
                          },
                          child: Text('Apply',style: TextStyle(color: Colors.black,fontFamily: kFontMain,fontWeight: FontWeight.bold),),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: width*0.2,vertical: height*0.015),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            elevation: 7,
                            shadowColor: Colors.white,

                          ),
                        ),

                      )
                    ],
                  ),
                ),
              ):Center(child: CircularProgressIndicator(color: Colors.white,),)
          );
        },


    );
  }
}
