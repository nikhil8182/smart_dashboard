import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_dashboard/theme/change_theme_button_widget.dart';
import 'package:smart_dashboard/theme/theme_provider.dart';

import 'TabLeftFanCont.dart';
import 'TabLeftLightsCont.dart';
import 'TabLeftOtherScrollView.dart';

class TabLeftMainContainerTitle extends StatefulWidget {
  // TabLeftMainContainerTitle({this.roomName});
  // String roomName;
  TabLeftMainContainerTitle({this.roomName,this.index,this.ip});
  final String roomName;
  final int index;
  final String ip;

  @override
  _TabLeftMainContainerTitleState createState() => _TabLeftMainContainerTitleState();
}

class _TabLeftMainContainerTitleState extends State<TabLeftMainContainerTitle> {
  bool roomColorSts  = false;
  bool adminStatus = false;
  bool kitchenStatus = false;
  bool hallStatus = false;
  bool bedRoomStatus = false;
  bool bedRoom1Status = false;
  bool bedRoom2Status = false;
  bool masterBedStatus = false;
  bool bathRoomStatus = false;
  bool bathRoomStatus2 = false;
  bool garageStatus = false;
  bool gardenStatus = false;
  bool storeStatus = false;
  bool parkingStatus = false;
  bool livingStatus = false;
  bool outSideStatus = false;
  String ipLocal;
  SharedPreferences loginData;
  String ip;
  String username;
  bool notifier = false;
  bool mobNotifier = false;
  var dataJson;
  List name = [];
  List pg = [];
  List data;
  bool first;
  Timer timer;
  bool hasInternet = false;
  ConnectivityResult result = ConnectivityResult.none;


  void initial() async {
    loginData = await SharedPreferences.getInstance();
    setState(() {
      username = loginData.getString('username');
    });
  }


  String userName = " ";
  String ipAddress = "192.168.1.18:8000";

  Future <String> getData(){
    //
    // databaseReference.child(auth.currentUser.uid).once().then((DataSnapshot snapshot) async {
    //
    //   // print('Data : ${snapshot.value}');
    //   // print("iam going to map ");
    //
    //   // print("dataJson = $dataJson");
    //   // print(dataJson["name"]);
    //   // userName = dataJson["name"];
    //   // ipAddress= dataJson["ip"];
    //
    //   setState(() {
    //     dataJson = snapshot.value;
    //     //print(dataJson);
    //     userName = dataJson["name"];
    //     ipAddress= dataJson["ip"].toString();
    //
    //     // ip_local = loginData.setString('ip', ipAddress) as String ;
    //     //print("$ipAddress --------");
    //   });
  setState(() {
  print("########### ${widget.roomName} room name -------------");
  print("########### ${widget.ip} ip addressss-------------");
  print("########### ${widget.index} index value-------------");

  });
    if(result == ConnectivityResult.wifi) {
      //print("wifi =============_________(((((((((()))))))");
      get_name();
    }
    else if((result == ConnectivityResult.mobile)&&(!mobNotifier)){
      //print("mobile ****************************");
      // if((!mobNotifier) && (ipAddress.toString().toLowerCase() == 'false')) {
      //   get_name();
      // }
      // else{
      //   showSimpleNotification(
      //     Text(" please switch on your wifi network ",
      //       style: TextStyle(color: Colors.white),), background: Colors.red,
      //   );
      // }
      if(! mobNotifier){
        // print(" im inside the if notifier class");
        showSimpleNotification(
          Text(" Please switch to wifi network ",
            style: TextStyle(color: Colors.white),), background: Colors.red,
        );
      }
      mobNotifier = true;
    }
    else if((result == ConnectivityResult.none)&&(!notifier))
    {
      // print(" ************** none **************");
      // print("$notifier the value of the notifier is 00000000");
      if(!notifier){
        // print(" im inside the if notifier class");
        showSimpleNotification(
          Text(" No Internet Connectivity ",
            style: TextStyle(color: Colors.white),), background: Colors.red,
        );
      }
      notifier = true;
    }

  }



  Future get_name() async {
    //print("iam inside getname");
    //print(ipAddress);
    //print("iam using online json");
    final response = await http.get(Uri.parse("http://$ipAddress/key",));

    var fetchData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      // data = fetchData;

      setState(() {
        data = fetchData;
      });}

