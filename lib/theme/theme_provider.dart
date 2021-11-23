import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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



  // bool get isDarkMode {
  //   if (themeMode == ThemeMode.system) {
  //     final brightness = SchedulerBinding.instance.window.platformBrightness;
  //     return brightness == Brightness.dark;
  //   } else {
  //     return themeMode == ThemeMode.dark;
  //   }
  // }

  _time() {
    DateTime now = DateTime.now();
    timeFormat = DateFormat('HH').format(now);
    time = int.parse(timeFormat.toString());
  }

  ThemeProvider(int darkValue , int darkTime) {

    _time();
    if(darkValue == 0){
      print("im inside the theme provider of if");
      sharedTime = time;
      print("the time is $sharedTime");
      if((sharedTime >= 18)||(sharedTime <= 7)){
        //aud = ThemeMode.light;
        aud = ThemeMode.dark;
        print("the aud is $aud in if");
      }else{
        //aud = ThemeMode.dark;
        aud = ThemeMode.light;
        print("the aud is $aud in elseeeee is ");
      }
    }
    _themeMode = (darkValue == 0)? aud : sys;
    print("theme mode value is  $_themeMode ");
  }

  ThemeMode getTheme()=> _themeMode;


  void toggleTheme(bool isOn) {
    print(" sts about toggle theme $isOn");
    _themeMode = isOn ? ThemeMode.light : ThemeMode.dark ;
    notifyListeners();
  }


  List<Data> listData = [
    Data(data: "Select Room "),
  ];

  void add(String newValue){
    final task  = Data(data: newValue);
    listData.add(task);
    notifyListeners();
  }

  void remove(Data data){
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
        bodyText2: TextStyle(color: Color.fromRGBO(
        189, 186, 186, 1.0)),

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
        bodyText2: TextStyle(color: Color.fromRGBO(
        219, 214, 214, 1.0))),//163, 163, 163, 1.0
    iconTheme: IconThemeData(color: Colors.red, opacity: 0.8),
  );
}


class Data{
  final String data;
  Data({this.data});
}
