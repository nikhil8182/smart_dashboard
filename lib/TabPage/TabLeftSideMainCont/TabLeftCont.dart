import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_dashboard/TabPage/TabLeftSideMainCont/TabLeftFanCont.dart';
import 'package:smart_dashboard/TabPage/TabLeftSideMainCont/TabLeftLightsCont.dart';
import 'package:smart_dashboard/TabPage/TabLeftSideMainCont/TabLeftMainContainerTitle.dart';
import 'package:smart_dashboard/TabPage/TabLeftSideMainCont/TabLeftOtherScrollView.dart';
import 'package:smart_dashboard/TabPage/TabLeftSideMainCont/TabLeftOthersCont.dart';
import 'package:smart_dashboard/TabPage/TabRightSideMainCont/TabRightRoomsContainer.dart';
import 'package:smart_dashboard/theme/change_theme_button_widget.dart';
import 'package:smart_dashboard/theme/theme_provider.dart';


class TabLeftContainer extends StatefulWidget {

// TabLeftContainer({this.roomName,this.index,this.ip});
//   final String roomName;
//   final int index;
//   final String ip;

  @override
  _TabLeftContainerState createState() => _TabLeftContainerState();
}

class _TabLeftContainerState extends State<TabLeftContainer>     with WidgetsBindingObserver {
  // List<Widget> _buildButtonsWithNames() {
  //   //print(" im inside the buildbutton--------------===========");
  //   buttonsList.clear();
  //   for (int i = 0; i < data.length; i++) {
  //     //print("im inside the build button");
  //     buttonOffline(i);
  //   }
  //   setState(() {
  //     buttonsList = buttonsList.toSet().toList();
  //   });
  //   return buttonsList;
  // }

  String up;

