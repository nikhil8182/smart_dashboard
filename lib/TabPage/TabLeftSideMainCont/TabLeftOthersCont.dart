import 'dart:async';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;

final databaseReference = FirebaseDatabase.instance.reference();


class TabLeftOthersContainer extends StatefulWidget {

  @override
  _TabLeftOthersContainerState createState() => _TabLeftOthersContainerState();
}

class _TabLeftOthersContainerState extends State<TabLeftOthersContainer> {

  var scenesData;
  List scenesName = [];
  List scheduleName = [];
  List routines = [];
  List scenesDatas = [];
  Timer timer;
  bool loader = false;
  bool vibrate = false;
  SharedPreferences loginData;
  List buttonTapped = [ ];
  String authKey = " ";
  var ownerId;
  var personalDataJson;
  String ip;



  keyValues() async {
    loginData = await SharedPreferences.getInstance();
    final locIp = loginData.getString('ip') ?? null;
    final onIp = loginData.getString('onlineIp') ?? null;

    if((locIp != null)&&(locIp != "false")){
      final response = await http.get(Uri.parse("http://$locIp/")).timeout(
          const Duration(milliseconds: 500),onTimeout: (){
        //ignore:avoid_print
        //print(" inside the timeout  in second screeen");
        ip = onIp;
        initial();
        return;
      });
      if(response.statusCode > 0) {
        ip = locIp;
        // print(ip);
        initial();
      }

    }else if(locIp == "false")
    {
      ip = locIp;
      initial();
    }
  }


  initial() async
  {
    // print("hello");
    loginData = await SharedPreferences.getInstance();
    setState(() {
      vibrate = loginData.get('vibrationStatus')??false;
      authKey = loginData.getString('ownerId')??" ";

    });
  }

  getData() async {
    if(authKey == " "){
      initial();
    }else{
      await databaseReference.child(authKey).once().then((value)
      {
        scenesName.clear();
        routines.clear();
        var dataJson;

        setState(() {
          loader = true;
          dataJson = value.snapshot.value;
          scenesData = value.snapshot.value;
        });

        // Map<dynamic, dynamic> values = value.value['SmartHome']['scenes'];
        try{
          Map<dynamic, dynamic> values = dataJson['SmartHome']['Scenes']['TabToRun'];

          values.forEach((key, values) {
            setState(() {
              scenesName.add(values);
              routines.add(values);
            });
          });
          // print(routines);
        }catch(e){
          // print(e);
        }
      });
    }
  }



  @override
  void initState() {
    keyValues();
    timer = Timer.periodic(Duration(seconds: 3), (Timer t) {
      getData();
      //   // getName();
    });
    super.initState();
  }


