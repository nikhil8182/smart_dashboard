import 'dart:async';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http ;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_dashboard/theme/theme_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import '../../loginPage.dart';


FirebaseAuth auth = FirebaseAuth.instance;

final databaseReference = FirebaseDatabase.instance.reference();

class TabRightRoomsContainer extends StatefulWidget {

  @override
  _TabRightRoomsContainerState createState() => _TabRightRoomsContainerState();
}

class _TabRightRoomsContainerState extends State<TabRightRoomsContainer> {

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
  String  isSelected = " ";
  String ipAddress = " ";
  List<String> localDataVal = [];
  List<String> dumVariable = [];
  var count = 0;
  String userName = " ";
  var acount = 0;
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


  keyValues() async {

    loginData = await SharedPreferences.getInstance();
    final locIp = loginData.getString('ip') ?? null;
    final onIp = loginData.getString('onlineIp') ?? null;

    if ((locIp != null)&&(locIp != "false")){
      try{
        http.Response response = await http.get(Uri.parse("http://$locIp/")).timeout(const Duration(milliseconds: 500), onTimeout: () {
          // data.clear();
          ipAddress = onIp;
          initial();
          return;
        });
        if (response.statusCode > 0) {
          // data.clear();
          ipAddress = locIp;
          initial();
        }
      }catch(e){
        print(e);
      }// initial();
    } else if (locIp == "false") {
      initial();
      ipAddress = locIp;
    }
  }

  Future<void> initial() async {
    loginData = await SharedPreferences.getInstance();
    username = loginData.getString('username');
    if (username == " ") {
      setState(() {
        username = userName;
      });
    }

    if (ipAddress == null) {
      fireData();
    } else if ((data == null) || (data.length == 0)) {
      if (ipAddress.toString() != 'false') {
        final response = await http.get(Uri.parse("http://$ipAddress/",));
        var fetchdata = jsonDecode(response.body);

        // final fanResponse = await http.get(Uri.parse("http://$ipAddress/fan/"));
        // var fan = jsonDecode(fanResponse.body);

        setState(() {
          localDataVal.clear();
          dumVariable.clear();
          var dumData = fetchdata;
          // var dumFanData = fan;
          for (int i = 0; i < dumData.length; i++) {
            dumVariable.add(dumData[i]["Room"].toString());
          }
          // for (int i = 0; i < dumFanData.length; i++) {
          //   dumVariable.add(dumFanData[i]["Room"].toString());
          // }
          localDataVal = dumVariable.toSet().toList();
          data = localDataVal;
          loginData.setStringList('dataValues', localDataVal);
          initial();
        });
      } else if ((ipAddress.toString() == 'false')) {
        // print("im inside the false");
        setState(() {
          getName();
        });
        //showAnotherAlertDialog(context);
      }
    } else {
      setState(() {
        // loader = true;
        //print("im going into the getName of list in initial ");
        getName();
      });
    }
  }

  firstProcess() async {
    loginData = await SharedPreferences.getInstance();
    databaseReference.child('family').once().then((value) {
      for (var element in value.snapshot.children) {
        ownerId = element.value;
        if (element.key == auth.currentUser.uid) {
          loginData.setString('ownerId', ownerId['owner-uid']);
          authKey = loginData.getString('ownerId');
          fireData();
          break;
        } else {
          loginData.setString('ownerId', auth.currentUser.uid);
          authKey = loginData.getString('ownerId');
          fireData();
        }
      }
    });
  }