  // void buttonOffline(int i) {
  //   //print("${data[i]}");
  //   if (data[i].toString().contains("Button") &&
  //       data[i].toString().contains(widget.roomName)) {
  //     // print("im inside the button above button list container");
  //     // print("$buttonsList ");
  //     buttonsList.add(Container(
  //       child: InkWell(
  //           onTap: () {
  //             //print("im inside the inkwell on Tap()");
  //             check().then((intenet) {
  //               //print("im inside the inkwell");
  //               if (intenet) {
  //                 // Internet Present Case
  //                 //print("im inside the button above if ");
  //                 if ((data_value[0][i] == 1) || (data_value[0][i] == "1")) {
  //                   //print("im inside the if of inkwell ++++++++++");
  //                   setState(() {
  //                     data_value[0][i] = 0;
  //                     up = "False";
  //                   });
  //                 } else {
  //                   setState(() {
  //                     data_value[0][i] = 1;
  //                     up = "True";
  //                   });
  //                 }
  //                 setState(() {
  //                   // if(widget.check_url==false){
  //                   //   update_value(data[i],data_value[0][i], i);
  //                   // }else{
  //                   //   update_value(data[i],up, i);
  //                   // }
  //                   update_value(data[i], up, i);
  //                   // print("${data_value[0][i]} data value is =================");
  //                   // print("$up the value of up is *************");
  //                   // print("$i after i is+++++++++++++++++------");
  //                   _buildButtonsWithNames();
  //                 });
  //                 //print("Connection: present");
  //               } else {
  //                 showDialog(
  //                     context: context,
  //                     builder: (_) => AlertDialog(
  //                       backgroundColor: Colors.black,
  //                       title: Text(
  //                         "No Internet Connection",
  //                         style: TextStyle(color: Colors.white),
  //                       ),
  //                       content: Text(
  //                           "Please check your Internet Connection",
  //                           style: TextStyle(color: Colors.white)),
  //                     ));
  //                 //print("Connection: not present");
  //               }
  //             });
  //           },
  //           // child: Container(
  //           //     height: MediaQuery.of(context).size.height * 0.17,
  //           //     width: MediaQuery.of(context).size.width * 0.37,
  //           //     padding: const EdgeInsets.all(10),
  //           //     margin: EdgeInsets.all(10),
  //           //     decoration: BoxDecoration(
  //           //         color: (data_value[0][i] == 0) || (data_value[0][i] == "0")? Colors.grey[900]:Colors.orange,
  //           //         borderRadius: BorderRadius.circular(20.0),
  //           //         boxShadow: [
  //           //           BoxShadow(
  //           //               offset: Offset(0, 0),
  //           //               color: Colors.grey[700],
  //           //               blurRadius: 1,
  //           //               spreadRadius: 1),
  //           //           BoxShadow(
  //           //               offset: Offset(1, 1),
  //           //               color: Colors.black87,
  //           //               blurRadius: 1,
  //           //               spreadRadius: 1)
  //           //         ]),
  //           //     child: Column(
  //           //       mainAxisAlignment: MainAxisAlignment.center,
  //           //       crossAxisAlignment: CrossAxisAlignment.center,
  //           //       children: [
  //           //         Container(
  //           //           height: MediaQuery.of(context).size.height * 0.08,
  //           //           width: MediaQuery.of(context).size.width * 0.25,
  //           //           child:
  //           //           SvgPicture.asset(
  //           //             "images/light.svg",
  //           //             height: MediaQuery.of(context).size.height * 0.010,
  //           //           ),
  //           //         ),
  //           //         SizedBox(
  //           //           height: MediaQuery.of(context).size.height * 0.015,
  //           //         ),
  //           //         Container(
  //           //           child: Column(
  //           //             children: [
  //           //               (data_value[0][i] == 1) || (data_value[0][i] == "1")
  //           //                   ? AutoSizeText(
  //           //                 data[i]
  //           //                     .toString()
  //           //                     .split("Button")[0]
  //           //                     .replaceAll("_", " ") +
  //           //                     "",
  //           //                 style: GoogleFonts.robotoSlab(
  //           //                   /*fontSize: 12,*/ color: Colors.white),
  //           //                 maxLines: 1,
  //           //                 minFontSize: 7,
  //           //               )
  //           //                   : AutoSizeText(
  //           //                 data[i]
  //           //                     .toString()
  //           //                     .split("Button")[0]
  //           //                     .replaceAll("_", " ") +
  //           //                     "",
  //           //                 style: GoogleFonts.robotoSlab(
  //           //                   /*fontSize: 12,*/ color: Colors.white),
  //           //                 maxLines: 1,
  //           //                 minFontSize: 7,
  //           //               ),
  //           //             ],
  //           //           ),
  //           //         ),
  //           //       ],
  //           //     ))),
  //           child: Container(
  //               padding: EdgeInsets.all(20.0),
  //               height: MediaQuery.of(context).size.height * 0.20,
  //               width: MediaQuery.of(context).size.width * 0.12,
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(25.0),
  //                 color: (data_value[0][i] == 0) || (data_value[0][i] == "0")
  //                     ? Theme.of(context).scaffoldBackgroundColor
  //                     : Color.fromRGBO(247, 179, 28, 1.0),
  //               ),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Container(
  //                     height: MediaQuery.of(context).size.height * 0.060,
  //                     width: MediaQuery.of(context).size.width * 0.04,
  //                     decoration: BoxDecoration(
  //                         color: Color.fromRGBO(247, 179, 28, 0.19),
  //                         borderRadius: BorderRadius.circular(15.0)),
  //                     child: Center(
  //                       child: SvgPicture.asset(
  //                         "images/icons/light.svg",
  //                         height: MediaQuery.of(context).size.height * 0.035,
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: MediaQuery.of(context).size.height * 0.015,
  //                   ),
  //                   (data_value[0][i] == 1) || (data_value[0][i] == "1")
  //                       ? Text(data[i].toString().split("Button")[0].replaceAll("_", " ") +"",
  //                     style: GoogleFonts.poppins(
  //                         color: Theme.of(context).backgroundColor,
  //                         fontSize:
  //                         MediaQuery.of(context).size.height * 0.018),
  //                   )
  //                       : Text(data[i].toString() .split("Button")[0].replaceAll("_", " ") + "",
  //                     style: GoogleFonts.poppins(
  //                         color: Theme.of(context).backgroundColor,
  //                         fontSize:
  //                         MediaQuery.of(context).size.height * 0.018),
  //                   ),
  //                   SizedBox(
  //                     height: MediaQuery.of(context).size.height * 0.006,
  //                   ),
  //                   Text(
  //                     "off",
  //                     style: GoogleFonts.poppins(
  //                         fontSize: MediaQuery.of(context).size.height * 0.015),
  //                   ),
  //                 ],
  //               ))),
  //     ));
  //   } else if (data[i].toString().contains("Push") &&
  //       data[i].toString().contains(widget.roomName)) {
  //     buttonsList.add(Container(
  //         child: InkWell(
  //             onTap: () {
  //               check().then((intenet) {
  //                 if (intenet) {
  //                   // Internet Present Case
  //                   if ((data_value[0][i] == 1) || (data_value[0][i] == "1")) {
  //                     setState(() {
  //                       data_value[0][i] = 0;
  //                       up = "False";
  //                     });
  //                   } else {
  //                     setState(() {
  //                       data_value[0][i] = 1;
  //                       up = "True";
  //                     });
  //                   }
  //                   setState(() {
  //                     // if(widget.check_url==false){
  //                     //   update_value(data[i],data_value[0][i], i);
  //                     // }else{
  //                     //   update_value(data[i],up, i);
  //                     // }
  //
  //                     update_value(data[i], up, i);
  //                     _buildButtonsWithNames();
  //                   });
  //                   //print("Connection: present");
  //                 } else {
  //                   showDialog(
  //                       context: context,
  //                       builder: (_) => AlertDialog(
  //                         backgroundColor: Colors.black,
  //                         title: Text(
  //                           "No Internet Connection",
  //                           style: TextStyle(color: Colors.white),
  //                         ),
  //                         content: Text(
  //                             "Please check your Internet Connection",
  //                             style: TextStyle(color: Colors.white)),
  //                       ));
  //                   //print("Connection: not present");
  //                 }
  //               });
  //             },
  //             child: Container(
  //                 padding: EdgeInsets.all(20.0),
  //                 height: MediaQuery.of(context).size.height * 0.20,
  //                 width: MediaQuery.of(context).size.width * 0.12,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(25.0),
  //                   color: (data_value[0][i] == 0) || (data_value[0][i] == "0")
  //                       ? Theme.of(context).scaffoldBackgroundColor
  //                       : Color.fromRGBO(247, 179, 28, 1.0),
  //                 ),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Container(
  //                       height: MediaQuery.of(context).size.height * 0.060,
  //                       width: MediaQuery.of(context).size.width * 0.04,
  //                       decoration: BoxDecoration(
  //                           color: Color.fromRGBO(247, 179, 28, 0.19),
  //                           borderRadius: BorderRadius.circular(15.0)),
  //                       child: Center(
  //                         child: SvgPicture.asset(
  //                           "images/icons/light.svg",
  //                           height: MediaQuery.of(context).size.height * 0.035,
  //                         ),
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       height: MediaQuery.of(context).size.height * 0.015,
  //                     ),
  //                     (data_value[0][i] == 1) || (data_value[0][i] == "1")
  //                         ? Text(
  //                       data[i]
  //                           .toString()
  //                           .split("Fan")[0]
  //                           .replaceAll("_", " ") +
  //                           "",
  //                       style: GoogleFonts.poppins(
  //                           color: Theme.of(context).backgroundColor,
  //                           fontSize:
  //                           MediaQuery.of(context).size.height * 0.018),
  //                     ): Text(
  //                       data[i]
  //                           .toString()
  //                           .split("Fan")[0]
  //                           .replaceAll("_", " ") +
  //                           "",style: GoogleFonts.poppins(
  //                         color: Theme.of(context).backgroundColor,
  //                         fontSize:
  //                         MediaQuery.of(context).size.height * 0.018),
  //                     ),
  //                     SizedBox(
  //                       height: MediaQuery.of(context).size.height * 0.006,
  //                     ),
  //                     Text(
  //                       "off",
  //                       style: GoogleFonts.poppins(
  //                           fontSize:
  //                           MediaQuery.of(context).size.height * 0.015),
  //                     ),
  //                   ],
  //                 )))));
  //   } else if (data[i].toString().contains("Switch") &&
  //       data[i].toString().contains(widget.roomName)) {
  //     buttonsList.add(Container(
  //         child: InkWell(
  //             onTap: () {
  //               check().then((intenet) {
  //                 if (intenet) {
  //                   // Internet Present Case
  //                   if ((data_value[0][i] == 1) || (data_value[0][i] == "1")) {
  //                     setState(() {
  //                       data_value[0][i] = 0;
  //                       up = "False";
  //                     });
  //                   } else {
  //                     setState(() {
  //                       data_value[0][i] = 1;
  //                       up = "True";
  //                     });
  //                   }
  //                   setState(() {
  //                     // if(widget.check_url==false){
  //                     //   update_value(data[i],data_value[0][i], i);
  //                     // }else{
  //                     //   update_value(data[i],up, i);
  //                     // }
  //
  //                     update_value(data[i], up, i);
  //                     _buildButtonsWithNames();
  //                   });
  //                   //print("Connection: present");
  //                 } else {
  //                   showDialog(
  //                       context: context,
  //                       builder: (_) => AlertDialog(
  //                         backgroundColor: Colors.black,
  //                         title: Text(
  //                           "No Internet Connection",
  //                           style: TextStyle(color: Colors.white),
  //                         ),
  //                         content: Text(
  //                             "Please check your Internet Connection",
  //                             style: TextStyle(color: Colors.white)),
  //                       ));
  //                   //print("Connection: not present");
  //                 }
  //               });
  //             },
  //             child: Container(
  //                 padding: EdgeInsets.all(20.0),
  //                 height: MediaQuery.of(context).size.height * 0.20,
  //                 width: MediaQuery.of(context).size.width * 0.12,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(25.0),
  //                   color: (data_value[0][i] == 0) || (data_value[0][i] == "0")
  //                       ? Theme.of(context).scaffoldBackgroundColor
  //                       : Color.fromRGBO(247, 179, 28, 1.0),
  //                 ),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Container(
  //                       height: MediaQuery.of(context).size.height * 0.060,
  //                       width: MediaQuery.of(context).size.width * 0.04,
  //                       decoration: BoxDecoration(
  //                           color: Color.fromRGBO(247, 179, 28, 0.19),
  //                           borderRadius: BorderRadius.circular(15.0)),
  //                       child: Center(
  //                         child: SvgPicture.asset(
  //                           "images/icons/light.svg",
  //                           height: MediaQuery.of(context).size.height * 0.035,
  //                         ),
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       height: MediaQuery.of(context).size.height * 0.015,
  //                     ),
  //                     (data_value[0][i] == 1) || (data_value[0][i] == "1")
  //                         ? Text(
  //                       data[i]
  //                           .toString()
  //                           .split("Switch")[0]
  //                           .replaceAll("_", " ") +
  //                           "",
  //                       style: GoogleFonts.poppins(
  //                           color: Theme.of(context).backgroundColor,
  //                           fontSize:
  //                           MediaQuery.of(context).size.height * 0.018),
  //                     ) : Text(
  //                       data[i]
  //                           .toString()
  //                           .split("Switch")[0]
  //                           .replaceAll("_", " ") +
  //                           "",style: GoogleFonts.poppins(
  //                         color: Theme.of(context).backgroundColor,
  //                         fontSize:
  //                         MediaQuery.of(context).size.height * 0.018),
  //                     ),
  //                     SizedBox(
  //                       height: MediaQuery.of(context).size.height * 0.006,
  //                     ),
  //                     Text(
  //                       "off",
  //                       style: GoogleFonts.poppins(
  //                           fontSize:
  //                           MediaQuery.of(context).size.height * 0.015),
  //                     ),
  //                   ],
  //                 )))));
  //   }
  // }