  ///
  // bool roomColorSts  = false;
  // bool adminStatus = false;
  // bool kitchenStatus = false;
  // bool hallStatus = false;
  // bool bedRoomStatus = false;
  // bool bedRoom1Status = false;
  // bool bedRoom2Status = false;
  // bool masterBedStatus = false;
  // bool bathRoomStatus = false;
  // bool bathRoomStatus2 = false;
  // bool garageStatus = false;
  // bool gardenStatus = false;
  // bool storeStatus = false;
  // bool parkingStatus = false;
  // bool livingStatus = false;
  // bool outSideStatus = false;
  // String ipLocal;
  // SharedPreferences loginData;
  // String ip;
  // String username;
  // bool notifier = false;
  // bool mobNotifier = false;
  // var dataJson;
  // List name = [];
  // List pg = [];
  // List data;
  // bool first;
  // Timer timer;
  // bool hasInternet = false;
  // ConnectivityResult result = ConnectivityResult.none;
  // String ipAddress = " ";
  // List<String> localDataVal = [];
  // List<String> dumVariable = [];
  // var count = 0;
  // String userName = " ";
  // var acount = 0;
  // var ownerId;
  // String authKey = " ";
  // var smartHome;
  // var doorData;
  // bool bothOffOn;
  // String phoneNumber = " ";
  // String email = " ";
  // bool noLocalServer;
  // var localServer;
  // var personalDataJson;
  // String onlineIp = " ";
  // bool owner = false;
  // bool smartDoor = false;
  //
  //
  // //
  // // void initial() async {
  // //   loginData = await SharedPreferences.getInstance();
  // //   setState(() {
  // //     username = loginData.getString('username');
  // //   });
  // // }
  // //
  // //
  // // String userName = " ";
  // // String ipAddress = "192.168.1.18:8000";
  // //
  // //  getData(){
  // //
  // //   if(result == ConnectivityResult.wifi) {
  // //     //print("wifi =============_________(((((((((()))))))");
  // //     getName();
  // //   }
  // //   else if((result == ConnectivityResult.mobile)&&(!mobNotifier)){
  // //
  // //     if(! mobNotifier){
  // //       // print(" im inside the if notifier class");
  // //       showSimpleNotification(
  // //         Text(" Please switch to wifi network ",
  // //           style: TextStyle(color: Colors.white),), background: Colors.red,
  // //       );
  // //     }
  // //     mobNotifier = true;
  // //   }
  // //   else if((result == ConnectivityResult.none)&&(!notifier))
  // //   {
  // //     if(!notifier){
  // //       // print(" im inside the if notifier class");
  // //       // showSimpleNotification(
  // //       //   Text(" No Internet Connectivity ",
  // //       //     style: TextStyle(color: Colors.white),), background: Colors.red,
  // //       // );
  // //     }
  // //     notifier = true;
  // //   }
  // //
  // // }
  // //
  // //
  // //
  // // Future getName() async {
  // //
  // //   final response = await http.get(Uri.parse("http://$ipAddress/key",));
  // //
  // //   var fetchData = jsonDecode(response.body);
  // //   if (response.statusCode == 200) {
  // //
  // //     setState(() {
  // //       data = fetchData;
  // //     });}
  // //
  // //   for (int i = 0; i < data.length; i++) {
  // //     if (data[i].toString().contains("_Admin_Room") &&
  // //         (!name.contains(data[i].toString().contains("Admin_Room")))) {
  // //       name.add("Admin_Room");
  // //       pg.add("Admin_Room");
  // //     } else if (data[i].toString().contains("_Hall") &&
  // //         (!name.contains(data[i].toString().contains("Hall")))) {
  // //       name.add("Hall");
  // //       pg.add("Hall");
  // //     } else if (data[i].toString().contains("Living_Room") &&
  // //         (!name.contains(data[i].toString().contains("Living_Room")))) {
  // //       name.add("Living_Room");
  // //       pg.add("Living_Room");
  // //     } else if (data[i].toString().contains("_Garage") &&
  // //         (!name.contains(data[i].toString().contains("Garage")))) {
  // //       name.add("Garage");
  // //       pg.add("Garage");
  // //     } else if (data[i].toString().contains("_Kitchen") &&
  // //         (!name.contains(data[i].toString().contains("Kitchen")))) {
  // //       name.add("Kitchen");
  // //       pg.add("Kitchen");
  // //     } else if (data[i].toString().contains("_Bathroom") &&
  // //         (!name.contains(data[i].toString().contains("Bathroom")))) {
  // //       name.add("Bathroom");
  // //       pg.add("Bathroom");
  // //     } else if (data[i].toString().contains("Master_Bedroom") &&
  // //         (!name.contains(data[i].toString().contains("Master_Bedroom")))) {
  // //       name.add("Master_Bedroom");
  // //       pg.add("Master_Bedroom");
  // //     } else if (data[i].toString().contains("_Bedroom") &&
  // //         (!name.contains(data[i].toString().contains("Bedroom")))) {
  // //       name.add("Bedroom");
  // //       pg.add("Bedroom");
  // //     } else if (data[i].toString().contains("_Bedroom1") &&
  // //         (!name.contains(data[i].toString().contains("Bedroom1")))) {
  // //       name.add("Bedroom1");
  // //       pg.add("Bedroom1");
  // //     } else if (data[i].toString().contains("_Bedroom2") &&
  // //         (!name.contains(data[i].toString().contains("Bedroom2")))) {
  // //       name.add("Bedroom2");
  // //       pg.add("Bedroom2");
  // //     } else if (data[i].toString().contains("_Store_Room") &&
  // //         (!name.contains(data[i].toString().contains("Store_Room")))) {
  // //       name.add("Store_Room");
  // //       pg.add("Store_Room");
  // //     } else if (data[i].toString().contains("_Outside") &&
  // //         (!name.contains(data[i].toString().contains("Outside")))) {
  // //       name.add("Outside");
  // //       pg.add("Outside");
  // //     } else if (data[i].toString().contains("_Parking") &&
  // //         (!name.contains(data[i].toString().contains("Parking")))) {
  // //       name.add("Parking");
  // //       pg.add("Parking");
  // //     } else if (data[i].toString().contains("_Outside") &&
  // //         (!name.contains(data[i].toString().contains("Outside")))) {
  // //       name.add("Outside");
  // //       pg.add("Outside");
  // //     } else if (data[i].toString().contains("_Garden") &&
  // //         (!name.contains(data[i].toString().contains("Garden")))) {
  // //       name.add("Garden");
  // //       pg.add("Garden");
  // //     }
  // //   }
  // //
  // //   // name = name.toSet().toList();
  // //   // pg = pg.toSet().toList();
  // //   setState(() {
  // //     name = name.toSet().toList();
  // //     pg = pg.toSet().toList();
  // //     //print("$name  88889978");
  // //   });
  // //
  // //   return "success";
  // // }
  // //
  // //
  // //
  // // Future<void> internet() async {
  // //   hasInternet = await InternetConnectionChecker().hasConnection;
  // //   result = await Connectivity().checkConnectivity();
  // // }
  // //
  // // @override
  // // void initState() {
  // //
  // //   //initial();
  // //   timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
  // //     getData();
  // //   });
  // //
  // //   internet();
  // //   Connectivity().onConnectivityChanged.listen((result) {
  // //     setState(() {
  // //       this.result = result;
  // //     });
  // //   });
  // //   InternetConnectionChecker().onStatusChange.listen((status) async {
  // //     final hasInternet = status == InternetConnectionStatus.connected;
  // //     setState(() {
  // //       this.hasInternet = hasInternet;
  // //     });
  // //
  // //   });
  // //   super.initState();
  // //
  // //   //print("url type: ${widget.check_url}");
  // // }
  // //
  // //
  //
  // keyValues() async {
  //   loginData = await SharedPreferences.getInstance();
  //   final locIp = loginData.getString('ip') ?? null;
  //   final onIp = loginData.getString('onlineIp') ?? null;
  //
  //   if ((locIp != null)&&(locIp != "false")){
  //     try{
  //       http.Response response = await http.get(Uri.parse("http://$locIp/")).timeout(const Duration(milliseconds: 500), onTimeout: () {
  //         // data.clear();
  //         ipAddress = onIp;
  //         initial();
  //         return;
  //       });
  //       if (response.statusCode > 0) {
  //         // data.clear();
  //         ipAddress = locIp;
  //         initial();
  //       }
  //     }catch(e){
  //       // print(e);
  //     }// initial();
  //   } else if (locIp == "false") {
  //     initial();
  //     ipAddress = locIp;
  //   }
  // }
  //
  // Future<void> initial() async {
  //   loginData = await SharedPreferences.getInstance();
  //   username = loginData.getString('username');
  //   if (username == " ") {
  //     setState(() {
  //       username = userName;
  //     });
  //   }
  //   if (ipAddress == null) {
  //     fireData();
  //   } else if ((data == null) || (data.length == 0)) {
  //     if (ipAddress.toString() != 'false') {
  //       final response = await http.get(Uri.parse(
  //         "http://$ipAddress/",
  //       ));
  //       var fetchdata = jsonDecode(response.body);
  //
  //       setState(() {
  //         localDataVal.clear();
  //         dumVariable.clear();
  //         var dumData = fetchdata;
  //         for (int i = 0; i < dumData.length; i++) {
  //           dumVariable.add(dumData[i]["Room"].toString());
  //         }
  //         localDataVal = dumVariable.toSet().toList();
  //         data = localDataVal;
  //         loginData.setStringList('dataValues', localDataVal);
  //         initial();
  //       });
  //     } else if ((ipAddress.toString() == 'false')) {
  //       // print("im inside the false");
  //       setState(() {
  //         getName();
  //       });
  //       //showAnotherAlertDialog(context);
  //     }
  //   } else {
  //     setState(() {
  //       // loader = true;
  //       // print("im going into the getName of list in initial ");
  //       getName();
  //     });
  //   }
  // }
  //
  // firstProcess() async {
  //   loginData = await SharedPreferences.getInstance();
  //   databaseReference.child('family').once().then((value) {
  //     for (var element in value.snapshot.children) {
  //       ownerId = element.value;
  //       if (element.key == auth.currentUser.uid) {
  //         loginData.setString('ownerId', ownerId['owner-uid']);
  //         authKey = loginData.getString('ownerId');
  //         fireData();
  //         break;
  //       } else {
  //         loginData.setString('ownerId', auth.currentUser.uid);
  //         authKey = loginData.getString('ownerId');
  //         fireData();
  //       }
  //     }
  //   });
  // }
  //
  // Future<void> fireData() async {
  //   databaseReference.child(auth.currentUser.uid).once().then((value) async {
  //     personalDataJson = value.snapshot.value;
  //     setState(() {
  //       userName = personalDataJson["name"];
  //       email = personalDataJson['email'];
  //       phoneNumber = personalDataJson['phone'].toString();
  //       owner = personalDataJson['owner'];
  //     });
  //   });
  //
  //   databaseReference.child(authKey).once().then((snapshot) async {
  //     dataJson = snapshot.snapshot.value;
  //     setState(() {
  //       // bothOffOn = dataJson['localServer']['BothOfflineAndOnline'];
  //       noLocalServer = dataJson['noLocalServer'];
  //       localServer = dataJson['localServer'];
  //       bothOffOn =
  //       localServer != null ? localServer["BothOfflineAndOnline"] : false;
  //
  //       if (noLocalServer != true) {
  //         if (bothOffOn == true) {
  //           ipLocal = localServer['offlineIp'].toString();
  //           onlineIp = localServer['staticIp'].toString();
  //           keyValues();
  //           // checkData();
  //           //firebase ****************
  //         } else {
  //           ipLocal = dataJson['offlineIp'].toString();
  //           onlineIp = "false";
  //           keyValues();
  //           // checkData();
  //         }
  //       } else {
  //         smartHome = dataJson['SmartHome'];
  //         ipLocal = "false";
  //         onlineIp = "false";
  //         doorData = dataJson['SmartHome'];
  //         smartDoor = doorData != null ? doorData['smartDoor'] : false;
  //         var len = smartHome['Devices'].length;
  //         for (int i = 1; i <= len; i++) {
  //           data.add(smartHome['Devices']['Id$i']['Room']);
  //         }
  //         // checkData();
  //         getName();
  //       }
  //     });
  //   });
  // }
  //
  // // localDataVariableStorage() async {
  // //
  // //   initial();
  // //
  // //   if ((ipAddress.toString().toLowerCase() != "false") && (ipAddress != null)) {
  // //
  // //     if (result == ConnectivityResult.wifi) {
  // //       if (count < 1) {
  // //         showSimpleNotification(
  // //           Text(
  // //             " You are on Wifi in left others ",
  // //             style: TextStyle(color: Colors.white),
  // //           ),
  // //           background: Colors.green,
  // //         );
  // //         count = 2;
  // //       }
  // //
  // //       final response = await http.get(Uri.parse(
  // //         "http://$ipAddress/key",
  // //       ));
  // //       var fetchdata = jsonDecode(response.body);
  // //       if (response.statusCode > 0) {
  // //         // data = fetchdata;
  // //         setState(() {
  // //           data = fetchdata;
  // //           for (int i = 0; i < data.length; i++) {
  // //             localDataVal.add(data[i].toString());
  // //           }
  // //
  // //           loginData.setStringList('dataValues', localDataVal);
  // //           initial();
  // //
  // //         });
  // //       }
  // //     }else {
  // //       print("no internet in wifi ");
  // //     }
  // //   }
  // //
  // // }
  // //
  // // wiFiChecker() {
  // //
  // //   if (result == ConnectivityResult.wifi) {
  // //
  // //     if ((acount == 0) && (ipAddress.toString().toLowerCase() != 'false')&& (ipAddress != null)) {
  // //
  // //     } else if (ipAddress == null) {
  // //
  // //       initial();
  // //     }
  // //     initial();
  // //   } else if ((result == ConnectivityResult.mobile)) {
  // //
  // //     if ((acount == 0) && (ipAddress.toString().toLowerCase() != 'false') && (ipAddress != null)) {
  // //
  // //     }
  // //   } else {
  // //     print("i am not connected to anything in wifi checker ___------------");
  // //   }
  // // }
  //
  //
  // Future getName() async {
  //
  //   for (int i = 0; i < data.length; i++) {
  //     if (data[i].toString().contains("Admin Room") &&
  //         (!name.contains(data[i].toString().contains("Admin Room")))) {
  //       name.add("Admin Room");
  //       pg.add("Admin Room");
  //     } else if (data[i].toString().contains("Hall") &&
  //         (!name.contains(data[i].toString().contains("Hall")))) {
  //       name.add("Hall");
  //       pg.add("Hall");
  //     } else if (data[i].toString().contains("Living Room") &&
  //         (!name.contains(data[i].toString().contains("Living Room")))) {
  //       name.add("Living Room");
  //       pg.add("Living Room");
  //     } else if (data[i].toString().contains("Garage") &&
  //         (!name.contains(data[i].toString().contains("Garage")))) {
  //       name.add("Garage");
  //       pg.add("Garage");
  //     } else if (data[i].toString().contains("Kitchen") &&
  //         (!name.contains(data[i].toString().contains("Kitchen")))) {
  //       name.add("Kitchen");
  //       pg.add("Kitchen");
  //     } else if (data[i].toString().contains("Bathroom1") &&
  //         (!name.contains(data[i].toString().contains("Bathroom1")))) {
  //       name.add("Bathroom1");
  //       pg.add("Bathroom1");
  //     } else if (data[i].toString().contains("Bathroom2") &&
  //         (!name.contains(data[i].toString().contains("Bathroom2")))) {
  //       name.add("Bathroom2");
  //       pg.add("Bathroom2");
  //     } else if (data[i].toString().contains("Bathroom") &&
  //         (!name.contains(data[i].toString().contains("Bathroom")))) {
  //       name.add("Bathroom");
  //       pg.add("Bathroom");
  //     } else if (data[i].toString().contains("Master Bedroom") &&
  //         (!name.contains(data[i].toString().contains("Master Bedroom")))) {
  //       name.add("Master Bedroom");
  //       pg.add("Master Bedroom");
  //     } else if (data[i].toString().contains("Bedroom1") &&
  //         !name.contains(data[i].toString().contains("Bedroom1"))) {
  //       name.add("Bedroom1");
  //       //print("----- bedroom1 $name name -------");
  //       pg.add("Bedroom1");
  //       //print("----- bedroom1 $pg pg -------");
  //     } else if (data[i].toString().contains("Bedroom2") &&
  //         (!name.contains(data[i].toString().contains("Bedroom2")))) {
  //       name.add("Bedroom2");
  //       //print("----- bedroom1 $name name -------");
  //       pg.add("Bedroom2");
  //       //print("----- bedroom1 $pg pg -------");
  //     } else if (data[i].toString().contains("Bedroom") &&
  //         (!name.contains(data[i].toString().contains("Bedroom")))) {
  //       name.add("Bedroom");
  //       pg.add("Bedroom");
  //     } else if (data[i].toString().contains("Store Room") &&
  //         (!name.contains(data[i].toString().contains("Store Room")))) {
  //       name.add("Store Room");
  //       pg.add("Store Room");
  //     } else if (data[i].toString().contains("Outside") &&
  //         (!name.contains(data[i].toString().contains("Outside")))) {
  //       name.add("Outside");
  //       pg.add("Outside");
  //     } else if (data[i].toString().contains("Parking") &&
  //         (!name.contains(data[i].toString().contains("Parking")))) {
  //       name.add("Parking");
  //       pg.add("Parking");
  //     } else if (data[i].toString().contains("Garden") &&
  //         (!name.contains(data[i].toString().contains("Garden")))) {
  //       name.add("Garden");
  //       pg.add("Garden");
  //     } else if (data[i].toString().contains("Farm") &&
  //         (!name.contains(data[i].toString().contains("Farm")))) {
  //       name.add("Farm");
  //       pg.add("Farm");
  //     } else if (data[i].toString().contains("Dining Room") &&
  //         (!name.contains(data[i].toString().contains("Dining Room")))) {
  //       name.add("Dining Room");
  //       pg.add("Dining Room");
  //     }
  //   }
  //
  //   // name = name.toSet().toList();
  //   // pg = pg.toSet().toList();
  //
  //   setState(() {
  //     name = name.toSet().toList();
  //     pg = pg.toSet().toList();
  //     // print("$name  88889978");
  //   });
  //
  //   //return "success";
  // }
  //
  // Future<void> internet() async {
  //   Connectivity().onConnectivityChanged.listen((result) {
  //     setState(() {
  //       this.result = result;
  //     });
  //   });
  //
  //   InternetConnectionChecker().onStatusChange.listen((status) async {
  //     final hasInternet = status == InternetConnectionStatus.connected;
  //     setState(() {
  //       this.hasInternet = hasInternet;
  //     });
  //   });
  //   hasInternet = await InternetConnectionChecker().hasConnection;
  //   result = await Connectivity().checkConnectivity();
  // }
  //
  // @override
  // void initState() {
  //   // fireData();
  //   firstProcess();
  //   keyValues();
  //   timer = Timer.periodic(Duration(seconds: 3), (Timer t) {
  //     keyValues();
  //     internet();
  //     // getName();
  //   });
  //
  //   super.initState();
  // }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // print(routines);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
        itemCount: routines.length,
        itemBuilder: (BuildContext context,int index) {
          return GestureDetector(
            onTap: () async {
              if(routines[index]['tabToRun']==true)
              {
                setState(() {
                  buttonTapped.add(index);
                });
                Future.delayed(Duration(milliseconds: 200), () {
                  setState(() {
                    buttonTapped.remove(index);
                  });

                });
                // if(vibrate)
                // {
                //   Vibration.vibrate(duration: 50, amplitude: 25);
                // }else{
                //   Vibration.cancel();
                // }

                var trueData = scenesName[index]['trueDevices'];

                var idsData = scenesName[index]['ids'];

                List<int> trueDataList = [];
                List<int> idsDataList = [];

                if (trueData != null) {
                  for (var td in trueData) {
                    trueDataList.add(int.parse(td));
                  }
                }

                for (var id in idsData) {
                  idsDataList.add(int.parse(id));
                }

                List<int> falseDataList = [];

                for (int x in idsDataList) {
                  if (trueDataList.isNotEmpty) {
                    if (trueDataList.contains(x)) {
                      null;
                    } else {
                      falseDataList.add(x);
                    }
                  } else {
                    falseDataList.add(x);
                  }
                }

                if ((trueData != null)&&(ip != "false")) {
                  for (var d in trueData) {
                    var fff = (await http.put(
                      Uri.parse('http://$ip/$d/'),
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                      },
                      body: jsonEncode(<String, bool>{"Device_Status": true}),
                    ));
                  }
                }

                if((trueData != null)&&(ip== "false"))
                {
                  for (var d in trueData) {
                    databaseReference.child(authKey).child('SmartHome').child('Devices').child('Id$d').update({
                      'Device_Status': true,
                    });
                  }
                }

                if((falseDataList !=null)&&(ip == "false"))
                {
                  for (var d in falseDataList) {
                    databaseReference.child(authKey).child('SmartHome').child('Devices').child('Id$d').update({'Device_Status': false,});
                  }
                }

                if ((falseDataList != null)&&(ip != "false")) {
                  for (var d in falseDataList) {
                    //print("$d is false");
                    var fff = (await http.put(
                      Uri.parse('http://$ip/$d/'),
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                      },
                      body: jsonEncode(<String, bool>{"Device_Status": false}),
                    ));
                  }
                }

              }else{
                print("hello schedule ");
              }

            },

            child:Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0),
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                height: height * 0.20,
                width: width * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Theme.of(context).scaffoldBackgroundColor,
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
                            child: SvgPicture.asset("images/icons/touch.svg",color: Color.fromRGBO(247, 179, 28, 0.59) ,
                              height: height * 0.035,),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.040,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Text("${routines[index]['name']}", style: Theme.of(context).textTheme.bodyText2,),
                    SizedBox(
                      height: height * 0.006,
                    ),
                    routines[index]['tabToRun']==true?
                    Text("Tab to Run",style: TextStyle(color: Colors.black,fontSize: height*0.010),):null,
                  ],
                )
            )
          );
        }
    );
  }
}
