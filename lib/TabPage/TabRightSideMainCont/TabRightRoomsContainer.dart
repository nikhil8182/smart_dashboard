import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http ;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_dashboard/TabPage/TabLeftSideMainCont/TabLeftCont.dart';
import 'package:smart_dashboard/TabPage/TabLeftSideMainCont/TabLeftMainContainerTitle.dart';

class TabRightRoomsContainer extends StatefulWidget {

  @override
  _TabRightRoomsContainerState createState() => _TabRightRoomsContainerState();
}

class _TabRightRoomsContainerState extends State<TabRightRoomsContainer> {
  bool roomColorSts  = false;
  bool adminStatus = false;
  bool kitchenStatus = false;
  bool hallStatus = false;
  bool bedRoomStatus = false;
  bool bedRoom1Status = false;
  bool bedRoom2Status = false;
  bool masterBedStatus = false;
  bool bathRoomStatus = false;
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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ListView.builder(
        itemCount: name.length,
        itemBuilder: (BuildContext context,int index) {
          return GestureDetector(
            onTap: (){
              setState(() {
               if(roomColorSts == false ){

                 roomColorSts = true;
               }else{
                 roomColorSts = false;
               }
              });

              Navigator.push(context, MaterialPageRoute(
                  builder:
                      (context)=>TabLeftContainer(roomName: name[index].toString(),index: index,ip: ipAddress,)));

              // Navigator.push(context, MaterialPageRoute(builder: (context)=>TabLeftMainContainerTitle(roomName: name[index].toString(),index: index,ip: ipAddress,)));
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 4.0),
                height: height * 0.090,
                width: width * 0.235,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    bottomRight: Radius.circular(25.0),
                    topLeft: Radius.circular(5.0),
                    bottomLeft: Radius.circular(5.0),),
                  color: roomColorSts ? Color.fromRGBO(247, 179, 28,1.0) : Color.fromRGBO(241, 241, 241, 1.0),
                ),
                child:  name[index]
                    .toString()
                    .contains("Admin") ? ListTile(
                  title: Text("${name[index].toString().replaceAll("_"," ")}",
                    style: GoogleFonts.poppins(color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: height * 0.020),),
                  subtitle: Text("6 Devices"
                      , style: GoogleFonts.poppins(
                          color: Colors.black, fontSize: height * 0.012)
                  ),
                ):name[index]
                    .toString()
                    .contains("Hall") ? ListTile(
                  title: Text("${name[index].toString().replaceAll("_"," ")}",
                    style: GoogleFonts.poppins(color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: height * 0.020),),
                  subtitle: Text("6 Devices"
                      , style: GoogleFonts.poppins(
                          color: Colors.black, fontSize: height * 0.012)
                  ),
                ) : name[index]
                    .toString()
                    .contains("Garage") ? ListTile(
                  title: Text("${name[index].toString().replaceAll("_"," ")}",
                    style: GoogleFonts.poppins(color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: height * 0.020),),
                  subtitle: Text("6 Devices"
                      , style: GoogleFonts.poppins(
                          color: Colors.black, fontSize: height * 0.012)
                  ),
                ) :name[index]
                    .toString()
                    .contains("Kitchen") ? ListTile(
                  title: Text("${name[index].toString().replaceAll("_"," ")}",
                    style: GoogleFonts.poppins(color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: height * 0.020),),
                  subtitle: Text("6 Devices"
                      , style: GoogleFonts.poppins(
                          color: Colors.black, fontSize: height * 0.012)
                  ),
                ): name[index]
                    .toString()
                    .contains("Bathroom1") ? ListTile(
                  title: Text("${name[index].toString().replaceAll("_"," ")}",
                    style: GoogleFonts.poppins(color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: height * 0.020),),
                  subtitle: Text("6 Devices"
                      , style: GoogleFonts.poppins(
                          color: Colors.black, fontSize: height * 0.012)
                  ),
                ): name[index]
                    .toString()
                    .contains("Bathroom2") ? ListTile(
                  title: Text("${name[index].toString().replaceAll("_"," ")}",
                    style: GoogleFonts.poppins(color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: height * 0.020),),
                  subtitle: Text("6 Devices"
                      , style: GoogleFonts.poppins(
                          color: Colors.black, fontSize: height * 0.012)
                  ),
                ): name[index]
                    .toString()
                    .contains("Bedroom1") ? ListTile(
                  title: Text("${name[index].toString().replaceAll("_"," ")}",
                    style: GoogleFonts.poppins(color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: height * 0.020),),
                  subtitle: Text("6 Devices"
                      , style: GoogleFonts.poppins(
                          color: Colors.black, fontSize: height * 0.012)
                  ),
                ): name[index]
                    .toString()
                    .contains("Bedroom2") ? ListTile(
                  title: Text("${name[index].toString().replaceAll("_"," ")}",
                    style: GoogleFonts.poppins(color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: height * 0.020),),
                  subtitle: Text("6 Devices"
                      , style: GoogleFonts.poppins(
                          color: Colors.black, fontSize: height * 0.012)
                  ),
                ): name[index]
                    .toString()
                    .contains("Master_Bedroom") ? ListTile(
                  title: Text("${name[index].toString().replaceAll("_"," ")}",
                    style: GoogleFonts.poppins(color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: height * 0.020),),
                  subtitle: Text("6 Devices"
                      , style: GoogleFonts.poppins(
                          color: Colors.black, fontSize: height * 0.012)
                  ),
                ): name[index]
                    .toString()
                    .contains("Bedroom") ? ListTile(
                  title: Text("${name[index].toString().replaceAll("_"," ")}",
                    style: GoogleFonts.poppins(color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: height * 0.020),),
                  subtitle: Text("6 Devices"
                      , style: GoogleFonts.poppins(
                          color: Colors.black, fontSize: height * 0.012)
                  ),
                ): name[index]
                    .toString()
                    .contains("Outside") ? ListTile(
                  title: Text("${name[index].toString().replaceAll("_"," ")}",
                    style: GoogleFonts.poppins(color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: height * 0.020),),
                  subtitle: Text("6 Devices"
                      , style: GoogleFonts.poppins(
                          color: Colors.black, fontSize: height * 0.012)
                  ),
                ):name[index]
                    .toString()
                    .contains("Garden") ? ListTile(
                  title: Text("${name[index].toString().replaceAll("_"," ")}",
                    style: GoogleFonts.poppins(color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: height * 0.020),),
                  subtitle: Text("6 Devices"
                      , style: GoogleFonts.poppins(
                          color: Colors.black, fontSize: height * 0.012)
                  ),
                ):name[index]
                    .toString()
                    .contains("Parking") ? ListTile(
                  title: Text("${name[index].toString().replaceAll("_"," ")}",
                    style: GoogleFonts.poppins(color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: height * 0.020),),
                  subtitle: Text("6 Devices"
                      , style: GoogleFonts.poppins(
                          color: Colors.black, fontSize: height * 0.012)
                  ),
                ):name[index]
                    .toString()
                    .contains("Living_Room") ? ListTile(
                  title: Text("${name[index].toString().replaceAll("_"," ")}",
                    style: GoogleFonts.poppins(color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: height * 0.020),),
                  subtitle: Text("6 Devices"
                      , style: GoogleFonts.poppins(
                          color: Colors.black, fontSize: height * 0.012)
                  ),
                ):name[index]
                    .toString()
                    .contains("Store_Room") ? ListTile(
                  title: Text("${name[index].toString().replaceAll("_"," ")}",
                    style: GoogleFonts.poppins(color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: height * 0.020),),
                  subtitle: Text("6 Devices"
                      , style: GoogleFonts.poppins(
                          color: Colors.black, fontSize: height * 0.012)
                  ),
                ) : Container(),
            ),
          );
        }
    );
  }
}