  SharedPreferences loginData;
  String ip = "192.168.1.18:8000";

  // void initial() async {
  //   local_ip = widget.local_ip;
  //   //print("im inside the initial function $local_ip");
  //   loginData = await SharedPreferences.getInstance();
  //   setState(() {
  //     loginData.setString('ip', local_ip);
  //     ip = loginData.getString('ip');
  //     //print("im inside the setstate of initial $ip");
  //   });
  // }

  // Future<http.Response> update_value(button, button_value, i) async {
  //   final response = await http.get(Uri.http("$ip", "/$button/$button_value"));
  //   if (response.statusCode == 200) {
  //     result = true;
  //     print("im inside the update the value");
  //     // print("response 1 : ${response.body}");
  //     if (response.body != "success") ;
  //     // _showScaffold("Update Failed, Please check server or internet connection and retry");
  //   } else {
  //     if ((data_value[0][i] == 0) || (data_value[0][i] == "0")) {
  //       setState(() {
  //         print("im inside the if loop of update value");
  //         data_value[0][i] = 1;
  //         _buildButtonsWithNames();
  //       });
  //     } else {
  //       setState(() {
  //         print("im inside the else case of update values");
  //         data_value[0][i] = 0;
  //         _buildButtonsWithNames();
  //       });
  //     }
  //     result = false;
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception('Failed to load album');
  //   }
  //   return response;
  // }

