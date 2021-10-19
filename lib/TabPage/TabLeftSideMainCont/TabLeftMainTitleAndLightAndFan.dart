import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
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
  _TabLeftMainTitleContainerState createState() => _TabLeftMainTitleContainerState();
}

class _TabLeftMainTitleContainerState extends State<TabLeftMainTitleContainer> with WidgetsBindingObserver {

  var task;
  List data;
  List dataValue;
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
  String userName= " ";
  String ipAddress = " ";

  List<Widget> _buildButtonsWithNames() {
    //print(" im inside the buildbutton--------------===========");
    buttonsList.clear();
    for (int i = 0; i < data.length; i++) {
      //print("im inside the build button");
      buttonOffline(i);
    }

      buttonsList = buttonsList.toSet().toList();

    return buttonsList;
  }

  List<Widget>_buildFanSlideWithNames(){
    buttonsList1.clear();
    for (int i = 0; i < data.length; i++) {
      //print("im inside the build button");
      fanSlide(i);
    }

    buttonsList1 = buttonsList1.toSet().toList();

    return buttonsList1;
  }

  String up;



  void fanSlide(int i){
    if (task.data == "Room Name") {
      Container(
        height: MediaQuery
            .of(context)
            .size
            .height * 0.010,
        width: MediaQuery.of(context).size.width * 1.0,
        child: Center(
          child: Text("Please Select Room "),
        ),
      );
    }
    else {
      if (data[i].toString().contains("Slide") &&
          data[i].toString().contains(task.data)) {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.015,
                  ),
                  Text(
                    "Fan",
                    style: GoogleFonts.poppins(
                        color: Theme.of(context).backgroundColor,
                        fontSize: MediaQuery.of(context).size.height * 0.018),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.001,
                  ),
                  Expanded(
                    child: Slider(
                      min: 0.0,
                      max: 4.0,
                      divisions: 5,
                      label:  dataValue[0][i].toString().substring(0, 4),
                      activeColor: Color.fromRGBO(247, 179, 28, 0.6),
                      inactiveColor: Colors.grey.shade300,
                      value: double.parse(dataValue[0][i]),
                      onChanged: (double value) {
                        check().then((intenet) {
                          if (intenet) {
                            // Internet Present Case
                            setState(() {
                              dataValue[0][i] = value.toInt().toString();
                              /*update_value(data[i], data_value[0][i], i);
                          _buildButtonsWithNames();*/
                            });
                            //print("Connection: present");
                          } else {
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  backgroundColor: Colors.black,
                                  title: Text(
                                    "No Internet Connection",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  content: Text(
                                      "Please check your Internet Connection",
                                      style: TextStyle(color: Colors.white)),
                                ));
                          }
                          setState(() {
                            updateValue(data[i], dataValue[0][i], i);
                            _buildButtonsWithNames();
                          });
                        });
                      },
                    ),
                  ),
                ]),
          ),
        ));
      }
    }
  }
  void buttonOffline(int i) {
    if (task.data == "Room Name") {
      Container(
        height: MediaQuery
            .of(context)
            .size
            .height * 0.010,
        width: MediaQuery.of(context).size.width * 1.0,
        child: Center(
          child: Text("Please Select Room "),
        ),
      );
    }
    else {
      if (data[i].toString().contains("Button") &&
          data[i].toString().contains(task.data)) {
        buttonsList.add(Container(
          child: InkWell(
              onTap: () {

                check().then((intenet) {
                  if (intenet) {
                    // Internet Present Case

                    if ((dataValue[0][i] == 1) || (dataValue[0][i] == "1")) {
                      //print("im inside the if of inkwell ++++++++++");
                      setState(() {
                        dataValue[0][i] = 0;
                        up = "False";
                      });
                    } else {
                      setState(() {
                        dataValue[0][i] = 1;
                        up = "True";
                      });
                    }
                    setState(() {
                      // if(widget.check_url==false){
                      //   update_value(data[i],data_value[0][i], i);
                      // }else{
                      //   update_value(data[i],up, i);
                      // }
                      updateValue(data[i], up, i);
                      _buildButtonsWithNames();
                    });
                    //print("Connection: present");
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
                  //   //print("Connection: not present");
                  // }
                });
              },
              child: Container(
                margin: EdgeInsets.all(5.0),
                  padding: EdgeInsets.all(20.0),
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.20,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: (dataValue[0][i] == 0) || (dataValue[0][i] == "0")
                        ? Theme
                        .of(context)
                        .scaffoldBackgroundColor
                        : Color.fromRGBO(247, 179, 28, 1.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.060,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.04,
                        decoration: BoxDecoration(
                            color: (dataValue[0][i] == 0) ||
                                (dataValue[0][i] == "0") ? Color.fromRGBO(247, 179, 28, 0.19) :
                            Theme.of(context).scaffoldBackgroundColor ,
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Center(
                          child: SvgPicture.asset(
                            "images/icons/light.svg",
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.035,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.010,
                      ),
                      (dataValue[0][i] == 1) || (dataValue[0][i] == "1")
                          ? Text(
                        data[i].toString().split("Button")[0].replaceAll(
                            "_", " ") + "",
                        style: GoogleFonts.poppins(
                            color: (dataValue[0][i] == 0) ||
                                (dataValue[0][i] == "0") ?Theme
                                .of(context)
                                .backgroundColor : Theme
                                .of(context)
                                .scaffoldBackgroundColor,
                            fontSize:
                            MediaQuery
                                .of(context)
                                .size
                                .height * 0.018),
                      )
                          : Text(
                        data[i].toString().split("Button")[0].replaceAll(
                            "_", " ") + "",
                        style: GoogleFonts.poppins(
                            color: (dataValue[0][i] == 0) ||
                                (dataValue[0][i] == "0") ?Theme
                                .of(context)
                                .backgroundColor : Theme
                                .of(context)
                                .scaffoldBackgroundColor,
                            fontSize:
                            MediaQuery
                                .of(context)
                                .size
                                .height * 0.018),
                      ),
                      (dataValue[0][i] == 0) || (dataValue[0][i] == "0")?
                      Text(
                        "off",
                        style: GoogleFonts.poppins(
                            fontSize: MediaQuery
                                .of(context)
                                .size
                                .height * 0.015),
                      ):Text(
                        "On",
                        style: GoogleFonts.poppins(
                            fontSize: MediaQuery
                                .of(context)
                                .size
                                .height * 0.015),
                      ),
                    ],
                  ))),
        ));
      }
      else if (data[i].toString().contains("Push") &&
          data[i].toString().contains(task.data)) {
        buttonsList.add(Container(
            child: InkWell(
                onTap: () {
                  check().then((intenet) {
                    if (intenet) {
                      // Internet Present Case
                      if ((dataValue[0][i] == 1) ||
                          (dataValue[0][i] == "1")) {
                        setState(() {
                          dataValue[0][i] = 0;
                          up = "False";
                        });
                      } else {
                        setState(() {
                          dataValue[0][i] = 1;
                          up = "True";
                        });
                      }
                      setState(() {
                        updateValue(data[i], up, i);
                        _buildButtonsWithNames();
                      });
                      //print("Connection: present");
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
                    //   //print("Connection: not present");
                    // }
                  });
                },
                child: Container(
                    margin: EdgeInsets.all(5.0),
                    padding: EdgeInsets.all(20.0),
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.20,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: (dataValue[0][i] == 0) ||
                          (dataValue[0][i] == "0")
                          ? Theme
                          .of(context)
                          .scaffoldBackgroundColor
                          : Color.fromRGBO(247, 179, 28, 1.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.060,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.04,
                          decoration: BoxDecoration(
                              color: (dataValue[0][i] == 0) ||
                                  (dataValue[0][i] == "0") ? Color.fromRGBO(247, 179, 28, 0.19) :
                              Theme.of(context).scaffoldBackgroundColor ,
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Center(
                            child: SvgPicture.asset(
                              "images/icons/light.svg",
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.035,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.010,
                        ),
                        (dataValue[0][i] == 1) || (dataValue[0][i] == "1")
                            ? Text(
                          data[i]
                              .toString()
                              .split("Fan")[0]
                              .replaceAll("_", " ") +
                              "",
                          style: GoogleFonts.poppins(
                              color: (dataValue[0][i] == 0) ||
                                  (dataValue[0][i] == "0") ?Theme
                                  .of(context)
                                  .backgroundColor : Theme
                                  .of(context)
                                  .scaffoldBackgroundColor,
                              fontSize:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.018),
                        ) : Text(
                          data[i]
                              .toString()
                              .split("Fan")[0]
                              .replaceAll("_", " ") +
                              "", style: GoogleFonts.poppins(
                            color: (dataValue[0][i] == 0) ||
                                (dataValue[0][i] == "0") ?Theme
                                .of(context)
                                .backgroundColor : Theme
                                .of(context)
                                .scaffoldBackgroundColor,
                            fontSize:
                            MediaQuery
                                .of(context)
                                .size
                                .height * 0.018),
                        ),

                        (dataValue[0][i] == 0) || (dataValue[0][i] == "0")?
                        Text(
                          "off",
                          style: GoogleFonts.poppins(
                              fontSize: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.015),
                        ):Text(
                          "On",
                          style: GoogleFonts.poppins(
                              fontSize: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.015),
                        )
                      ],
                    )))));
      }
      else if (data[i].toString().contains("Switch") &&
          data[i].toString().contains(task.data)) {
        buttonsList.add(Container(
            child: InkWell(
                onTap: () {
                  check().then((intenet) {
                    if (intenet) {
                      // Internet Present Case
                      if ((dataValue[0][i] == 1) ||
                          (dataValue[0][i] == "1")) {
                        setState(() {
                          dataValue[0][i] = 0;
                          up = "False";
                        });
                      } else {
                        setState(() {
                          dataValue[0][i] = 1;
                          up = "True";
                        });
                      }
                      setState(() {

                        updateValue(data[i], up, i);
                        _buildButtonsWithNames();
                      });
                      //print("Connection: present");
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
                    //   //print("Connection: not present");
                    // }
                  });
                },
                child: Container(
                    margin: EdgeInsets.all(5.0),
                    padding: EdgeInsets.all(20.0),
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.20,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: (dataValue[0][i] == 0) ||
                          (dataValue[0][i] == "0")
                          ? Theme
                          .of(context)
                          .scaffoldBackgroundColor
                          : Color.fromRGBO(247, 179, 28, 1.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.060,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.04,
                          decoration: BoxDecoration(
                              color: (dataValue[0][i] == 0) ||
                                  (dataValue[0][i] == "0") ? Color.fromRGBO(247, 179, 28, 0.19) :
                              Theme.of(context).scaffoldBackgroundColor ,
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Center(
                            child: SvgPicture.asset(
                              "images/icons/light.svg",
                              height: MediaQuery.of(context).size.height * 0.035,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.010,
                        ),
                        (dataValue[0][i] == 1) || (dataValue[0][i] == "1")
                ? Text(data[i].toString().split("Switch")[0].replaceAll("_", " ") + "",
                          style: GoogleFonts.poppins(
                              color:(dataValue[0][i] == 0) ||
                                  (dataValue[0][i] == "0") ?Theme
                                  .of(context)
                                  .backgroundColor : Theme
                                  .of(context)
                                  .scaffoldBackgroundColor,
                              fontSize:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.016),
                        ) : Text(
                          data[i]
                              .toString()
                              .split("Switch")[0]
                              .replaceAll("_", " ") +
                              "", style: GoogleFonts.poppins(
                            color: (dataValue[0][i] == 0) ||
                                (dataValue[0][i] == "0") ?Theme
                                .of(context)
                                .backgroundColor : Theme
                                .of(context)
                                .scaffoldBackgroundColor,
                            fontSize:
                            MediaQuery
                                .of(context)
                                .size
                                .height * 0.016),
                        ),
                        (dataValue[0][i] == 0) || (dataValue[0][i] == "0")?
                        Text(
                          "off",
                          style: GoogleFonts.poppins(
                              fontSize: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.015),
                        ):Text(
                          "On",
                          style: GoogleFonts.poppins(
                              fontSize: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.015),
                        ),
                      ],
                    )))));
      }
    }
  }

  getData(){

    databaseReference.child(auth.currentUser.uid).once().then((DataSnapshot snapshot) async {

      setState(() {
        dataJson = snapshot.value;
        //print(dataJson);
        userName = dataJson["name"];
        ipAddress= dataJson["ip"].toString();
      });
      loginData = await SharedPreferences.getInstance();
      loginData.setString('username',userName);
      loginData.setString('ip', ipAddress);

      setState(() {
        username = loginData.getString('username');
        ip = loginData.getString('ip');
      });


      if(result == ConnectivityResult.wifi) {
        //print("wifi =============_________(((((((((()))))))");
        getName();
      }
      else if((result == ConnectivityResult.mobile)&&(!mobNotifier)){
        //print("mobile ****************************");
        if((!mobNotifier) && (ipAddress.toString().toLowerCase() == 'false')){
          showSimpleNotification(
            Text(" your are on Mobile Data  ",
              style: TextStyle(color: Colors.white),), background: Colors.green,
          );
        }
        else{
          showSimpleNotification(
            Text(" please switch on your wifi network ",
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

    });
  }



  Future<http.Response> updateValue(button, buttonValue, i) async {
    final response = await http.get(Uri.http("$ip", "/$button/$buttonValue"));
    if (response.statusCode == 200) {
      result = true;

      if (response.body != "success");
      // _showScaffold("Update Failed, Please check server or internet connection and retry");
    } else {
      if ((dataValue[0][i] == 0) || (dataValue[0][i] == "0")) {
        setState(() {

          dataValue[0][i] = 1;
          _buildButtonsWithNames();
          _buildFanSlideWithNames();
        });
      } else {
        setState(() {

          dataValue[0][i] = 0;
          _buildButtonsWithNames();
          _buildFanSlideWithNames();
        });
      }
      result = false;
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
    return response;
  }

  Future<http.Response> call() async {

    final response = await http.get(Uri.http("$ip", "/key"));
    if (response.statusCode == 200) {

      setState(() {
        data = jsonDecode(response.body);

      });

      // print("values $data");
      // print("response: ${response.body}");
      result = true;
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //  return Album.fromJson(json.decode(response.body));
    } else {
      setState(() {
        result = false;
      });
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }

    return response;
  }

  Future<bool> callValue() async {

    final response = await http.get(Uri.http("$ip", "/value"));

    if (response.statusCode == 200) {

      setState(() {
        dataValue = jsonDecode(response.body);

      });

      result2 = true;

      Future.delayed(const Duration(seconds: 5), () {
// Here you can write your code

        setState(() {

          for (int i = 0; i < dataValue.length; i++) {

            dataValue[0][i] = dataValue[0][i];

          }

          // _buildButtonsWithNames();

          // Here you can write your code for open new view
        });
      });
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //  return Album.fromJson(json.decode(response.body));
    } else {
      setState(() {
        result2 = false;
      });
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
    return true;
  }



  Future getName() async {
    //final response = await http.get('http://34.83.46.202.xip.io/cyberhome/home.php?username=${widget.email}&query=table');
    //final response = await http.get('http://$local_ip/key/');

    final response = await http.get(Uri.http("$ip", "/key"));
    var fetchData = jsonDecode(response.body);


    if (response.statusCode == 200) {
      setState(() {

        data = fetchData;

      });

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
        } else if (data[i].toString().contains("_Bedroom1") &&
            (!name.contains(data[i].toString().contains("Bedroom_1")))) {
          name.add("Bedroom_1");
          pg.add("Bedroom_1");
        } else if (data[i].toString().contains("_Bedroom2") &&
            (!name.contains(data[i].toString().contains("Bedroom_2")))) {
          name.add("Bedroom_2");
          pg.add("Bedroom_2");
        } else if (data[i].toString().contains("_Bedroom") &&
            (!name.contains(data[i].toString().contains("Bedroom")))) {
          name.add("Bedroom");
          pg.add("Bedroom");
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
    }

    setState(() {

      name = name.toSet().toList();
      pg = pg.toSet().toList();

    });
    return "success";
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
    // initial();
    getData();
    // print("mood check ${widget.isDark}");
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
            (Timer t) =>
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
              // }
            }));
    //  call_value();
    super.initState();
    // print("data ${data.toString()}");
    // print("data_value ${data_value.toString()}");

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
              (Timer t) =>
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
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark ? 'Light' : 'Dark' ;
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
           task = taskData.listData[0];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 19.0),
            child: Container(
              height: height * 0.965,
              width: width * 0.70,
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Theme
                    .of(context)
                    .primaryColor,
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
                                    //widget.roomName.toString().replaceAll("_", " "),
                                    Text(task.data.toString().replaceAll("_", " "),
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize: height * 0.030,
                                          color: Theme
                                              .of(context)
                                              .backgroundColor,)),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.010,
                                ),
                                Text("Lights",
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
                                      color: Theme
                                          .of(context)
                                          .backgroundColor,)),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        //TabLeftLightsContainer(),
                        result && result2 ?Container(
                          height: height * 0.20,
                          width: width * 1.0,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: _buildButtonsWithNames(),
                          ),
                        ): Container(),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        Text("Fans", style: GoogleFonts.poppins(
                          fontSize: height * 0.020,),),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        //TabLeftFanContainer(),
                        result && result2 ?Container(
                          height: height * 0.20,
                          width: width * 1.0,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: _buildFanSlideWithNames(),
                          ),
                        ): Container(),
                        SizedBox(
                          height: height * 0.020,
                        ),
                        Text("Others Rooms",
                          style: GoogleFonts.poppins(fontSize: height * 0.020,
                            color: Theme
                                .of(context)
                                .backgroundColor,),),
                        SizedBox(
                          height: height * 0.021,
                        ),
                        TabLeftOtherScrollView()
                      ],
                    ),
                  )),
            ),
          );
        }
    );
  }
}