    for (int i = 0; i < data.length; i++) {
      if (data[i].toString().contains("_Admin_Room") &&
          (!name.contains(data[i].toString().contains("Admin_Room")))) {
        name.add("Admin_Room");
        pg.add("Admin_Room");
      } else if (data[i].toString().contains("_Hall") &&
          (!name.contains(data[i].toString().contains("Hall")))) {
        name.add("Hall");
        pg.add("Hall");
      } else if (data[i].toString().contains("Living_Room") &&
          (!name.contains(data[i].toString().contains("Living_Room")))) {
        name.add("Living_Room");
        pg.add("Living_Room");
      } else if (data[i].toString().contains("_Garage") &&
          (!name.contains(data[i].toString().contains("Garage")))) {
        name.add("Garage");
        pg.add("Garage");
      } else if (data[i].toString().contains("_Kitchen") &&
          (!name.contains(data[i].toString().contains("Kitchen")))) {
        name.add("Kitchen");
        pg.add("Kitchen");
      } else if (data[i].toString().contains("_Bathroom") &&
          (!name.contains(data[i].toString().contains("Bathroom")))) {
        name.add("Bathroom");
        pg.add("Bathroom");
      } else if (data[i].toString().contains("Master_Bedroom") &&
          (!name.contains(data[i].toString().contains("Master_Bedroom")))) {
        name.add("Master_Bedroom");
        pg.add("Master_Bedroom");
      } else if (data[i].toString().contains("_Bedroom") &&
          (!name.contains(data[i].toString().contains("Bedroom")))) {
        name.add("Bedroom");
        pg.add("Bedroom");
      } else if (data[i].toString().contains("_Bedroom1") &&
          (!name.contains(data[i].toString().contains("Bedroom1")))) {
        name.add("Bedroom1");
        pg.add("Bedroom1");
      } else if (data[i].toString().contains("_Bedroom2") &&
          (!name.contains(data[i].toString().contains("Bedroom2")))) {
        name.add("Bedroom2");
        pg.add("Bedroom2");
      } else if (data[i].toString().contains("_Store_Room") &&
          (!name.contains(data[i].toString().contains("Store_Room")))) {
        name.add("Store_Room");
        pg.add("Store_Room");
      } else if (data[i].toString().contains("_Outside") &&
          (!name.contains(data[i].toString().contains("Outside")))) {
        name.add("Outside");
        pg.add("Outside");
      } else if (data[i].toString().contains("_Parking") &&
          (!name.contains(data[i].toString().contains("Parking")))) {
        name.add("Parking");
        pg.add("Parking");
      } else if (data[i].toString().contains("_Outside") &&
          (!name.contains(data[i].toString().contains("Outside")))) {
        name.add("Outside");
        pg.add("Outside");
      } else if (data[i].toString().contains("_Garden") &&
          (!name.contains(data[i].toString().contains("Garden")))) {
        name.add("Garden");
        pg.add("Garden");
      }
    }

    // name = name.toSet().toList();
    // pg = pg.toSet().toList();
    setState(() {
      name = name.toSet().toList();
      pg = pg.toSet().toList();
      //print("$name  88889978");
    });

