import 'dart:async';
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_dashboard/TabPage/TabLeftSideMainCont/TabLeftOtherScrollView.dart';
import 'package:smart_dashboard/theme/change_theme_button_widget.dart';
import 'package:smart_dashboard/theme/theme_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final databaseReference = FirebaseDatabase.instance.reference();

class TabLeftMainTitleContainer extends StatefulWidget {
  @override
  _TabLeftMainTitleContainerState createState() =>
      _TabLeftMainTitleContainerState();
}

class _TabLeftMainTitleContainerState extends State<TabLeftMainTitleContainer>
    with WidgetsBindingObserver {
  var task;
  var taskValue;
  List data = [];
  List fanData = [];
  List dataValue = [];
  List boolStatusValue = [];
  List fanDataValue = [];
  List<Container> buttonsList = List<Container>();
  List<Container> buttonsList1 = List<Container>();
  String title;
  bool result = false;
  bool result2 = false;
  Color c;
  bool isSwitched;
  Timer timer;
  List name = [];
  List pg = [];
  String buttonName;
  String localIp;
  bool eBill = false;
  var dataJson;
  //String ip_Local;
  SharedPreferences loginData;
  String ip;
  String username;
  bool notifier = false;
  bool mobNotifier = false;
  String userName = " ";
  String ipAddress = " ";
  ConnectivityResult netResult = ConnectivityResult.none;
  bool hasInternet = false;
  String ipLocal = " ";
  List<String> localDataVal = [];
  List<String> dumVariable = [];
  var count = 0;
  String up;
  var ownerId;
  String authKey = " ";
  var smartHome;
  var doorData;
  bool bothOffOn;
  String phoneNumber = " ";
  String email = " ";
  bool noLocalServer;
  var localServer;
  var personalDataJson;
  String onlineIp = " ";
  bool owner = false;
  bool smartDoor = false;


  List<Widget> _buildButtonsWithNames() {
    buttonsList.clear();
    // print("data.button  ${data.length}");

    for (int i = 0; i < data.length; i++) {
      buttonOffline(i);
    }
      buttonsList = buttonsList.toSet().toList();
    return buttonsList;
  }

  _buildFanSlideWithNames(){
    buttonsList1.clear();
    // print("data in fan slide  ${fanData.length}");

      // print("data.length %%%%%%%%%%%%%%  ${data.length}");
    if(fanData.isNotEmpty){
      // print("data");
      for(int i = 0; i < fanData.length; i++) {
        // print("im inside the build button");
        // print(i);
        // print(fanData[i]);
        fanSlide(i);
      }
    }
      buttonsList1 = buttonsList1.toSet().toList();

    return buttonsList1;
  }

  void fanSlide(int i) {
    if (task.data == "Select Room") {
      Container(
        height: MediaQuery.of(context).size.height * 0.010,
        width: MediaQuery.of(context).size.width * 1.0,
        child: Center(
          child: Text("Please Select Room "),
        ),
      );
    } else if (fanDataValue[i]["Device_Type"].toString().contains("Fan") && fanData[i] == task.data) {
      buttonsList1.add(Container(
        child: Container(
            margin: EdgeInsets.all(5.0),
            padding: EdgeInsets.all(20.0),
            height: MediaQuery.of(context).size.height * 0.22,
            width: MediaQuery.of(context).size.width * 0.25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    /*Text(data[i].toString().split("Slide")[0].replaceAll("_", " "),
                      style: GoogleFonts.robotoSlab(color: Colors.black)),*/
                    Text(fanDataValue[i]["Fan_Name"].toString(),
                                      style: GoogleFonts.poppins(
                                          color: Theme.of(context).backgroundColor,
                                          fontSize: MediaQuery.of(context).size.height * 0.018),),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.050,
                      width: MediaQuery.of(context).size.width * 0.03,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(247, 179, 28, 0.19),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Center(
                        child: SvgPicture.asset(
                          "images/icons/fan.svg",
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: Slider(
                    activeColor: Colors.yellowAccent,
                    inactiveColor: Colors.grey[500],
                    value: double.parse(fanDataValue[i]["Fan_Speed"].toString()),
                    min: 0,
                    max: 5,
                    divisions: 5,
                    label: fanDataValue[i]["Fan_Speed"].toString().substring(0, 1),
                    onChangeEnd: (double value) {
                      setState(() {
                        updateValue(
                            fanDataValue[i]["id"],
                            fanDataValue[i]["Fan_Name"],
                            fanDataValue[i]["Fan_Status"],
                            fanDataValue[i]["Fan_Speed"]);
                        //updateValue(dataValue[i]["id"], status)
                      });
                      // check().then((intenet) {
                      //   if (intenet) {
                      //     // Internet Present Case
                      //
                      //     setState(() {
                      //       dataValue[0][i] = value.toInt().toString();
                      //       /*update_value(data[i], data_value[0][i], i);
                      //     _buildButtonsWithNames();*/
                      //     });
                      //     //print("Connection: present");
                      //   } else {
                      //     showDialog(
                      //         context: context,
                      //         builder: (_) => AlertDialog(
                      //           backgroundColor: Colors.black,
                      //           title: Text(
                      //             "No Internet Connection",
                      //             style: TextStyle(color: Colors.white),
                      //           ),
                      //           content: Text(
                      //               "Please check your Internet Connection",
                      //               style: TextStyle(color: Colors.white)),
                      //         ));
                      //   }
                      //   setState(() {
                      //     updateValue(data[i], dataValue[0][i], i);
                      //     _buildButtonsWithNames();
                      //   });
                      // });
                    },
                    onChanged: (double value) {
                      //print("value of fan is $value");
                      setState(() {
                        fanDataValue[i]["Fan_Speed"] = value;
                        //print("datavalue is ${dataValue[i]["Fan_Speed"]}");
                      });
                    },
                  ),
                )
              ],
            )),
      ));
    }

  }

  // buttonOffline(int i) {
  //   if (dataValue[i]["Device_Type"].toString().contains("Light") &&
  //       data[i].toString() == task.data) {
  //     //print("im inside the button above button list container ${dataValue[i]}");
  //     // print("$buttonsList ");
  //     buttonsList.add(Container(
  //       child: InkWell(
  //           onTap: () {
  //             setState(() {
  //               timeCount = 1;
  //               dataValue[i]["Device_Status"] = !dataValue[i]["Device_Status"];
  //               updateValue(dataValue[i]["id"], dataValue[i]["Device_Name"],
  //                   dataValue[i]["Device_Status"], 0);
  //             });
  //           },
  //           child: Container(
  //               margin: EdgeInsets.all(5.0),
  //               padding: EdgeInsets.all(20.0),
  //               height: MediaQuery.of(context).size.height * 0.20,
  //               width: MediaQuery.of(context).size.width * 0.12,
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(25.0),
  //                 color: (dataValue[i]["Device_Status"] == false)
  //                     ? Theme.of(context).scaffoldBackgroundColor
  //                     : Color.fromRGBO(247, 179, 28, 1.0),
  //               ),
  //               child: SingleChildScrollView(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Container(
  //                       height: MediaQuery.of(context).size.height * 0.060,
  //                       width: MediaQuery.of(context).size.width * 0.04,
  //                       decoration: BoxDecoration(
  //                           color: (dataValue[i]["Device_Status"] == false)
  //                               ? Color.fromRGBO(247, 179, 28, 0.19)
  //                               : Theme.of(context).canvasColor,
  //                           borderRadius: BorderRadius.circular(15.0)),
  //                       child: Center(
  //                         child: SvgPicture.asset(
  //                           "images/icons/light.svg",
  //                           height: MediaQuery.of(context).size.height * 0.035,
  //                         ),
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       height: MediaQuery.of(context).size.height * 0.010,
  //                     ),
  //                     (dataValue[i]["Device_Status"] == true)
  //                         ? Text(
  //                             dataValue[i]["Device_Name"],
  //                             style: GoogleFonts.poppins(
  //                                 color: (dataValue[i]["Device_Status"] == false)
  //                                     ? Theme.of(context).backgroundColor
  //                                     : Theme.of(context).cardColor,
  //                                 fontSize:
  //                                     MediaQuery.of(context).size.height * 0.016),
  //                           )
  //                         : Text(
  //                             dataValue[i]["Device_Name"],
  //                             style: GoogleFonts.poppins(
  //                                 color: (dataValue[i]["Device_Status"] == false)
  //                                     ? Theme.of(context).backgroundColor
  //                                     : Theme.of(context).cardColor,
  //                                 fontSize:
  //                                     MediaQuery.of(context).size.height * 0.016),
  //                           ),
  //                     (dataValue[i]["Device_Status"] == false)
  //                         ? Text(
  //                             "off",
  //                             style: GoogleFonts.poppins(
  //                                 color: (dataValue[i]["Device_Status"] == false)
  //                                     ? Theme.of(context).backgroundColor
  //                                     : Theme.of(context).cardColor,
  //                                 fontSize:
  //                                     MediaQuery.of(context).size.height * 0.015),
  //                           )
  //                         : Text(
  //                             "On",
  //                             style: GoogleFonts.poppins(
  //                                 color: (dataValue[i]["Device_Status"] == false)
  //                                     ? Theme.of(context).backgroundColor
  //                                     : Theme.of(context).cardColor,
  //                                 fontSize:
  //                                     MediaQuery.of(context).size.height * 0.015),
  //                           ),
  //                   ],
  //                 ),
  //               ))),
  //     ));
  //   }
  //   else if (dataValue[i]["Device_Type"].toString().contains("Valve") &&
  //       data[i].toString() == task.data) {
  //     //print("im inside the button above button list container ${dataValue[i]}");
  //     // print("$buttonsList ");
  //     buttonsList.add(Container(
  //       child: InkWell(
  //           onTap: () {
  //             setState(() {
  //               dataValue[i]["Device_Status"] = !dataValue[i]["Device_Status"];
  //               //print(dataValue[i]["Device_Status"]);
  //               updateValue(dataValue[i]["id"], dataValue[i]["Device_Name"],
  //                   dataValue[i]["Device_Status"], 0);
  //             });
  //           },
  //           child: Container(
  //               margin: EdgeInsets.all(5.0),
  //               padding: EdgeInsets.all(20.0),
  //               height: MediaQuery.of(context).size.height * 0.20,
  //               width: MediaQuery.of(context).size.width * 0.12,
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(25.0),
  //                 color: (dataValue[i]["Device_Status"] == false)
  //                     ? Theme.of(context).scaffoldBackgroundColor
  //                     : Color.fromRGBO(247, 179, 28, 1.0),
  //               ),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   Container(
  //                     height: MediaQuery.of(context).size.height * 0.08,
  //                     width: MediaQuery.of(context).size.width * 0.25,
  //                     child: SvgPicture.asset(
  //                       "images/valve.svg",
  //                       height: MediaQuery.of(context).size.height * 0.010,
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: MediaQuery.of(context).size.height * 0.015,
  //                   ),
  //                   Container(
  //                     child: Column(
  //                       children: [
  //                         AutoSizeText(
  //                           dataValue[i]["Device_Name"].toString(),
  //                           style: GoogleFonts.robotoSlab(
  //                               /*fontSize: 12,*/ color: Colors.white),
  //                           maxLines: 1,
  //                           minFontSize: 7,
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ))),
  //     ));
  //   }
  //   else if (dataValue[i]["Device_Type"].toString().contains("Switch") &&
  //       data[i].toString() == task.data) {
  //     buttonsList.add(Container(
  //         child: InkWell(
  //             onTap: () {
  //               setState(() {
  //                 dataValue[i]["Device_Status"] = !dataValue[i]["Device_Status"];
  //                 updateValue(dataValue[i]["id"], dataValue[i]["Device_Name"], dataValue[i]["Device_Status"], 0);
  //                 //updateValue(dataValue[i]["id"],dataValue[i]["Device_Status"]);
  //               });
  //             },
  //             child: Container(
  //                 // height: MediaQuery.of(context).size.height * 0.12,
  //                 // width: MediaQuery.of(context).size.width * 0.265,
  //             margin: EdgeInsets.all(5.0),
  //             padding: EdgeInsets.all(20.0),
  //             height: MediaQuery.of(context).size.height * 0.20,
  //             width: MediaQuery.of(context).size.width * 0.12,
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(25.0),
  //               color: (dataValue[i]["Device_Status"] == false)
  //                   ? Theme.of(context).scaffoldBackgroundColor
  //                   : Color.fromRGBO(247, 179, 28, 1.0),
  //             ),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Container(
  //                       height: MediaQuery.of(context).size.height * 0.060,
  //                       width: MediaQuery.of(context).size.width * 0.04,
  //                       decoration: BoxDecoration(
  //                           color: (dataValue[i]["Device_Status"] == false)
  //                               ? Color.fromRGBO(247, 179, 28, 0.19)
  //                               : Theme.of(context).canvasColor,
  //                           borderRadius: BorderRadius.circular(15.0)),
  //                       child: Center(
  //                         child: dataValue[i]["Device_Name"].toString().contains("TV")
  //                             ? Image(
  //                           image: AssetImage(
  //                             "images/tv.png",
  //                           ),
  //                           color: Color.fromRGBO(247, 179, 28, 1.0),
  //                           height:
  //                           MediaQuery.of(context).size.height * 0.035,
  //                         )
  //                             : dataValue[i]["Device_Name"]
  //                             .toString()
  //                             .contains("Home Theatre")
  //                             ? Image(
  //                           image: AssetImage(
  //                             "images/home-theater.png",
  //                           ),
  //                           color: Color.fromRGBO(247, 179, 28, 1.0),
  //                           height: MediaQuery.of(context).size.height *
  //                               0.035,
  //                         )
  //                             : dataValue[i]["Device_Name"]
  //                             .toString()
  //                             .contains("Ac")
  //                             ? Image(
  //                           image: AssetImage(
  //                             "images/ac.png",
  //                           ),
  //                           color: Color.fromRGBO(247, 179, 28, 1.0),
  //                           height:
  //                           MediaQuery.of(context).size.height *
  //                               0.035,
  //                         )
  //                             : dataValue[i]["Device_Name"]
  //                             .toString()
  //                             .contains("Heater")
  //                             ? Image(
  //                           image: AssetImage(
  //                             "images/water-heater.png",
  //                           ),
  //                           color: Color.fromRGBO(247, 179, 28, 1.0),
  //                           height: MediaQuery.of(context)
  //                               .size
  //                               .height *
  //                               0.035,
  //                         )
  //                             : dataValue[i]["Device_Name"]
  //                             .toString()
  //                             .contains("Printer")
  //                             ? Image(
  //                           image: AssetImage(
  //                             "images/printer.png",
  //                           ),
  //                           color: Color.fromRGBO(247, 179, 28, 1.0),
  //                           height: MediaQuery.of(context)
  //                               .size
  //                               .height *
  //                               0.035,
  //                         )
  //                             : Image(
  //                           image: AssetImage(
  //                             "images/socket.png",
  //                           ),
  //                           color: Color.fromRGBO(247, 179, 28, 1.0),
  //                           height: MediaQuery.of(context)
  //                               .size
  //                               .height *
  //                               0.035,
  //                         ),
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       height: MediaQuery.of(context).size.height * 0.010,
  //                     ),
  //                     (dataValue[i]["Device_Status"] == true)
  //                         ? Text(
  //                       dataValue[i]["Device_Name"],
  //                       style: GoogleFonts.poppins(
  //                           color: (dataValue[i]["Device_Status"] == false)
  //                               ? Theme.of(context).backgroundColor
  //                               : Theme.of(context).cardColor,
  //                           fontSize:
  //                           MediaQuery.of(context).size.height * 0.016),
  //                     )
  //                         : Text(
  //                       dataValue[i]["Device_Name"],
  //                       style: GoogleFonts.poppins(
  //                           color: (dataValue[i]["Device_Status"] == false)
  //                               ? Theme.of(context).backgroundColor
  //                               : Theme.of(context).cardColor,
  //                           fontSize:
  //                           MediaQuery.of(context).size.height * 0.016),
  //                     ),
  //                     (dataValue[i]["Device_Status"] == false)
  //                         ? Text(
  //                       "off",
  //                       style: GoogleFonts.poppins(
  //                           color: (dataValue[i]["Device_Status"] == false)
  //                               ? Theme.of(context).backgroundColor
  //                               : Theme.of(context).cardColor,
  //                           fontSize:
  //                           MediaQuery.of(context).size.height * 0.015),
  //                     )
  //                         : Text(
  //                       "On",
  //                       style: GoogleFonts.poppins(
  //                           color: (dataValue[i]["Device_Status"] == false)
  //                               ? Theme.of(context).backgroundColor
  //                               : Theme.of(context).cardColor,
  //                           fontSize:
  //                           MediaQuery.of(context).size.height * 0.015),
  //                     ),
  //                   ],
  //                 )))));
  //   }
  // }

  buttonOffline(int i) {
    if (dataValue[i]["Device_Type"].toString().contains("Light") &&
        data[i].toString() == task.data) {
      //print("im inside the button above button list container ${dataValue[i]}");
      // print("$buttonsList ");
      buttonsList.add(Container(
        child: InkWell(
            onTap: () {
              setState(() {
                dataValue[i]["Device_Status"] = !dataValue[i]["Device_Status"];
                updateValue(dataValue[i]["id"], dataValue[i]["Device_Name"],
                    dataValue[i]["Device_Status"], 0);
              });
            },
            child: Container(
                margin: EdgeInsets.all(5.0),
                padding: EdgeInsets.all(20.0),
                height: MediaQuery.of(context).size.height * 0.20,
                width: MediaQuery.of(context).size.width * 0.12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: (boolStatusValue[i] == false)
                      ? Theme.of(context).scaffoldBackgroundColor
                      : Color.fromRGBO(247, 179, 28, 1.0),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.060,
                        width: MediaQuery.of(context).size.width * 0.04,
                        decoration: BoxDecoration(
                            color: (boolStatusValue[i] == false)
                                ? Color.fromRGBO(247, 179, 28, 0.19)
                                : Theme.of(context).canvasColor,
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Center(
                          child: SvgPicture.asset(
                            "images/icons/light.svg",
                            height: MediaQuery.of(context).size.height * 0.035,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.010,
                      ),
                      (boolStatusValue[i] == true)
                          ? Text(
                              dataValue[i]["Device_Name"],
                              style: GoogleFonts.poppins(
                                  color: (boolStatusValue[i] == false)
                                      ? Theme.of(context).backgroundColor
                                      : Theme.of(context).cardColor,
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.016),
                            )
                          : Text(
                              dataValue[i]["Device_Name"],
                              style: GoogleFonts.poppins(
                                  color: (boolStatusValue[i] == false)
                                      ? Theme.of(context).backgroundColor
                                      : Theme.of(context).cardColor,
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.016),
                            ),
                      (boolStatusValue[i] == false)
                          ? Text(
                              "off",
                              style: GoogleFonts.poppins(
                                  color: (boolStatusValue[i] == false)
                                      ? Theme.of(context).backgroundColor
                                      : Theme.of(context).cardColor,
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.015),
                            )
                          : Text(
                              "On",
                              style: GoogleFonts.poppins(
                                  color: (boolStatusValue[i] == false)
                                      ? Theme.of(context).backgroundColor
                                      : Theme.of(context).cardColor,
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.015),
                            ),
                    ],
                  ),
                ))),
      ));
    }
    else if (dataValue[i]["Device_Type"].toString().contains("Valve") &&
        data[i].toString() == task.data) {
      //print("im inside the button above button list container ${dataValue[i]}");
      // print("$buttonsList ");
      buttonsList.add(Container(
        child: InkWell(
            onTap: () {
              setState(() {
                dataValue[i]["Device_Status"] = !dataValue[i]["Device_Status"];
                //print(dataValue[i]["Device_Status"]);
                updateValue(dataValue[i]["id"], dataValue[i]["Device_Name"],
                    dataValue[i]["Device_Status"], 0);
              });
            },
            child: Container(
                margin: EdgeInsets.all(5.0),
                padding: EdgeInsets.all(20.0),
                height: MediaQuery.of(context).size.height * 0.20,
                width: MediaQuery.of(context).size.width * 0.12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: (boolStatusValue[i] == false)
                      ? Theme.of(context).scaffoldBackgroundColor
                      : Color.fromRGBO(247, 179, 28, 1.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: SvgPicture.asset(
                        "images/valve.svg",
                        height: MediaQuery.of(context).size.height * 0.010,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                    Container(
                      child: Column(
                        children: [
                          AutoSizeText(
                            dataValue[i]["Device_Name"].toString(),
                            style: GoogleFonts.robotoSlab(
                                /*fontSize: 12,*/ color: Colors.white),
                            maxLines: 1,
                            minFontSize: 7,
                          )
                        ],
                      ),
                    ),
                  ],
                ))),
      ));
    }
    else if (dataValue[i]["Device_Type"].toString().contains("Switch") &&
        data[i].toString() == task.data) {
      buttonsList.add(Container(
          child: InkWell(
              onTap: () {
                setState(() {
                  dataValue[i]["Device_Status"] = !dataValue[i]["Device_Status"];
                  updateValue(dataValue[i]["id"], dataValue[i]["Device_Name"], dataValue[i]["Device_Status"], 0);
                  //updateValue(dataValue[i]["id"],dataValue[i]["Device_Status"]);
                });
              },
              child: Container(
                  // height: MediaQuery.of(context).size.height * 0.12,
                  // width: MediaQuery.of(context).size.width * 0.265,
              margin: EdgeInsets.all(5.0),
              padding: EdgeInsets.all(20.0),
              height: MediaQuery.of(context).size.height * 0.20,
              width: MediaQuery.of(context).size.width * 0.12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: (boolStatusValue[i] == false)
                    ? Theme.of(context).scaffoldBackgroundColor
                    : Color.fromRGBO(247, 179, 28, 1.0),
              ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.060,
                        width: MediaQuery.of(context).size.width * 0.04,
                        decoration: BoxDecoration(
                            color: (boolStatusValue[i] == false)
                                ? Color.fromRGBO(247, 179, 28, 0.19)
                                : Theme.of(context).canvasColor,
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Center(
                          child: dataValue[i]["Device_Name"].toString().contains("TV")
                              ? Image(
                            image: AssetImage(
                              "images/tv.png",
                            ),
                            color: Color.fromRGBO(247, 179, 28, 1.0),
                            height:
                            MediaQuery.of(context).size.height * 0.035,
                          )
                              : dataValue[i]["Device_Name"]
                              .toString()
                              .contains("Home Theatre")
                              ? Image(
                            image: AssetImage(
                              "images/home-theater.png",
                            ),
                            color: Color.fromRGBO(247, 179, 28, 1.0),
                            height: MediaQuery.of(context).size.height *
                                0.035,
                          )
                              : dataValue[i]["Device_Name"]
                              .toString()
                              .contains("Ac")
                              ? Image(
                            image: AssetImage(
                              "images/ac.png",
                            ),
                            color: Color.fromRGBO(247, 179, 28, 1.0),
                            height:
                            MediaQuery.of(context).size.height *
                                0.035,
                          )
                              : dataValue[i]["Device_Name"]
                              .toString()
                              .contains("Heater")
                              ? Image(
                            image: AssetImage(
                              "images/water-heater.png",
                            ),
                            color: Color.fromRGBO(247, 179, 28, 1.0),
                            height: MediaQuery.of(context)
                                .size
                                .height *
                                0.035,
                          )
                              : dataValue[i]["Device_Name"]
                              .toString()
                              .contains("Printer")
                              ? Image(
                            image: AssetImage(
                              "images/printer.png",
                            ),
                            color: Color.fromRGBO(247, 179, 28, 1.0),
                            height: MediaQuery.of(context)
                                .size
                                .height *
                                0.035,
                          )
                              : Image(
                            image: AssetImage(
                              "images/socket.png",
                            ),
                            color: Color.fromRGBO(247, 179, 28, 1.0),
                            height: MediaQuery.of(context)
                                .size
                                .height *
                                0.035,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.010,
                      ),
                      (boolStatusValue[i] == true)
                          ? Text(
                        dataValue[i]["Device_Name"],
                        style: GoogleFonts.poppins(
                            color: (boolStatusValue[i] == false)
                                ? Theme.of(context).backgroundColor
                                : Theme.of(context).cardColor,
                            fontSize:
                            MediaQuery.of(context).size.height * 0.016),
                      )
                          : Text(
                        dataValue[i]["Device_Name"],
                        style: GoogleFonts.poppins(
                            color: (boolStatusValue[i] == false)
                                ? Theme.of(context).backgroundColor
                                : Theme.of(context).cardColor,
                            fontSize:
                            MediaQuery.of(context).size.height * 0.016),
                      ),
                      (boolStatusValue[i] == false)
                          ? Text(
                        "off",
                        style: GoogleFonts.poppins(
                            color: (boolStatusValue[i] == false)
                                ? Theme.of(context).backgroundColor
                                : Theme.of(context).cardColor,
                            fontSize:
                            MediaQuery.of(context).size.height * 0.015),
                      )
                          : Text(
                        "On",
                        style: GoogleFonts.poppins(
                            color: (boolStatusValue[i] == false)
                                ? Theme.of(context).backgroundColor
                                : Theme.of(context).cardColor,
                            fontSize:
                            MediaQuery.of(context).size.height * 0.015),
                      ),
                    ],
                  )))));
    }
  }

  updateValue(id, name, status, speed){
    //print("im inside the update ");
    if (ip.toString() != 'false') {
      setState(() {
        if (name == "Fan") {
          int fan_speed = speed.toInt();

          http.put(
            Uri.parse('http://$ip/fan/$id/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, int>{
              'Fan_Speed': fan_speed,
            }),
          );
        } else {
          http.put(
            Uri.parse('http://$ip/$id/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, bool>{
              'Device_Status': status,
            }),
          ).then((value) => statusValue());

          // print("hello world");
          // statusValue();
        }
        result = true;
      });

      // if (response.statusCode == 200) {
      // setState(() {
      //   result = true;
      //   //print("im inside the update the value");
      // });
    } else if (ip.toString() == 'false') {
      // databaseReference.child(auth.currentUser.uid).update({
      //   button : buttonValue
      // });
      //print("im inside the update state ");
      if (name == "Fan") {
        int fan_speed = speed.toInt();

        // databaseReference.child(auth.currentUser.uid).child('SmartHome').child('Fan').child('Id$id').update({
        databaseReference
            .child(authKey)
            .child('SmartHome')
            .child('Fan')
            .child('Id$id')
            .update({
          'Fan_Speed': fan_speed,
        });
        setState(() {
          result = true;
        });
      } else {
        databaseReference
            .child(authKey)
            .child('SmartHome')
            .child('Devices')
            .child('Id$id')
            .update({
          'Device_Status': status,
        });
        setState(() {
          result = true;
        });
      }
    }
  }

  call() async {
    if(ip != null){
      if (ip.toString() != 'false'){
        print("ip in call $ip");
        print("ip in call ${ip != null}");
        final response = await http.get(Uri.parse("http://$ip/"));
        final fanResponse = await http.get(Uri.parse("http://$ip/fan/"));

        var val = jsonDecode(response.body);
        var fan = jsonDecode(fanResponse.body);

        setState(() {
          data.clear();
          fanData.clear();
          //data = val["Room"];
          for (int i = 0; i < val.length; i++)
          {
            data.add(val[i]["Room"]);
          }
          for (int i = 0; i < fan.length; i++) {
            // print(task.data);
            // print(fan.length);

            fanData.add(fan[i]["Room"]);

          }
          result = true;
          //print("$data inside the value of setstate in if case");
        });
        return response;
      }
      else if (ip.toString() == 'false'){

        Future.delayed(const Duration(milliseconds: 500), () {
          var val = smartHome['Devices'];
          var fanVal = smartHome['Fan'];

          setState(() {
            data.clear();
            fanData.clear();
            for (int i = 1; i <= val.length; i++) {
              data.add(val['Id$i']["Room"]);
            }
            for (int i = 1; i <= fanVal.length; i++) {
              fanData.add(fanVal['Id$i']["Room"]);

            }

            result = true;
          });
        });
      }
    }else{
      // fireData();
      initial();
    }
  }




  callValue() async {
    if (ip.toString() != 'false') {
      final response = await http.get(Uri.parse("http://$ip/"));
      final fanResponse = await http.get(Uri.parse("http://$ip/fan/"));
      var val = jsonDecode(response.body);
      var fan = jsonDecode(fanResponse.body);
      // print("value in cal by is $val");
      setState(() {
        dataValue.clear();
        fanDataValue.clear();

        for (int i = 0; i < val.length; i++) {
          dataValue.add(val[i]);
        }

        for (int i = 0; i < fan.length; i++) {
            fanDataValue.add(fan[i]);
        }
        result2 = true;
      });
      return true;
    } else if (ip.toString() == 'false') {
      //print("im inside the else if of call_value() ");
      Future.delayed(const Duration(milliseconds: 500), () {
        var val = smartHome['Devices'];
        var fanVal = smartHome['Fan'];
        setState(() {
          dataValue.clear();
          fanDataValue.clear();

          for (int i = 1; i <= val.length; i++) {
            dataValue.add(val['Id$i']);
          }
          for (int i = 1; i <= fanVal.length; i++) {
              fanDataValue.add(fanVal['Id$i']);
            // if (task.data.toString().replaceAll("_", " ") ==
            //     fanVal['Id$i']["Room"]) {
            //   // dataValue.add(fanVal['Id$i']);
            //   fanDataValue.add(fanVal['Id$i']);
            // }
          }
          //dataValue;
          //print("dataValues is $dataValue ");
          result2 = true;
          //print("$dataValue the data value inside the call_by setsstate");
        });
      });
    }
  }

  statusValue() async {
    if (ip.toString() != 'false') {
      final response = await http.get(Uri.parse("http://$ip/"));
      // final fanResponse = await http.get(Uri.parse("http://$ip/fan/"));
      var val = jsonDecode(response.body);
      // var fan = jsonDecode(fanResponse.body);
      // print("value in cal by is $val Status value ");
      setState(() {
        boolStatusValue.clear();

        for (int i = 0; i < val.length; i++)
        {
          boolStatusValue.add(val[i]["Device_Status"]);
        }
        // print(boolStatusValue);
      });
    } else if (ip.toString() == 'false') {
      //print("im inside the else if of call_value() ");
      Future.delayed(const Duration(milliseconds: 500), () {
        var val = smartHome['Devices'];
        var fanVal = smartHome['Fan'];
        setState(() {
          dataValue.clear();
          boolStatusValue.clear();
          fanDataValue.clear();

          for (int i = 1; i <= val.length; i++) {
            dataValue.add(val['Id$i']);
            boolStatusValue.add(val[i]);
          }
          for (int i = 1; i <= fanVal.length; i++) {
            fanDataValue.add(fanVal['Id$i']);
            // if (task.data.toString().replaceAll("_", " ") ==
            //     fanVal['Id$i']["Room"]) {
            //   // dataValue.add(fanVal['Id$i']);
            //   fanDataValue.add(fanVal['Id$i']);
            // }
          }
          //dataValue;
          //print("dataValues is $dataValue ");
          // result2 = true;
          //print("$dataValue the data value inside the call_by setsstate");
        });
      });
    }
  }

  initial() async {
    loginData = await SharedPreferences.getInstance();
    setState(() {
      ip = loginData.getString('ip') ?? null;
      if(ip == "null")
      {
        firstProcess();
      }else{
        call().then((value) {
              callValue();
              statusValue();
          });
      }

    });
  }

  firstProcess() async {
    loginData = await SharedPreferences.getInstance();
    setState(() {
      authKey = loginData.getString('ownerId');
      fireData();
    });
  }

  checkData() async {
    //print("im inside the check data of first page");
    loginData = await SharedPreferences.getInstance();
    if (ipLocal == "false") {
      loginData.setString('ip', ipLocal);
      loginData.setString('onlineIp', onlineIp);
      initial();
    } else {
      loginData.setString('ip', ipLocal);
      loginData.setString('onlineIp', onlineIp);
      initial();
    }
  }

  Future<void> fireData() async {
    databaseReference.child(authKey).once().then((snap) async {
      dataJson = snap.snapshot.value;
      setState(() {
        bothOffOn = dataJson['localServer']['BothOfflineAndOnline'];
        noLocalServer = dataJson['noLocalServer'];
        localServer = dataJson['localServer'];

        if (noLocalServer != true) {
          if (bothOffOn == true) {
            ipLocal = localServer['offlineIp'].toString();
            onlineIp = localServer['staticIp'].toString();
            //print("im inside the  firedata on individual on line: 1417 on page page ");
            checkData();
            //firebase ****************
          } else {
            ipLocal = dataJson['offlineIp'].toString();
            onlineIp = "false";
            checkData();
            //print("im inside the else of both on and off ");
          }
        } else {
          ip = "false";
          smartHome = dataJson['SmartHome'];
          call();
        }
      });
    });
  }

  Future getName() async {
    //print("im inside the getname of list funtion");
    // print("data is 8888888888888888888888888888888888 $data");
    for (int i = 0; i < data.length; i++) {
      if (data[i].toString().contains("Admin Room") &&
          (!name.contains(data[i].toString().contains("Admin Room")))) {
        name.add("Admin Room");
        pg.add("Admin Room");
      } else if (data[i].toString().contains("Hall") &&
          (!name.contains(data[i].toString().contains("Hall")))) {
        name.add("Hall");
        pg.add("Hall");
      } else if (data[i].toString().contains("Living Room") &&
          (!name.contains(data[i].toString().contains("Living Room")))) {
        name.add("Living Room");
        pg.add("Living Room");
      } else if (data[i].toString().contains("Garage") &&
          (!name.contains(data[i].toString().contains("Garage")))) {
        name.add("Garage");
        pg.add("Garage");
      } else if (data[i].toString().contains("Kitchen") &&
          (!name.contains(data[i].toString().contains("Kitchen")))) {
        name.add("Kitchen");
        pg.add("Kitchen");
      } else if (data[i].toString().contains("Bathroom1") &&
          (!name.contains(data[i].toString().contains("Bathroom1")))) {
        name.add("Bathroom1");
        pg.add("Bathroom1");
      } else if (data[i].toString().contains("Bathroom2") &&
          (!name.contains(data[i].toString().contains("Bathroom2")))) {
        name.add("Bathroom2");
        pg.add("Bathroom2");
      } else if (data[i].toString().contains("Bathroom") &&
          (!name.contains(data[i].toString().contains("Bathroom")))) {
        name.add("Bathroom");
        pg.add("Bathroom");
      } else if (data[i].toString().contains("Master Bedroom") &&
          (!name.contains(data[i].toString().contains("Master Bedroom")))) {
        name.add("Master Bedroom");
        pg.add("Master Bedroom");
      } else if (data[i].toString().contains("Bedroom1") &&
          !name.contains(data[i].toString().contains("Bedroom1"))) {
        name.add("Bedroom1");
        //print("----- bedroom1 $name name -------");
        pg.add("Bedroom1");
        //print("----- bedroom1 $pg pg -------");
      } else if (data[i].toString().contains("Bedroom2") &&
          (!name.contains(data[i].toString().contains("Bedroom2")))) {
        name.add("Bedroom2");
        //print("----- bedroom1 $name name -------");
        pg.add("Bedroom2");
        //print("----- bedroom1 $pg pg -------");
      } else if (data[i].toString().contains("Bedroom") &&
          (!name.contains(data[i].toString().contains("Bedroom")))) {
        name.add("Bedroom");
        pg.add("Bedroom");
      } else if (data[i].toString().contains("Store Room") &&
          (!name.contains(data[i].toString().contains("Store Room")))) {
        name.add("Store Room");
        pg.add("Store Room");
      } else if (data[i].toString().contains("Outside") &&
          (!name.contains(data[i].toString().contains("Outside")))) {
        name.add("Outside");
        pg.add("Outside");
      } else if (data[i].toString().contains("Parking") &&
          (!name.contains(data[i].toString().contains("Parking")))) {
        name.add("Parking");
        pg.add("Parking");
      } else if (data[i].toString().contains("Garden") &&
          (!name.contains(data[i].toString().contains("Garden")))) {
        name.add("Garden");
        pg.add("Garden");
      } else if (data[i].toString().contains("Farm") &&
          (!name.contains(data[i].toString().contains("Farm")))) {
        name.add("Farm");
        pg.add("Farm");
      } else if (data[i].toString().contains("Dining Room") &&
          (!name.contains(data[i].toString().contains("Dining Room")))) {
        name.add("Dining Room");
        pg.add("Dining Room");
      } else if (data[i].toString().contains("Green Room") &&
          (!name.contains(data[i].toString().contains("Green Room")))) {
        name.add("Green Room");
        pg.add("Green Room");
      }
    }

    setState(() {
      name = name.toSet().toList();
      pg = pg.toSet().toList();
      // print("$name  88889978");
    });
    return "success";
  }

  Future<void> internet() async {
    //print("the connectivity is now $result """"""""""""""""""""""""""""""""""""""""""""""""""");
    Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        //print("the connectivity eeeeeeeeeeeeeeeeeee  is now $result """"""""""""""""""""""""""""""""""""""""""""""""""");
        this.netResult = result;
      });
    });

    InternetConnectionChecker().onStatusChange.listen((status) async {
      final hasInternet = status == InternetConnectionStatus.connected;
      setState(() {
        this.hasInternet = hasInternet;
      });
    });
    hasInternet = await InternetConnectionChecker().hasConnection;
    netResult = await Connectivity().checkConnectivity();
  }

  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }



  @override
  void initState() {
    initial();
    firstProcess();
    check().then((internet) {
      if (internet) {
        call().then((value) => callValue());
        }
      });
    initial().then((value) => statusValue());
    // timer = Timer.periodic(
    //     Duration(milliseconds: 100),
    //         (Timer t) => initial().then((value) => statusValue()));



    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      check().then((internet) {
        if (internet) {
          call().then((value) => callValue());
        }
        // else {
        //   showDialog(
        //       context: context,
        //       builder: (_) =>
        //           AlertDialog(
        //             backgroundColor: Colors.black,
        //             title: Text(
        //               "No Internet Connection",
        //               style: TextStyle(color: Colors.white),
        //             ),
        //             content: Text("Please check your Internet Connection",
        //                 style: TextStyle(color: Colors.white)),
        //           ));
        //   //print("Connection: not present");
        // }
      });
      timer = Timer.periodic(
          Duration(seconds: 3),
          (Timer t) => check().then((internet) {
                if (internet) {
                  call().then((value) => callValue());
                }
                // else {
                //   showDialog(
                //       context: context,
                //       builder: (_) =>
                //           AlertDialog(
                //             backgroundColor: Colors.black,
                //             title: Text(
                //               "No Internet Connection",
                //               style: TextStyle(color: Colors.white),
                //             ),
                //             content: Text(
                //                 "Please check your Internet Connection",
                //                 style: TextStyle(color: Colors.white)),
                //           ));
                // }
              })); //   _showScaffold("resume");
      // user returned to our app
    } else if (state == AppLifecycleState.inactive) {
      // print("app:inactive");
      timer?.cancel();
      // app is inactive
    } else if (state == AppLifecycleState.paused) {
      timer?.cancel();
      // print("app:pause");
      // user is about quit our app temporally
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text =
        Provider.of<ThemeProvider>(context).getTheme() == ThemeMode.dark
            ? 'Dark'
            : 'Light';
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Consumer<ThemeProvider>(builder: (context, taskData, child) {
      task = taskData.listData[0];
      // task = taskData.listData.first;
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 19.0),
        child: Container(
          height: height * 0.965,
          width: width * 0.70,
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(40.0),
          ),
          child: Container(
              child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(task.data.toString().replaceAll("_", " "),
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: height * 0.030,
                                  color: Theme.of(context).backgroundColor,
                                )),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.010,
                        ),
                        Text(
                          "Lights",
                          style: GoogleFonts.poppins(
                            fontSize: height * 0.020,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ChangeThemeButtonWidget(),
                        SizedBox(
                          height: height * 0.010,
                        ),
                        Text("$text Mode",
                            style: GoogleFonts.poppins(
                              fontSize: height * 0.010,
                              color: Theme.of(context).backgroundColor,
                            )),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: height * 0.015,
                ),
                //TabLeftLightsContainer(),
                result && result2
                    ? Container(
                        height: height * 0.20,
                        width: width * 1.0,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: _buildButtonsWithNames(),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: height * 0.015,
                ),
                Text(
                  "Fans",
                  style: GoogleFonts.poppins(
                    fontSize: height * 0.020,
                  ),
                ),
                SizedBox(
                  height: height * 0.015,
                ),
                //TabLeftFanContainer(),
                result && result2
                    ? Container(
                        height: height * 0.20,
                        width: width * 1.0,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: _buildFanSlideWithNames(),
                          // children: _buildButtonsWithNames(),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: height * 0.020,
                ),
                Text(
                  "Tab to Run",
                  style: GoogleFonts.poppins(
                    fontSize: height * 0.020,
                    color: Theme.of(context).backgroundColor,
                  ),
                ),
                SizedBox(
                  height: height * 0.021,
                ),
                TabLeftOtherScrollView()
              ],
            ),
          )),
        ),
      );
    });
  }
}
