import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:qr_application/components/componants.dart';
import 'package:qr_application/models/excuses_managments_model.dart';

import '../constat/const.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import 'detailsEcxcusesManagement.dart';

class GetAllExcusesManagementsScreen extends StatelessWidget {
  const GetAllExcusesManagementsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int ind = 1;
    QrScannerCubit.get(context).getAllExcusesManagementData(page: 1);

    return BlocConsumer<QrScannerCubit, QrStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        var cubit = QrScannerCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text('Excuses Managements'),
            elevation: 8,
            shadowColor: Colors.white,
            backgroundColor: Colors.black,
          ),
          backgroundColor: Colors.black,
          body: Center(
            child: cubit.getAllExcusesManagement == null
                ? RefreshIndicator(
                    onRefresh: () async {
                      cubit.checkInternet(context);
                      cubit.getAllExcusesManagementData(page: 1);
                    },
                    child: ListView(
                      children: [
                        Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: height * 0.4,
                            ),
                            CircularProgressIndicator(
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Loading data please wait',
                              style: TextStyle(
                                  color: Colors.white70, fontFamily: kFontMain),
                            ),
                          ],
                        )),
                      ],
                    ),
                  )
                : cubit.getAllExcusesManagement!.data!.results!.length == 0
                    ? RefreshIndicator(
                        onRefresh: () async {
                          cubit.checkInternet(context);
                          cubit.getAllExcusesManagementData(page: 1);
                        },
                        child: ListView(
                          children: [
                            SizedBox(
                              height: height * 0.35,
                            ),
                            Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.pending_actions,
                                  size: 50,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'You don\'t have any Excuses Management yet',
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontFamily: kFontMain),
                                ),
                              ],
                            )),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          cubit.getAllExcusesManagementData(page: ind);

                        },
                        child: ListView(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // SizedBox(height: 20,),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: state is! GetExcusesManagementsLoading
                                  ? Container(
                                      height: height * 0.68,
                                      child: DataTable(
                                        headingTextStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: kFontMain),
                                        dataTextStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                        showCheckboxColumn: false,
                                        columnSpacing: width * 0.02,
                                        dataRowHeight: height * 0.072,
                                        border: TableBorder.all(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.white,
                                            width: 0.4),
                                        columns: const [
                                          DataColumn(
                                            label: Expanded(
                                              child: Text(
                                                "ID",
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Expanded(
                                              child: Text(
                                                "Name",
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Expanded(
                                              child: Text(
                                                'Reason',
                                                // style: TextStyle(fontStyle: FontStyle.italic),
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            numeric: false,
                                            label: Expanded(
                                              //  widthFactor: width*0.008,
                                              child: Text(
                                                "Status",
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Expanded(
                                              //  widthFactor: 1.9,
                                              child: Text(
                                                "Date",
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Expanded(
                                              //  widthFactor: 1,
                                              child: Text(
                                                "Time",
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                        rows: [
                                          ...cubit.getAllExcusesManagement!
                                              .data!.results!
                                              .map<DataRow>((e) {
                                            return DataRow(
                                              onSelectChanged: (b) {
                                                //cubit.userVerify();
                                                navigateTo(
                                                    context,
                                                    DetailsExcusesManagementScreen(
                                                      id: e.hREXCUSEID!,
                                                    ));
                                                cubit.getDataExcuseManagementID(
                                                    id: e.hREXCUSEID);
                                              },
                                              cells: <DataCell>[
                                                DataCell(
                                                  Center(
                                                    child: Text(e.hREXCUSEID!),
                                                  ),
                                                ),
                                                DataCell(
                                                  Center(
                                                    child: Text(
                                                        e.hremployeeFullname!),
                                                  ),
                                                ),
                                                DataCell(
                                                  Center(
                                                    child: Text(
                                                        e.hrexcreasonName!),
                                                  ),
                                                ),
                                                DataCell(
                                                  Container(
                                                    child: Center(
                                                      child: Text(e
                                                          .hrexcuseStatusString!),
                                                    ),
                                                    color: getStatusId(status: e
                                                        .hrexcuseStatusString!) == '2'? Colors.green:
                                                    getStatusId(status: e.hrexcuseStatusString) == '0'? Colors.red:Colors.grey,
                                                  ),
                                                ),
                                                DataCell(
                                                  Center(
                                                    child:
                                                        Text(e.hrexcuseDate!),
                                                  ),
                                                ),
                                                DataCell(
                                                  Center(
                                                    child:
                                                        Text(e.hrexcuseTime!),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }).toList(),
                                        ],
                                      ),
                                    )
                                  : Container(
                                      width: width,
                                      height: height * 0.68,
                                      child: Center(
                                          child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ))),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Container(
                              width: width,
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.02),
                              child: NumberPaginator(
                                numberPages: cubit
                                    .getAllExcusesManagement!.data!.pageMax!,
                                onPageChange: (int index) async {
                                  ind = index + 1;
                                  print(ind);
                                  print('============');
                                  print(index);

                                  await QrScannerCubit.get(context)
                                      .checkInternet(context)
                                      .then((value) {
                                    cubit.getAllExcusesManagementData(
                                        page: index + 1);
                                  });
                                },
                                // initially selected index
                                initialPage: ind - 1,
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
          ),
        );
      },
    );
  }
}