    return "success";
  }



  Future<void> internet() async {
    hasInternet = await InternetConnectionChecker().hasConnection;
    result = await Connectivity().checkConnectivity();
  }

  @override
  void initState() {

    //initial();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      getData();
    });

    internet();
    Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        this.result = result;
      });
    });
    InternetConnectionChecker().onStatusChange.listen((status) async {
      final hasInternet = status == InternetConnectionStatus.connected;
      setState(() {
        this.hasInternet = hasInternet;
      });

    });
    super.initState();

    //print("url type: ${widget.check_url}");
  }

  @override
  Widget build(BuildContext context) {
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
        ? 'Light'
        : 'Dark';
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      child: widget.roomName.toString().contains("Admin") ? Container(
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
                          children: [//widget.roomName.toString().replaceAll("_", " "),
                            Text(widget.roomName.toString().replaceAll("_", " "),
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: height*0.030,
                                  color: Theme.of(context).backgroundColor,)),
                            Switch(
                              value: adminStatus,
                              onChanged: (bool value){
                                setState(() {
                                  adminStatus = value;
                                });
                              },

                            )
                          ],
                        ),
                        SizedBox(
                          height: height*0.010,
                        ),
                        Text("Lights",
                          style: GoogleFonts.poppins(
                            fontSize: height*0.020,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        // GestureDetector(
                        //   onTap: (){},
                        //   child: Container(
                        //     height: height*0.06,
                        //     width: width*0.04,
                        //     decoration: BoxDecoration(
                        //       color: Color.fromRGBO(196, 196, 196, 1.0),
                        //       borderRadius: BorderRadius.circular(15.0),
                        //     ),
                        //    child: Center(
                        //      child: SvgPicture.asset("images/icons/sun.svg"),
                        //    ),
                        //
                        //   ),
                        // ),
                        ChangeThemeButtonWidget(),
                        SizedBox(
                          height: height*0.010,
                        ),
                        Text("$text Mode",
                            style: GoogleFonts.poppins(
                              fontSize: height*0.010,
                              color: Theme.of(context).backgroundColor,)),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: height*0.015,
                ),
                TabLeftLightsContainer(),
                SizedBox(
                  height: height*0.015,
                ),
                Text("Fans",style:GoogleFonts.poppins( fontSize: height*0.020,),),
                SizedBox(
                  height: height*0.015,
                ),
                TabLeftFanContainer(),
                SizedBox(
                  height: height*0.020,
                ),Text("Others Rooms",style: GoogleFonts.poppins( fontSize: height*0.020,
                  color:Theme.of(context).backgroundColor,),),
                SizedBox(
                  height: height*0.021,
                ),
                TabLeftOtherScrollView()
              ],
            ),
          )):
      widget.roomName.toString().contains("Hall") ? Container(
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
                          children: [//widget.roomName.toString().replaceAll("_", " "),
                            Text(widget.roomName.toString().replaceAll("_", " "),
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: height*0.030,
                                  color: Theme.of(context).backgroundColor,)),
                            Switch(
                              value: adminStatus,
                              onChanged: (bool value){
                                setState(() {
                                  adminStatus = value;
                                });
                              },

                            )
                          ],
                        ),
                        SizedBox(
                          height: height*0.010,
                        ),
                        Text("Lights",
                          style: GoogleFonts.poppins(
                            fontSize: height*0.020,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        // GestureDetector(
                        //   onTap: (){},
                        //   child: Container(
                        //     height: height*0.06,
                        //     width: width*0.04,
                        //     decoration: BoxDecoration(
                        //       color: Color.fromRGBO(196, 196, 196, 1.0),
                        //       borderRadius: BorderRadius.circular(15.0),
                        //     ),
                        //    child: Center(
                        //      child: SvgPicture.asset("images/icons/sun.svg"),
                        //    ),
                        //
                        //   ),
                        // ),
                        ChangeThemeButtonWidget(),
                        SizedBox(
                          height: height*0.010,
                        ),
                        Text("$text Mode",
                            style: GoogleFonts.poppins(
                              fontSize: height*0.010,
                              color: Theme.of(context).backgroundColor,)),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: height*0.015,
                ),
                TabLeftLightsContainer(),
                SizedBox(
                  height: height*0.015,
                ),
                Text("Fans",style:GoogleFonts.poppins( fontSize: height*0.020,),),
                SizedBox(
                  height: height*0.015,
                ),
                TabLeftFanContainer(),
                SizedBox(
                  height: height*0.020,
                ),Text("Others Rooms",style: GoogleFonts.poppins( fontSize: height*0.020,
                  color:Theme.of(context).backgroundColor,),),
                SizedBox(
                  height: height*0.021,
                ),
                TabLeftOtherScrollView()
              ],
            ),
          ))
          :widget.roomName.toString().contains("Garage") ? Container(
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
                          children: [//widget.roomName.toString().replaceAll("_", " "),
                            Text(widget.roomName.toString().replaceAll("_", " "),
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: height*0.030,
                                  color: Theme.of(context).backgroundColor,)),
                            Switch(
                              value: adminStatus,
                              onChanged: (bool value){
                                setState(() {
                                  adminStatus = value;
                                });
                              },

                            )
                          ],
                        ),
                        SizedBox(
                          height: height*0.010,
                        ),
                        Text("Lights",
                          style: GoogleFonts.poppins(
                            fontSize: height*0.020,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        // GestureDetector(
                        //   onTap: (){},
                        //   child: Container(
                        //     height: height*0.06,
                        //     width: width*0.04,
                        //     decoration: BoxDecoration(
                        //       color: Color.fromRGBO(196, 196, 196, 1.0),
                        //       borderRadius: BorderRadius.circular(15.0),
                        //     ),
                        //    child: Center(
                        //      child: SvgPicture.asset("images/icons/sun.svg"),
                        //    ),
                        //
                        //   ),
                        // ),
                        ChangeThemeButtonWidget(),
                        SizedBox(
                          height: height*0.010,
                        ),
                        Text("$text Mode",
                            style: GoogleFonts.poppins(
                              fontSize: height*0.010,
                              color: Theme.of(context).backgroundColor,)),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: height*0.015,
                ),
                TabLeftLightsContainer(),
                SizedBox(
                  height: height*0.015,
                ),
                Text("Fans",style:GoogleFonts.poppins( fontSize: height*0.020,),),
                SizedBox(
                  height: height*0.015,
                ),
                TabLeftFanContainer(),
                SizedBox(
                  height: height*0.020,
                ),Text("Others Rooms",style: GoogleFonts.poppins( fontSize: height*0.020,
                  color:Theme.of(context).backgroundColor,),),
                SizedBox(
                  height: height*0.021,
                ),
                TabLeftOtherScrollView()
              ],
            ),
          ))
          :widget.roomName.toString().contains("Kitchen") ? Container(
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
                          children: [//widget.roomName.toString().replaceAll("_", " "),
                            Text(widget.roomName.toString().replaceAll("_", " "),
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: height*0.030,
                                  color: Theme.of(context).backgroundColor,)),
                            Switch(
                              value: adminStatus,
                              onChanged: (bool value){
                                setState(() {
                                  adminStatus = value;
                                });
                              },

                            )
                          ],
                        ),
                        SizedBox(
                          height: height*0.010,
                        ),
                        Text("Lights",
                          style: GoogleFonts.poppins(
                            fontSize: height*0.020,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        // GestureDetector(
                        //   onTap: (){},
                        //   child: Container(
                        //     height: height*0.06,
                        //     width: width*0.04,
                        //     decoration: BoxDecoration(
                        //       color: Color.fromRGBO(196, 196, 196, 1.0),
                        //       borderRadius: BorderRadius.circular(15.0),
                        //     ),
                        //    child: Center(
                        //      child: SvgPicture.asset("images/icons/sun.svg"),
                        //    ),
                        //
                        //   ),
                        // ),
                        ChangeThemeButtonWidget(),
                        SizedBox(
                          height: height*0.010,
                        ),
                        Text("$text Mode",
                            style: GoogleFonts.poppins(
                              fontSize: height*0.010,
                              color: Theme.of(context).backgroundColor,)),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: height*0.015,
                ),
                TabLeftLightsContainer(),
                SizedBox(
                  height: height*0.015,
                ),
                Text("Fans",style:GoogleFonts.poppins( fontSize: height*0.020,),),
                SizedBox(
                  height: height*0.015,
                ),
                TabLeftFanContainer(),
                SizedBox(
                  height: height*0.020,
                ),Text("Others Rooms",style: GoogleFonts.poppins( fontSize: height*0.020,
                  color:Theme.of(context).backgroundColor,),),
                SizedBox(
                  height: height*0.021,
                ),
                TabLeftOtherScrollView()
              ],
            ),
          ))
          :widget.roomName.toString().contains("Bathroom1") ? Container(
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
                          children: [//widget.roomName.toString().replaceAll("_", " "),
                            Text(widget.roomName.toString().replaceAll("_", " "),
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: height*0.030,
                                  color: Theme.of(context).backgroundColor,)),
                            Switch(
                              value: adminStatus,
                              onChanged: (bool value){
                                setState(() {
                                  adminStatus = value;
                                });
                              },

                            )
                          ],
                        ),
                        SizedBox(
                          height: height*0.010,
                        ),
                        Text("Lights",
                          style: GoogleFonts.poppins(
                            fontSize: height*0.020,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        // GestureDetector(
                        //   onTap: (){},
                        //   child: Container(
                        //     height: height*0.06,
                        //     width: width*0.04,
                        //     decoration: BoxDecoration(
                        //       color: Color.fromRGBO(196, 196, 196, 1.0),
                        //       borderRadius: BorderRadius.circular(15.0),
                        //     ),
                        //    child: Center(
                        //      child: SvgPicture.asset("images/icons/sun.svg"),
                        //    ),
                        //
                        //   ),
                        // ),
                        ChangeThemeButtonWidget(),
                        SizedBox(
                          height: height*0.010,
                        ),
                        Text("$text Mode",
                            style: GoogleFonts.poppins(
                              fontSize: height*0.010,
                              color: Theme.of(context).backgroundColor,)),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: height*0.015,
                ),
                TabLeftLightsContainer(),
                SizedBox(
                  height: height*0.015,
                ),
                Text("Fans",style:GoogleFonts.poppins( fontSize: height*0.020,),),
                SizedBox(
                  height: height*0.015,
                ),
                TabLeftFanContainer(),
                SizedBox(
                  height: height*0.020,
                ),Text("Others Rooms",style: GoogleFonts.poppins( fontSize: height*0.020,
                  color:Theme.of(context).backgroundColor,),),
                SizedBox(
                  height: height*0.021,
                ),
                TabLeftOtherScrollView()
              ],
            ),
          ))
          :widget.roomName.toString().contains("Bathroom2") ? Container(
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
                          children: [//widget.roomName.toString().replaceAll("_", " "),
                            Text(widget.roomName.toString().replaceAll("_", " "),
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: height*0.030,
                                  color: Theme.of(context).backgroundColor,)),
                            Switch(
                              value: bathRoomStatus2,
                              onChanged: (bool value){
                                setState(() {
                                  bathRoomStatus2 = value;
                                });
                              },

                            )
                          ],
                        ),
                        SizedBox(
                          height: height*0.010,
                        ),
                        Text("Lights",
                          style: GoogleFonts.poppins(
                            fontSize: height*0.020,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        // GestureDetector(
                        //   onTap: (){},
                        //   child: Container(
                        //     height: height*0.06,
                        //     width: width*0.04,
                        //     decoration: BoxDecoration(
                        //       color: Color.fromRGBO(196, 196, 196, 1.0),
                        //       borderRadius: BorderRadius.circular(15.0),
                        //     ),
                        //    child: Center(
                        //      child: SvgPicture.asset("images/icons/sun.svg"),
                        //    ),
                        //
                        //   ),
                        // ),
                        ChangeThemeButtonWidget(),
                        SizedBox(
                          height: height*0.010,
                        ),
                        Text("$text Mode",
                            style: GoogleFonts.poppins(
                              fontSize: height*0.010,
                              color: Theme.of(context).backgroundColor,)),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: height*0.015,
                ),
                TabLeftLightsContainer(),
                SizedBox(
                  height: height*0.015,
                ),
                Text("Fans",style:GoogleFonts.poppins( fontSize: height*0.020,),),
                SizedBox(
                  height: height*0.015,
                ),
                TabLeftFanContainer(),
                SizedBox(
                  height: height*0.020,
                ),Text("Others Rooms",style: GoogleFonts.poppins( fontSize: height*0.020,
                  color:Theme.of(context).backgroundColor,),),
                SizedBox(
                  height: height*0.021,
                ),
                TabLeftOtherScrollView()
              ],
            ),
          ))
          :widget.roomName.toString().contains("Bedroom1") ?  Container(
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
                          children: [//widget.roomName.toString().replaceAll("_", " "),
                            Text(widget.roomName.toString().replaceAll("_", " "),
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: height*0.030,
                                  color: Theme.of(context).backgroundColor,)),
                            Switch(
                              value: bedRoom1Status,
                              onChanged: (bool value){
                                setState(() {
                                  bedRoom1Status = value;
                                });
                              },

                            )
                          ],
                        ),
                        SizedBox(
                          height: height*0.010,
                        ),
                        Text("Lights",
                          style: GoogleFonts.poppins(
                            fontSize: height*0.020,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        // GestureDetector(
                        //   onTap: (){},
                        //   child: Container(
                        //     height: height*0.06,
                        //     width: width*0.04,
                        //     decoration: BoxDecoration(
                        //       color: Color.fromRGBO(196, 196, 196, 1.0),
                        //       borderRadius: BorderRadius.circular(15.0),
                        //     ),
                        //    child: Center(
                        //      child: SvgPicture.asset("images/icons/sun.svg"),
                        //    ),
                        //
                        //   ),
                        // ),
                        ChangeThemeButtonWidget(),
                        SizedBox(
                          height: height*0.010,
                        ),
                        Text("$text Mode",
                            style: GoogleFonts.poppins(
                              fontSize: height*0.010,
                              color: Theme.of(context).backgroundColor,)),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: height*0.015,
                ),
                TabLeftLightsContainer(),
                SizedBox(
                  height: height*0.015,
                ),
                Text("Fans",style:GoogleFonts.poppins( fontSize: height*0.020,),),
                SizedBox(
                  height: height*0.015,
                ),
                TabLeftFanContainer(),
                SizedBox(
                  height: height*0.020,
                ),Text("Others Rooms",style: GoogleFonts.poppins( fontSize: height*0.020,
                  color:Theme.of(context).backgroundColor,),),
                SizedBox(
                  height: height*0.021,
                ),
                TabLeftOtherScrollView()
              ],
            ),
          ))
          :widget.roomName.toString().contains("Bedroom2") ? Container(
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
                          children: [//widget.roomName.toString().replaceAll("_", " "),
                            Text(widget.roomName.toString().replaceAll("_", " "),
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: height*0.030,
                                  color: Theme.of(context).backgroundColor,)),
                            Switch(
                              value: bedRoom2Status,
                              onChanged: (bool value){
                                setState(() {
                                  bedRoom2Status = value;
                                });
                              },

                            )
                          ],
                        ),
                        SizedBox(
                          height: height*0.010,
                        ),
                        Text("Lights",
                          style: GoogleFonts.poppins(
                            fontSize: height*0.020,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        // GestureDetector(
                        //   onTap: (){},
                        //   child: Container(
                        //     height: height*0.06,
                        //     width: width*0.04,
                        //     decoration: BoxDecoration(
                        //       color: Color.fromRGBO(196, 196, 196, 1.0),
                        //       borderRadius: BorderRadius.circular(15.0),
                        //     ),
                        //    child: Center(
                        //      child: SvgPicture.asset("images/icons/sun.svg"),
                        //    ),
                        //
                        //   ),
                        // ),
                        ChangeThemeButtonWidget(),
                        SizedBox(
                          height: height*0.010,
                        ),
                        Text("$text Mode",
                            style: GoogleFonts.poppins(
                              fontSize: height*0.010,
                              color: Theme.of(context).backgroundColor,)),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: height*0.015,
                ),
                TabLeftLightsContainer(),
                SizedBox(
                  height: height*0.015,
                ),
                Text("Fans",style:GoogleFonts.poppins( fontSize: height*0.020,),),
                SizedBox(
                  height: height*0.015,
                ),
                TabLeftFanContainer(),
                SizedBox(
                  height: height*0.020,
                ),Text("Others Rooms",style: GoogleFonts.poppins( fontSize: height*0.020,
                  color:Theme.of(context).backgroundColor,),),
                SizedBox(
                  height: height*0.021,
                ),
                TabLeftOtherScrollView()
              ],
            ),
          ))
          :widget.roomName.toString().contains("Master_Bedroom") ? Container(
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
                          children: [//widget.roomName.toString().replaceAll("_", " "),
                            Text(widget.roomName.toString().replaceAll("_", " "),
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: height*0.030,
                                  color: Theme.of(context).backgroundColor,)),
                            Switch(
                              value: masterBedStatus,
                              onChanged: (bool value){
                                setState(() {
                                  masterBedStatus = value;
                                });
                              },

                            )
                          ],
                        ),
                        SizedBox(
                          height: height*0.010,
                        ),
                        Text("Lights",
                          style: GoogleFonts.poppins(
                            fontSize: height*0.020,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        // GestureDetector(
                        //   onTap: (){},
                        //   child: Container(
                        //     height: height*0.06,
                        //     width: width*0.04,
                        //     decoration: BoxDecoration(
                        //       color: Color.fromRGBO(196, 196, 196, 1.0),
                        //       borderRadius: BorderRadius.circular(15.0),
                        //     ),
                        //    child: Center(
                        //      child: SvgPicture.asset("images/icons/sun.svg"),
                        //    ),
                        //
                        //   ),
                        // ),
                        ChangeThemeButtonWidget(),
                        SizedBox(
                          height: height*0.010,
                        ),
                        Text("$text Mode",
                            style: GoogleFonts.poppins(
                              fontSize: height*0.010,
                              color: Theme.of(context).backgroundColor,)),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: height*0.015,
                ),
                TabLeftLightsContainer(),
                SizedBox(
                  height: height*0.015,
                ),
                Text("Fans",style:GoogleFonts.poppins( fontSize: height*0.020,),),
                SizedBox(
                  height: height*0.015,
                ),
                TabLeftFanContainer(),
                SizedBox(
                  height: height*0.020,
                ),Text("Others Rooms",style: GoogleFonts.poppins( fontSize: height*0.020,
                  color:Theme.of(context).backgroundColor,),),
                SizedBox(
                  height: height*0.021,
                ),
                TabLeftOtherScrollView()
              ],
            ),
          ))
          :widget.roomName.toString().contains("Bedroom") ? Container(
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
                          children: [//widget.roomName.toString().replaceAll("_", " "),
                            Text(widget.roomName.toString().replaceAll("_", " "),
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: height*0.030,
                                  color: Theme.of(context).backgroundColor,)),
                            Switch(
                              value: bedRoomStatus,
                              onChanged: (bool value){
                                setState(() {
                                  bedRoomStatus = value;
                                });
                              },

                            )
                          ],
                        ),
                        SizedBox(
                          height: height*0.010,
                        ),
                        Text("Lights",
                          style: GoogleFonts.poppins(
                            fontSize: height*0.020,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        // GestureDetector(
                        //   onTap: (){},
                        //   child: Container(
                        //     height: height*0.06,
                        //     width: width*0.04,
                        //     decoration: BoxDecoration(
                        //       color: Color.fromRGBO(196, 196, 196, 1.0),
                        //       borderRadius: BorderRadius.circular(15.0),
                        //     ),
                        //    child: Center(
                        //      child: SvgPicture.asset("images/icons/sun.svg"),
                        //    ),
                        //
                        //   ),
                        // ),
                        ChangeThemeButtonWidget(),
                        SizedBox(
                          height: height*0.010,
                        ),
                        Text("$text Mode",
                            style: GoogleFonts.poppins(
                              fontSize: height*0.010,
                              color: Theme.of(context).backgroundColor,)),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: height*0.015,
                ),
                TabLeftLightsContainer(),
                SizedBox(
                  height: height*0.015,
                ),
                Text("Fans",style:GoogleFonts.poppins( fontSize: height*0.020,),),
                SizedBox(
                  height: height*0.015,
                ),
                TabLeftFanContainer(),
                SizedBox(
                  height: height*0.020,
                ),Text("Others Rooms",style: GoogleFonts.poppins( fontSize: height*0.020,
                  color:Theme.of(context).backgroundColor,),),
                SizedBox(
                  height: height*0.021,
                ),
                TabLeftOtherScrollView()
              ],
            ),
          ))
          :widget.roomName.toString().contains("Outside") ? Container(
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
                          children: [//widget.roomName.toString().replaceAll("_", " "),
                            Text(widget.roomName.toString().replaceAll("_", " "),
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: height*0.030,
                                  color: Theme.of(context).backgroundColor,)),
                            Switch(
                              value: outSideStatus,
                              onChanged: (bool value){
                                setState(() {
                                  outSideStatus = value;
                                });
                              },

                            )
                          ],
                        ),
                        SizedBox(
                          height: height*0.010,
                        ),
                        Text("Lights",
                          style: GoogleFonts.poppins(
                            fontSize: height*0.020,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        // GestureDetector(
                        //   onTap: (){},
                        //   child: Container(
                        //     height: height*0.06,
                        //     width: width*0.04,
                        //     decoration: BoxDecoration(
                        //       color: Color.fromRGBO(196, 196, 196, 1.0),
                        //       borderRadius: BorderRadius.circular(15.0),
                        //     ),
                        //    child: Center(
                        //      child: SvgPicture.asset("images/icons/sun.svg"),
                        //    ),
                        //
                        //   ),
                        // ),
                        ChangeThemeButtonWidget(),
                        SizedBox(
                          height: height*0.010,
                        ),
                        Text("$text Mode",
                            style: GoogleFonts.poppins(
                              fontSize: height*0.010,
                              color: Theme.of(context).backgroundColor,)),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: height*0.015,
                ),
                TabLeftLightsContainer(),
                SizedBox(
                  height: height*0.015,
                ),
                Text("Fans",style:GoogleFonts.poppins( fontSize: height*0.020,),),
                SizedBox(
                  height: height*0.015,
                ),
                TabLeftFanContainer(),
                SizedBox(
                  height: height*0.020,
                ),Text("Others Rooms",style: GoogleFonts.poppins( fontSize: height*0.020,
                  color:Theme.of(context).backgroundColor,),),
                SizedBox(
                  height: height*0.021,
                ),
                TabLeftOtherScrollView()
              ],
            ),
          ))
          :widget.roomName.toString().contains("Garden") ? Container(
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
                          children: [//widget.roomName.toString().replaceAll("_", " "),
                            Text(widget.roomName.toString().replaceAll("_", " "),
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: height*0.030,
                                  color: Theme.of(context).backgroundColor,)),
                            Switch(
                              value: gardenStatus,
                              onChanged: (bool value){
                                setState(() {
                                  gardenStatus = value;
                                });
                              },

                            )
                          ],
                        ),
                        SizedBox(
                          height: height*0.010,
                        ),
                        Text("Lights",
                          style: GoogleFonts.poppins(
                            fontSize: height*0.020,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        // GestureDetector(
                        //   onTap: (){},
                        //   child: Container(
                        //     height: height*0.06,
                        //     width: width*0.04,
                        //     decoration: BoxDecoration(
                        //       color: Color.fromRGBO(196, 196, 196, 1.0),
                        //       borderRadius: BorderRadius.circular(15.0),
                        //     ),
                        //    child: Center(
                        //      child: SvgPicture.asset("images/icons/sun.svg"),
                        //    ),
                        //
                        //   ),
                        // ),
                        ChangeThemeButtonWidget(),
                        SizedBox(
                          height: height*0.010,
                        ),
                        Text("$text Mode",
                            style: GoogleFonts.poppins(
                              fontSize: height*0.010,
                              color: Theme.of(context).backgroundColor,)),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: height*0.015,
                ),
                TabLeftLightsContainer(),
                SizedBox(
                  height: height*0.015,
                ),
                Text("Fans",style:GoogleFonts.poppins( fontSize: height*0.020,),),
                SizedBox(
                  height: height*0.015,
                ),
                TabLeftFanContainer(),
                SizedBox(
                  height: height*0.020,
                ),Text("Others Rooms",style: GoogleFonts.poppins( fontSize: height*0.020,
                  color:Theme.of(context).backgroundColor,),),
                SizedBox(
                  height: height*0.021,
                ),
                TabLeftOtherScrollView()
              ],
            ),
          ))
          :widget.roomName.toString().contains("Parking") ? Container(
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
                          children: [//widget.roomName.toString().replaceAll("_", " "),
                            Text(widget.roomName.toString().replaceAll("_", " "),
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: height*0.030,
                                  color: Theme.of(context).backgroundColor,)),
                            Switch(
                              value: parkingStatus,
                              onChanged: (bool value){
                                setState(() {
                                  parkingStatus = value;
                                });
                              },

                            )
                          ],
                        ),
                        SizedBox(
                          height: height*0.010,
                        ),
                        Text("Lights",
                          style: GoogleFonts.poppins(
                            fontSize: height*0.020,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        // GestureDetector(
                        //   onTap: (){},
                        //   child: Container(
                        //     height: height*0.06,
                        //     width: width*0.04,
                        //     decoration: BoxDecoration(
                        //       color: Color.fromRGBO(196, 196, 196, 1.0),
                        //       borderRadius: BorderRadius.circular(15.0),
                        //     ),
                        //    child: Center(
                        //      child: SvgPicture.asset("images/icons/sun.svg"),
                        //    ),
                        //
                        //   ),
                        // ),
                        ChangeThemeButtonWidget(),
                        SizedBox(
                          height: height*0.010,
                        ),
                        Text("$text Mode",
                            style: GoogleFonts.poppins(
                              fontSize: height*0.010,
                              color: Theme.of(context).backgroundColor,)),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: height*0.015,
                ),
                TabLeftLightsContainer(),
                SizedBox(
                  height: height*0.015,
                ),
                Text("Fans",style:GoogleFonts.poppins( fontSize: height*0.020,),),
                SizedBox(
                  height: height*0.015,
                ),
                TabLeftFanContainer(),
                SizedBox(
                  height: height*0.020,
                ),Text("Others Rooms",style: GoogleFonts.poppins( fontSize: height*0.020,
                  color:Theme.of(context).backgroundColor,),),
                SizedBox(
                  height: height*0.021,
                ),
                TabLeftOtherScrollView()
              ],
            ),
          ))
          :widget.roomName.toString().contains("Living_Room") ? Container(
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
                          children: [//widget.roomName.toString().replaceAll("_", " "),
                            Text(widget.roomName.toString().replaceAll("_", " "),
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: height*0.030,
                                  color: Theme.of(context).backgroundColor,)),
                            Switch(
                              value: livingStatus,
                              onChanged: (bool value){
                                setState(() {
                                  livingStatus = value;
                                });
                              },

                            )
                          ],
                        ),
                        SizedBox(
                          height: height*0.010,
                        ),
                        Text("Lights",
                          style: GoogleFonts.poppins(
                            fontSize: height*0.020,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        // GestureDetector(
                        //   onTap: (){},
                        //   child: Container(
                        //     height: height*0.06,
                        //     width: width*0.04,
                        //     decoration: BoxDecoration(
                        //       color: Color.fromRGBO(196, 196, 196, 1.0),
                        //       borderRadius: BorderRadius.circular(15.0),
                        //     ),
                        //    child: Center(
                        //      child: SvgPicture.asset("images/icons/sun.svg"),
                        //    ),
                        //
                        //   ),
                        // ),
                        ChangeThemeButtonWidget(),
                        SizedBox(
                          height: height*0.010,
                        ),
                        Text("$text Mode",
                            style: GoogleFonts.poppins(
                              fontSize: height*0.010,
                              color: Theme.of(context).backgroundColor,)),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: height*0.015,
                ),
                TabLeftLightsContainer(),
                SizedBox(
                  height: height*0.015,
                ),
                Text("Fans",style:GoogleFonts.poppins( fontSize: height*0.020,),),
                SizedBox(
                  height: height*0.015,
                ),
                TabLeftFanContainer(),
                SizedBox(
                  height: height*0.020,
                ),Text("Others Rooms",style: GoogleFonts.poppins( fontSize: height*0.020,
                  color:Theme.of(context).backgroundColor,),),
                SizedBox(
                  height: height*0.021,
                ),
                TabLeftOtherScrollView()
              ],
            ),
          ))
          :widget.roomName.toString().contains("Store_Room") ? Container(
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
                          children: [//widget.roomName.toString().replaceAll("_", " "),
                            Text(widget.roomName.toString().replaceAll("_", " "),
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: height*0.030,
                                  color: Theme.of(context).backgroundColor,)),
                            Switch(
                              value: storeStatus,
                              onChanged: (bool value){
                                setState(() {
                                  storeStatus = value;
                                });
                              },

                            )
                          ],
                        ),
                        SizedBox(
                          height: height*0.010,
                        ),
                        Text("Lights",
                          style: GoogleFonts.poppins(
                            fontSize: height*0.020,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        // GestureDetector(
                        //   onTap: (){},
                        //   child: Container(
                        //     height: height*0.06,
                        //     width: width*0.04,
                        //     decoration: BoxDecoration(
                        //       color: Color.fromRGBO(196, 196, 196, 1.0),
                        //       borderRadius: BorderRadius.circular(15.0),
                        //     ),
                        //    child: Center(
                        //      child: SvgPicture.asset("images/icons/sun.svg"),
                        //    ),
                        //
                        //   ),
                        // ),
                        ChangeThemeButtonWidget(),
                        SizedBox(
                          height: height*0.010,
                        ),
                        Text("$text Mode",
                            style: GoogleFonts.poppins(
                              fontSize: height*0.010,
                              color: Theme.of(context).backgroundColor,)),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: height*0.015,
                ),
                TabLeftLightsContainer(),
                SizedBox(
                  height: height*0.015,
                ),
                Text("Fans",style:GoogleFonts.poppins( fontSize: height*0.020,),),
                SizedBox(
                  height: height*0.015,
                ),
                TabLeftFanContainer(),
                SizedBox(
                  height: height*0.020,
                ),Text("Others Rooms",style: GoogleFonts.poppins( fontSize: height*0.020,
                  color:Theme.of(context).backgroundColor,),),
                SizedBox(
                  height: height*0.021,
                ),
                TabLeftOtherScrollView()
              ],
            ),
          ))
          :Text("Select Room")
    );
  }
}
