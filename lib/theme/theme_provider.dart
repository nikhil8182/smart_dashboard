import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;


  // bool get isDarkMode {
  //   if (themeMode == ThemeMode.system) {
  //     final brightness = SchedulerBinding.instance.window.platformBrightness;
  //     return brightness == Brightness.dark;
  //   } else {
  //     return themeMode == ThemeMode.dark;
  //   }
  // }

  void toggleTheme(bool isOn) {
    print(" sts about toggle theme $isOn");
    themeMode = isOn ? ThemeMode.light : ThemeMode.dark ;
    notifyListeners();
  }


  List<Data> listData = [
    Data(data: "Room Name"),
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
    //colorScheme: ColorScheme.dark(),
    backgroundColor: Colors.white,
    textTheme:TextTheme(bodyText2: TextStyle(color: Color.fromRGBO(
        189, 186, 186, 1.0))),
    iconTheme: IconThemeData(color: Colors.purple.shade200, opacity: 0.8),
  );

  static final lightTheme = ThemeData(
    backgroundColor: Colors.black,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.grey.shade100,
    // colorScheme: ColorScheme.light(),
    textTheme:TextTheme(bodyText2: TextStyle(color: Color.fromRGBO(
        219, 214, 214, 1.0))),//163, 163, 163, 1.0
    iconTheme: IconThemeData(color: Colors.red, opacity: 0.8),
  );
}


class Data{
  final String data;
  Data({this.data});
}
