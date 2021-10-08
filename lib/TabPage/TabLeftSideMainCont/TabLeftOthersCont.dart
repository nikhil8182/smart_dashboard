import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TabLeftOthersContainer extends StatefulWidget {

  @override
  _TabLeftOthersContainerState createState() => _TabLeftOthersContainerState();
}

class _TabLeftOthersContainerState extends State<TabLeftOthersContainer> {

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

   getData(){

    if(result == ConnectivityResult.wifi) {
      //print("wifi =============_________(((((((((()))))))");
      getName();
    }
    else if((result == ConnectivityResult.mobile)&&(!mobNotifier)){

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



  Future getName() async {

    final response = await http.get(Uri.parse("http://$ipAddress/key",));

    var fetchData = jsonDecode(response.body);
    if (response.statusCode == 200) {

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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
        itemCount: name.length,
        itemBuilder: (BuildContext context,int index) {
          return GestureDetector(
            onTap: () {},
            child: name[index]
                .toString()
                .contains("Admin") ? Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0),
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                height: height * 0.20,
                width: width * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Theme
                      .of(context)
                      .scaffoldBackgroundColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: height * 0.060,
                          width: width * 0.04,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(247, 179, 28, 0.19),
                              borderRadius: BorderRadius.circular(15.0)
                          ),
                          child: Center(
                            child: SvgPicture.asset("images/icons/kitchen.svg",
                              height: height * 0.035,),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.040,
                        ),
                        Switch(
                            value: adminStatus,
                          onChanged: (bool value) {
                          setState(() {
                           adminStatus = value;
                          });
                        })
                      ],
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Text("${name[index].toString().replaceAll("_"," ")}",
                      style: GoogleFonts.poppins(color: Theme
                          .of(context)
                          .backgroundColor, fontSize: height * 0.018),),
                    SizedBox(
                      height: height * 0.006,
                    ),
                    Text("off",
                      style: GoogleFonts.poppins(fontSize: height * 0.015),),
                  ],
                )
            ) :name[index]
                .toString()
                .contains("Hall") ? Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                height: height * 0.20,
                width: width * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Theme
                      .of(context)
                      .scaffoldBackgroundColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: height * 0.060,
                          width: width * 0.04,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(247, 179, 28, 0.19),
                              borderRadius: BorderRadius.circular(15.0)
                          ),
                          child: Center(
                            child: SvgPicture.asset("images/icons/kitchen.svg",
                              height: height * 0.035,),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.040,
                        ),
                        Switch(
                            value: hallStatus,
                            onChanged: (bool value) {
                              setState(() {
                                hallStatus = value;
                              });
                            })
                      ],
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Text("${name[index].toString().replaceAll("_"," ")}",
                      style: GoogleFonts.poppins(color: Theme
                          .of(context)
                          .backgroundColor, fontSize: height * 0.018),),
                    SizedBox(
                      height: height * 0.006,
                    ),
                    Text("off",
                      style: GoogleFonts.poppins(fontSize: height * 0.015),),
                  ],
                )
            ) :name[index]
                .toString()
                .contains("Garage") ? Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                height: height * 0.20,
                width: width * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Theme
                      .of(context)
                      .scaffoldBackgroundColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: height * 0.060,
                          width: width * 0.04,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(247, 179, 28, 0.19),
                              borderRadius: BorderRadius.circular(15.0)
                          ),
                          child: Center(
                            child: SvgPicture.asset("images/icons/kitchen.svg",
                              height: height * 0.035,),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.040,
                        ),
                        Switch(
                            value: garageStatus,
                            onChanged: (bool value) {
                              setState(() {
                                garageStatus = value;
                              });
                            })
                      ],
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Text("${name[index].toString().replaceAll("_"," ")}",
                      style: GoogleFonts.poppins(color: Theme
                          .of(context)
                          .backgroundColor, fontSize: height * 0.018),),
                    SizedBox(
                      height: height * 0.006,
                    ),
                    Text("off",
                      style: GoogleFonts.poppins(fontSize: height * 0.015),),
                  ],
                )
            ) : name[index]
                .toString()
                .contains("Kitchen") ? Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                height: height * 0.20,
                width: width * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Theme
                      .of(context)
                      .scaffoldBackgroundColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: height * 0.060,
                          width: width * 0.04,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(247, 179, 28, 0.19),
                              borderRadius: BorderRadius.circular(15.0)
                          ),
                          child: Center(
                            child: SvgPicture.asset("images/icons/kitchen.svg",
                              height: height * 0.035,),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.040,
                        ),
                        Switch(
                            value: kitchenStatus,
                            onChanged: (bool value) {
                              setState(() {
                                kitchenStatus = value;
                              });
                            })
                      ],
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Text("${name[index].toString().replaceAll("_"," ")}",
                      style: GoogleFonts.poppins(color: Theme
                          .of(context)
                          .backgroundColor, fontSize: height * 0.018),),
                    SizedBox(
                      height: height * 0.006,
                    ),
                    Text("off",
                      style: GoogleFonts.poppins(fontSize: height * 0.015),),
                  ],
                )
            ) : name[index]
                .toString()
                .contains("Bathroom1") ? Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                height: height * 0.20,
                width: width * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Theme
                      .of(context)
                      .scaffoldBackgroundColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: height * 0.060,
                          width: width * 0.04,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(247, 179, 28, 0.19),
                              borderRadius: BorderRadius.circular(15.0)
                          ),
                          child: Center(
                            child: SvgPicture.asset("images/icons/kitchen.svg",
                              height: height * 0.035,),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.040,
                        ),
                        Switch(
                            value: bathRoomStatus,
                            onChanged: (bool value) {
                              setState(() {
                                bathRoomStatus = value;
                              });
                            })
                      ],
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Text("${name[index].toString().replaceAll("_"," ")}",
                      style: GoogleFonts.poppins(color: Theme
                          .of(context)
                          .backgroundColor, fontSize: height * 0.018),),
                    SizedBox(
                      height: height * 0.006,
                    ),
                    Text("off",
                      style: GoogleFonts.poppins(fontSize: height * 0.015),),
                  ],
                )
            ) : name[index]
                .toString()
                .contains("Bathroom2") ? Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                height: height * 0.20,
                width: width * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Theme
                      .of(context)
                      .scaffoldBackgroundColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: height * 0.060,
                          width: width * 0.04,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(247, 179, 28, 0.19),
                              borderRadius: BorderRadius.circular(15.0)
                          ),
                          child: Center(
                            child: SvgPicture.asset("images/icons/kitchen.svg",
                              height: height * 0.035,),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.040,
                        ),
                        Switch(
                            value: bathRoomStatus2,
                            onChanged: (bool value) {
                              setState(() {
                                bathRoomStatus2 = value;
                              });
                            })
                      ],
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Text("${name[index].toString().replaceAll("_"," ")}",
                      style: GoogleFonts.poppins(color: Theme
                          .of(context)
                          .backgroundColor, fontSize: height * 0.018),),
                    SizedBox(
                      height: height * 0.006,
                    ),
                    Text("off",
                      style: GoogleFonts.poppins(fontSize: height * 0.015),),
                  ],
                )
            ) : name[index]
                .toString()
                .contains("Bedroom1") ? Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                height: height * 0.20,
                width: width * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Theme
                      .of(context)
                      .scaffoldBackgroundColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: height * 0.060,
                          width: width * 0.04,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(247, 179, 28, 0.19),
                              borderRadius: BorderRadius.circular(15.0)
                          ),
                          child: Center(
                            child: SvgPicture.asset("images/icons/bed.svg",
                              height: height * 0.035,),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.040,
                        ),
                        Switch(
                            value: bedRoom1Status,
                            onChanged: (bool value) {
                              setState(() {
                                bedRoom1Status = value;
                              });
                            })
                      ],
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Text("${name[index].toString().replaceAll("_"," ")}",
                      style: GoogleFonts.poppins(color: Theme
                          .of(context)
                          .backgroundColor, fontSize: height * 0.018),),
                    SizedBox(
                      height: height * 0.006,
                    ),
                    Text("off",
                      style: GoogleFonts.poppins(fontSize: height * 0.015),),
                  ],
                )
            ) : name[index]
                .toString()
                .contains("Bedroom2") ? Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                height: height * 0.20,
                width: width * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Theme
                      .of(context)
                      .scaffoldBackgroundColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: height * 0.060,
                          width: width * 0.04,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(247, 179, 28, 0.19),
                              borderRadius: BorderRadius.circular(15.0)
                          ),
                          child: Center(
                            child: SvgPicture.asset("images/icons/bed 1.svg",
                              height: height * 0.035,),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.040,
                        ),
                        Switch(
                            value: bedRoom2Status,
                            onChanged: (bool value) {
                              setState(() {
                                bedRoom2Status = value;
                              });
                            })
                      ],
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Text("${name[index].toString().replaceAll("_"," ")}",
                      style: GoogleFonts.poppins(color: Theme
                          .of(context)
                          .backgroundColor, fontSize: height * 0.018),),
                    SizedBox(
                      height: height * 0.006,
                    ),
                    Text("off",
                      style: GoogleFonts.poppins(fontSize: height * 0.015),),
                  ],
                )
            ) : name[index]
                .toString()
                .contains("Master_Bedroom") ? Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                height: height * 0.20,
                width: width * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Theme
                      .of(context)
                      .scaffoldBackgroundColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: height * 0.060,
                          width: width * 0.04,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(247, 179, 28, 0.19),
                              borderRadius: BorderRadius.circular(15.0)
                          ),
                          child: Center(
                            child: SvgPicture.asset("images/icons/bed.svg",
                              height: height * 0.035,),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.040,
                        ),
                        Switch(
                            value: masterBedStatus,
                            onChanged: (bool value) {
                              setState(() {
                                masterBedStatus = value;
                              });
                            })
                      ],
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Text("${name[index].toString().replaceAll("_"," ")}",
                      style: GoogleFonts.poppins(color: Theme
                          .of(context)
                          .backgroundColor, fontSize: height * 0.018),),
                    SizedBox(
                      height: height * 0.006,
                    ),
                    Text("off",
                      style: GoogleFonts.poppins(fontSize: height * 0.015),),
                  ],
                )
            ) : name[index]
                .toString()
                .contains("Bedroom") ? Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                height: height * 0.20,
                width: width * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Theme
                      .of(context)
                      .scaffoldBackgroundColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: height * 0.060,
                          width: width * 0.04,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(247, 179, 28, 0.19),
                              borderRadius: BorderRadius.circular(15.0)
                          ),
                          child: Center(
                            child: SvgPicture.asset("images/icons/bed 1.svg",
                              height: height * 0.035,),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.040,
                        ),
                        Switch(
                            value: bedRoomStatus,
                            onChanged: (bool value) {
                              setState(() {
                                bedRoomStatus = value;
                              });
                            })
                      ],
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Text("${name[index].toString().replaceAll("_"," ")}",
                      style: GoogleFonts.poppins(color: Theme
                          .of(context)
                          .backgroundColor, fontSize: height * 0.018),),
                    SizedBox(
                      height: height * 0.006,
                    ),
                    Text("off",
                      style: GoogleFonts.poppins(fontSize: height * 0.015),),
                  ],
                )
            ) : name[index]
                .toString()
                .contains("Outside") ? Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                height: height * 0.20,
                width: width * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Theme
                      .of(context)
                      .scaffoldBackgroundColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: height * 0.060,
                          width: width * 0.04,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(247, 179, 28, 0.19),
                              borderRadius: BorderRadius.circular(15.0)
                          ),
                          child: Center(
                            child: SvgPicture.asset("images/icons/kitchen.svg",
                              height: height * 0.035,),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.040,
                        ),
                        Switch(
                            value: outSideStatus,
                            onChanged: (bool value) {
                              setState(() {
                                outSideStatus = value;
                              });
                            })
                      ],
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Text("${name[index].toString().replaceAll("_"," ")}",
                      style: GoogleFonts.poppins(color: Theme
                          .of(context)
                          .backgroundColor, fontSize: height * 0.018),),
                    SizedBox(
                      height: height * 0.006,
                    ),
                    Text("off",
                      style: GoogleFonts.poppins(fontSize: height * 0.015),),
                  ],
                )
            ) : name[index]
                .toString()
                .contains("Garden") ? Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                height: height * 0.20,
                width: width * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Theme
                      .of(context)
                      .scaffoldBackgroundColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: height * 0.060,
                          width: width * 0.04,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(247, 179, 28, 0.19),
                              borderRadius: BorderRadius.circular(15.0)
                          ),
                          child: Center(
                            child: SvgPicture.asset("images/icons/kitchen.svg",
                              height: height * 0.035,),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.040,
                        ),
                        Switch(
                            value: gardenStatus,
                            onChanged: (bool value) {
                              setState(() {
                                gardenStatus = value;
                              });
                            })
                      ],
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Text("${name[index].toString().replaceAll("_"," ")}",
                      style: GoogleFonts.poppins(color: Theme
                          .of(context)
                          .backgroundColor, fontSize: height * 0.018),),
                    SizedBox(
                      height: height * 0.006,
                    ),
                    Text("off",
                      style: GoogleFonts.poppins(fontSize: height * 0.015),),
                  ],
                )
            ) : name[index]
                .toString()
                .contains("Parking") ? Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                height: height * 0.20,
                width: width * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Theme
                      .of(context)
                      .scaffoldBackgroundColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: height * 0.060,
                          width: width * 0.04,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(247, 179, 28, 0.19),
                              borderRadius: BorderRadius.circular(15.0)
                          ),
                          child: Center(
                            child: SvgPicture.asset("images/icons/kitchen.svg",
                              height: height * 0.035,),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.040,
                        ),
                        Switch(
                            value: parkingStatus,
                            onChanged: (bool value) {
                              setState(() {
                                parkingStatus = value;
                              });
                            })
                      ],
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Text("${name[index].toString().replaceAll("_"," ")}",
                      style: GoogleFonts.poppins(color: Theme
                          .of(context)
                          .backgroundColor, fontSize: height * 0.018),),
                    SizedBox(
                      height: height * 0.006,
                    ),
                    Text("off",
                      style: GoogleFonts.poppins(fontSize: height * 0.015),),
                  ],
                )
            ) : name[index]
                .toString()
                .contains("Living_Room") ? Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                height: height * 0.20,
                width: width * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Theme
                      .of(context)
                      .scaffoldBackgroundColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: height * 0.060,
                          width: width * 0.04,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(247, 179, 28, 0.19),
                              borderRadius: BorderRadius.circular(15.0)
                          ),
                          child: Center(
                            child: SvgPicture.asset("images/icons/kitchen.svg",
                              height: height * 0.035,),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.040,
                        ),
                        Switch(
                            value: livingStatus,
                            onChanged: (bool value) {
                              setState(() {
                                livingStatus = value;
                              });
                            })
                      ],
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Text("${name[index].toString().replaceAll("_"," ")}",
                      style: GoogleFonts.poppins(color: Theme
                          .of(context)
                          .backgroundColor, fontSize: height * 0.018),),
                    SizedBox(
                      height: height * 0.006,
                    ),
                    Text("off",
                      style: GoogleFonts.poppins(fontSize: height * 0.015),),
                  ],
                )
            ) : name[index]
                .toString()
                .contains("Store_Room") ? Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                height: height * 0.20,
                width: width * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Theme
                      .of(context)
                      .scaffoldBackgroundColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: height * 0.060,
                          width: width * 0.04,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(247, 179, 28, 0.19),
                              borderRadius: BorderRadius.circular(15.0)
                          ),
                          child: Center(
                            child: SvgPicture.asset("images/icons/kitchen.svg",
                              height: height * 0.035,),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.040,
                        ),
                        Switch(
                            value: storeStatus,
                            onChanged: (bool value) {
                              setState(() {
                                storeStatus = value;
                              });
                            })
                      ],
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Text("${name[index].toString().replaceAll("_"," ")}",
                      style: GoogleFonts.poppins(color: Theme
                          .of(context)
                          .backgroundColor, fontSize: height * 0.018),),
                    SizedBox(
                      height: height * 0.006,
                    ),
                    Text("off",
                      style: GoogleFonts.poppins(fontSize: height * 0.015),),
                  ],
                )
            ) : Container(),
          );
        }
    );
  }
}
