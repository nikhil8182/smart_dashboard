import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {

  Timer timer;
  DateTime now ;
  var timeFormat ;
  int time = 0;
  int sharedTime = 0;

  ThemeMode _themeMode;
  SharedPreferences loginData;

  ThemeMode dar = ThemeMode.dark;
  ThemeMode lig = ThemeMode.light;
  ThemeMode sys = ThemeMode.system;
  ThemeMode aud ;

  _time() {
    DateTime now = DateTime.now();
    timeFormat = DateFormat('HH').format(now);
    time = int.parse(timeFormat.toString());
  }

  ThemeProvider(int darkValue , int darkTime) {

    _time();
    if(darkValue == 3){

      sharedTime = time;

      if((sharedTime >= 18)||(sharedTime <= 7)){
        //aud = ThemeMode.light;
        aud = ThemeMode.dark;

      }else{
        //aud = ThemeMode.dark;
        aud = ThemeMode.light;

      }
    }
    _themeMode = (darkValue == 0)? sys : (darkValue == 1) ? lig :(darkValue == 2) ? dar : aud;

  }

  ThemeMode getTheme()=> _themeMode;


  void toggleTheme(bool isOn) {

    _themeMode = isOn ? ThemeMode.light : ThemeMode.dark ;
    notifyListeners();
  }

  // logout(){
  //   _themeMode = aud;
  //   //print("log out theme mode is $_themeMode ");
  //   notifyListeners();
  // }


  List<Data> listData = [
    Data(data: "Select Room "),
  ];

  add(String newValue){
    final task  = Data(data: newValue);
    listData.add(task);
    notifyListeners();
  }

  remove(Data data){
    listData.remove(data);
    notifyListeners();
  }

}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Color.fromRGBO(30, 30, 30, 0.50),
    primaryColor: Color.fromRGBO(90, 90, 90, 0.40),
    backgroundColor: Colors.white,
    canvasColor: Colors.white,
    cardColor: Colors.white,
    textTheme:TextTheme(
      headline2: TextStyle(color: Colors.grey,fontWeight: FontWeight.w800,),
      subtitle2: GoogleFonts.inter(color: Colors.black,fontWeight: FontWeight.w800,fontSize:11.0),
      headline5: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,),
      subtitle1: GoogleFonts.inter(color: Colors.white,fontWeight: FontWeight.w800,fontSize:11.0),
      headline4: GoogleFonts.inter(color: Colors.white,fontWeight: FontWeight.w900),
      headline6: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
      button: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold),
      bodyText1: GoogleFonts.inter(color: Colors.white,fontWeight: FontWeight.w100,fontSize:11.0),
      bodyText2: TextStyle(color: Color.fromRGBO(189, 186, 186, 1.0)),

    ),
    iconTheme: IconThemeData(color: Colors.purple.shade200, opacity: 0.8),
  );

  static final lightTheme = ThemeData(
    backgroundColor: Colors.black,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.grey.shade100,
    cardColor: Colors.white,
    canvasColor: Colors.white,
    // colorScheme: ColorScheme.light(),
    textTheme:TextTheme(
        headline2: TextStyle(color: Colors.grey,fontWeight: FontWeight.w800,),
        headline5: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,),
        subtitle1: GoogleFonts.inter(color: Colors.black,fontWeight: FontWeight.w800,fontSize:11.0),
        button: GoogleFonts.inter( color: Color.fromRGBO(62, 62, 62, 0.5), fontWeight: FontWeight.bold),
        headline6: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
        headline4: GoogleFonts.inter(color: Colors.black,fontWeight: FontWeight.w900),
        subtitle2: GoogleFonts.inter(color: Colors.black,fontWeight: FontWeight.w500,fontSize:11.0),
        bodyText2: TextStyle(color: Color.fromRGBO(219, 214, 214, 1.0))),//163, 163, 163, 1.0
    iconTheme: IconThemeData(color: Colors.red, opacity: 0.8),
  );
}


class Data{
  final String data;
  Data({this.data});
}