  Future<http.Response> call() async {
    //print("im inside the calll 0----0099898");
    final response = await http.get(Uri.http("$ip", "/key"));
    if (response.statusCode == 200) {
      // print("response: ${response.statusCode}");
      setState(() {
        data = jsonDecode(response.body);
        //print("$data inside the value of setstate in if case");
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

  Future<bool> call_value() async {
    //print("im inside the call by 74873268768723657 value 0----0099898");

    //print("im inside the if loop of call_value *********************");
    final response = await http.get(Uri.http("$ip", "/value"));

    if (response.statusCode == 200) {
      // print("response: ${response.statusCode}");
      setState(() {
        data_value = jsonDecode(response.body);
        //print("-----$data_value  value of data_value-----");
      });
      // print("response 2: ${response.body}");
      result2 = true;

      Future.delayed(const Duration(seconds: 5), () {
// Here you can write your code

        //print("im inside the if of future delay");
        setState(() {
          //print("****************************we are checking the below line**********************************************");
          // print("after");

          for (int i = 0; i < data_value.length; i++) {
            //print("${data_value.length} the value inside the setstate of data_value");
            data_value[0][i] = data_value[0][i];
            //print("${data_value[0][i]} the value of data_value");
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

  List data;
  List data_value;
  List<Container> buttonsList = List<Container>();
  String title;
  bool result = false;
  bool result2 = false;
  Color c;
  bool isSwitched;
  Timer timer;
  List name = [];
  List pg = [];
  String button_name;
  String local_ip;

  Future get_name() async {
    //final response = await http.get('http://34.83.46.202.xip.io/cyberhome/home.php?username=${widget.email}&query=table');
    //final response = await http.get('http://$local_ip/key/');

    // print("${widget.local_ip} im inside the getname checking local local ip");
    // print("$ip ip inside the getname");

    //print("iam using offline json");

    final response = await http.get(Uri.http("$ip", "/key"));
    var fetchdata = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        data = fetchdata;
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
      //print("$name  of the individual page");
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
    get_name();
    // print("mood check ${widget.isDark}");
    check().then((intenet) {
      if (intenet) {
        call().then((value) => call_value());
      } else {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              backgroundColor: Colors.black,
              title: Text(
                "No Internet Connection",
                style: TextStyle(color: Colors.white),
              ),
              content: Text("Please check your Internet Connection",
                  style: TextStyle(color: Colors.white)),
            ));
        //print("Connection: not present");
      }
    });
    timer = Timer.periodic(
        Duration(seconds: 3),
            (Timer t) => check().then((intenet) {
          if (intenet) {
            call().then((value) => call_value());
          } else {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  backgroundColor: Colors.black,
                  title: Text(
                    "No Internet Connection",
                    style: TextStyle(color: Colors.white),
                  ),
                  content: Text("Please check your Internet Connection",
                      style: TextStyle(color: Colors.white)),
                ));
          }
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
      check().then((intenet) {
        if (intenet) {
          call().then((value) => call_value());
        } else {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                backgroundColor: Colors.black,
                title: Text(
                  "No Internet Connection",
                  style: TextStyle(color: Colors.white),
                ),
                content: Text("Please check your Internet Connection",
                    style: TextStyle(color: Colors.white)),
              ));
          //print("Connection: not present");
        }
      });
      timer = Timer.periodic(
          Duration(seconds: 3),
              (Timer t) => check().then((intenet) {
            if (intenet) {
              call().then((value) => call_value());
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
  bool livingRoomSts =false ;

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
        ? 'Light'
        : 'Dark';
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // return Padding(
    //     padding: EdgeInsets.symmetric(horizontal: 19.0),
    //     child: Container(
    //       height: height * 0.965,
    //       width: width * 0.70,
    //       padding: EdgeInsets.all(20.0),
    //       decoration: BoxDecoration(
    //         color: Theme.of(context).primaryColor,
    //         borderRadius: BorderRadius.circular(40.0),
    //       ),
    //       //child: TabLeftMainContainerTitle(roomName: widget.roomName,ip: widget.ip,index: widget.index,),
    //       child: Container(
    //           child: Padding(
    //             padding: EdgeInsets.all(5.0),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               children: [
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Row(
    //                           children: [//widget.roomName.toString().replaceAll("_", " "),
    //                             Text(widget.roomName.toString().replaceAll("_", " "),
    //                                 style: GoogleFonts.poppins(
    //                                   fontWeight: FontWeight.bold,
    //                                   fontSize: height*0.030,
    //                                   color: Theme.of(context).backgroundColor,)),
    //                             // Switch(
    //                             //   value: livingRoomSts,
    //                             //   onChanged: (bool value){
    //                             //     setState(() {
    //                             //       livingRoomSts = value;
    //                             //     });
    //                             //   },
    //                             //
    //                             // )
    //                           ],
    //                         ),
    //                         SizedBox(
    //                           height: height*0.010,
    //                         ),
    //                         Text("Lights",
    //                         style: GoogleFonts.poppins(
    //                           fontSize: height*0.020,
    //                         ),
    //                         ),
    //                       ],
    //                     ),
    //                     Column(
    //                       children: [
    //                         ChangeThemeButtonWidget(),
    //                         SizedBox(
    //                           height: height*0.010,
    //                         ),
    //                         Text("$text Mode",
    //                             style: GoogleFonts.poppins(
    //                               fontSize: height*0.010,
    //                               color: Theme.of(context).backgroundColor,)),
    //                       ],
    //                     )
    //                   ],
    //                 ),
    //                 SizedBox(
    //                   height: height*0.015,
    //                 ),
    //                 //TabLeftLightsContainer(),
    //
    //                 // Container(
    //                 //   height: height * 0.20,
    //                 //   width: width * 1.0,
    //                 //   child: ListView(
    //                 //     scrollDirection: Axis.horizontal,
    //                 //     children: _buildButtonsWithNames(),
    //                 //   ),
    //                 // ),
    //
    //                 // SizedBox(
    //                 //   height: height*0.015,
    //                 // ),
    //                 // Text("Fans",style:GoogleFonts.poppins( fontSize: height*0.020,),),
    //                 // SizedBox(
    //                 //   height: height*0.015,
    //                 // ),
    //                 // TabLeftFanContainer(),
    //                 // SizedBox(
    //                 //   height: height*0.020,
    //                 // ),Text("Others Rooms",style: GoogleFonts.poppins( fontSize: height*0.020,
    //                 //   color:Theme.of(context).backgroundColor,),),
    //                 // SizedBox(
    //                 //   height: height*0.021,
    //                 // ),
    //                 // TabLeftOtherScrollView()
    //               ],
    //             ),
    //           )),
    //     ),
    // );

    return Container(
      height: height * 0.965,
      width: width * 0.70,
      child: TabLeftMainTiltleContainer(),
    );
  }
}
