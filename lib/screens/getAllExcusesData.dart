import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_application/components/componants.dart';
import 'package:qr_application/constat/const.dart';
import 'package:qr_application/cubit/cubit.dart';

import 'package:number_paginator/number_paginator.dart';
import 'package:qr_application/cubit/states.dart';
import 'package:qr_application/screens/details.dart';
import 'package:qr_application/screens/getAllExcusesManagemetsScreen.dart';

import '../network/end_points.dart';
import '../network/local/CashHelper.dart';
import 'Excuses.dart';

class GetAllExcuses extends StatelessWidget {
  const GetAllExcuses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    int ind = 1;
    QrScannerCubit.get(context).getAllExcusesData(page: 1);
    return BlocConsumer<QrScannerCubit, QrStates>(
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
            actions: [
              cubit.userModel!.data!.show?
              GestureDetector(
                onTap: () {
                  navigateTo(context, GetAllExcusesManagementsScreen());
                },
                child: Row(
                  children: const [
                    Text(
                      'Excuse Management',
                      style:
                          TextStyle(fontFamily: kFontMain, color: Colors.white),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.list_alt,
                      color: Colors.white,
                      size: 25,
                    ),
                  ],
                ),
              ):SizedBox(),
              cubit.userModel!.data!.show
                  ? SizedBox(
                      width: width * 0.24,
                    )
                  : SizedBox(),
              GestureDetector(
                      onTap: () {
                        navigateTo(context, Excuses());
                        cubit.getExcReason();
                      },
                      child: Row(
                        children: const [
                          Text(
                            'Add Excuse',
                            style: TextStyle(
                                fontFamily: kFontMain, color: Colors.green),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.post_add_sharp,
                            color: Colors.green,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
              SizedBox(
                width: 5,
              ),
            ],
            title: cubit.userModel!.data!.show ? null : Text('Excuses'),
            elevation: 8,
            shadowColor: Colors.white,
            backgroundColor: Colors.black,
          ),
          backgroundColor: Colors.black,
          body: Center(
            child: cubit.allExcuses == null
                ? RefreshIndicator(
                    onRefresh: () async {
                      cubit.checkInternet(context);
                      cubit.getAllExcusesData(page: 1);
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
                : cubit.allExcuses!.data!.results.length == 0
                    ? RefreshIndicator(
                        onRefresh: () async {
                          cubit.checkInternet(context);
                          cubit.getAllExcusesData(page: 1);
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
                                  'You don\'t have any Excuses yet',
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
                          cubit.getAllExcusesData(page: ind);
                        },
                        child: ListView(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // SizedBox(height: 20,),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: state is! GetAllExcusesLoading
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
                                          ...QrScannerCubit.get(context)
                                              .allExcuses!
                                              .data!
                                              .results
                                              .map<DataRow>((e) {
                                            return DataRow(
                                              onSelectChanged: (b) {
                                                cubit.getExcuseID(
                                                    id: e.HREXCUSEID);
                                                navigateTo(
                                                    context,
                                                    ExcuseDetailsScreen(
                                                      id: e.HREXCUSEID,
                                                    ));
                                              },
                                              cells: <DataCell>[
                                                DataCell(
                                                  Center(
                                                    child: Text(e.HREXCUSEID),
                                                  ),
                                                ),
                                                DataCell(
                                                  Center(
                                                    child: Text(
                                                        e.hrexcreason_name),
                                                  ),
                                                ),
                                                DataCell(
                                                  Container(
                                                    child: Center(
                                                      child: Text(
                                                        e.hrexcuse_status_string,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    color: getStatusId(
                                                                status: e
                                                                    .hrexcuse_status_string) ==
                                                            '2'
                                                        ? Colors.green
                                                        : getStatusId(
                                                                    status: e
                                                                        .hrexcuse_status_string) ==
                                                                '0'
                                                            ? Colors.red
                                                            : Colors.grey,
                                                  ),
                                                ),
                                                DataCell(
                                                  Center(
                                                    child:
                                                        Text(e.hrexcuse_date),
                                                  ),
                                                ),
                                                DataCell(
                                                  Center(
                                                    child:
                                                        Text(e.hrexcuse_time),
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
                                numberPages: cubit.allExcuses!.data!.maxPage,
                                onPageChange: (int index) {
                                  ind = index + 1;
                                  print(ind);
                                  print('============');
                                  print(index);
                                  QrScannerCubit.get(context)
                                      .checkInternet(context)
                                      .then((value) {
                                    QrScannerCubit.get(context)
                                        .getAllExcusesData(page: index + 1);
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