  Future<void> fireData() async {
    databaseReference.child(auth.currentUser.uid).once().then((value) async {
      personalDataJson = value.snapshot.value;
      setState(() {
        userName = personalDataJson["name"];
        email = personalDataJson['email'];
        phoneNumber = personalDataJson['phone'].toString();
        owner = personalDataJson['owner'];
      });
    });

    databaseReference.child(authKey).once().then((snapshot) async {
      dataJson = snapshot.snapshot.value;
      setState(() {
        // bothOffOn = dataJson['localServer']['BothOfflineAndOnline'];
        noLocalServer = dataJson['noLocalServer'];
        localServer = dataJson['localServer'];
        bothOffOn =
        localServer != null ? localServer["BothOfflineAndOnline"] : false;

        if (noLocalServer != true) {
          if (bothOffOn == true) {
            ipLocal = localServer['offlineIp'].toString();
            onlineIp = localServer['staticIp'].toString();
            checkData();
            //firebase ****************
          } else {
            ipLocal = dataJson['offlineIp'].toString();
            onlineIp = "false";
            checkData();
          }
        } else {
          smartHome = dataJson['SmartHome'];
          ipLocal = "false";
          onlineIp = "false";
          doorData = dataJson['SmartHome'];
          smartDoor = doorData != null ? doorData['smartDoor'] : false;
          var len = smartHome['Devices'].length;
          for (int i = 1; i <= len; i++) {
            data.add(smartHome['Devices']['Id$i']['Room']);
          }
          checkData();
          getName();
        }
      });
    });
  }


  checkData() async {
    //print("im inside the check data of first page");
    loginData = await SharedPreferences.getInstance();
    if (ipLocal == "false") {
      loginData.setString('username', userName);
      loginData.setString('ip', ipLocal);
      loginData.setString('onlineIp', onlineIp);
      // loginData.setBool('owner', owner);
      // loginData.setBool('smartDoor', smartDoor);
      keyValues();
    } else {
      loginData.setString('ip', ipLocal);
      loginData.setString('onlineIp', onlineIp);
      loginData.setString('username', userName);
      loginData.setBool('owner', owner);
      loginData.setBool('smartDoor', smartDoor);
      keyValues();
    }
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

    // name = name.toSet().toList();
    // pg = pg.toSet().toList();

    setState(() {
      name = name.toSet().toList();
      pg = pg.toSet().toList();
      // print("$name  88889978");
    });
    //return "success";
  }

  Future<void> internet() async {
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
    hasInternet = await InternetConnectionChecker().hasConnection;
    result = await Connectivity().checkConnectivity();
  }

  @override
  void initState() {
    // fireData();
    checkData();
    firstProcess();
    // keyValues();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      keyValues();
      internet();
      // getName();
    });

    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final width = MediaQuery
        .of(context)
        .size
        .width;

    return Consumer<ThemeProvider>(
        builder: (context, taskData, child) {
          final task = taskData.listData;
          return ReorderableListView.builder(
              itemCount: name.length,
              itemBuilder: (BuildContext context, int index) {
                final String productName = name[index];
                return GestureDetector(
                  key: ValueKey(productName),
                  onTap: () {
                    setState(() {
                      isSelected = name[index].toString();
                    });
                    // print(task.last);
                    taskData.remove(task.last);
                    Provider.of<ThemeProvider>(context, listen: false).add(name[index].toString());
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
                      color: isSelected == name[index].toString()
                          ? Color.fromRGBO(247, 179, 28, 1.0)
                          : Color.fromRGBO(241, 241, 241, 1.0),
                    ),
                    child: ListTile(
                      title: Text(
                        "${name[index].toString()}",
                        style: GoogleFonts.poppins(color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: height * 0.020),),
                      // subtitle: Text("6 Devices"
                      //     , style: GoogleFonts.poppins(
                      //         color: Colors.black, fontSize: height * 0.012)
                      // ),
                    ),
                  ),
                );
              },
            onReorder: (oldIndex, newIndex) {
              setState(() {
                if (newIndex > oldIndex) {
                  newIndex = newIndex - 1;
                }
                final element = name.removeAt(oldIndex);
                name.insert(newIndex, element);
                // print(name);
                // final element1 = names.removeAt(oldIndex);
                // names.insert(newIndex, element1);
              });
            },
          );
        }
    );
  }
}


