import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/weather.dart';
import 'package:location/location.dart';


class TabRightTimeContainer extends StatefulWidget {


  @override
  _TabRightTimeContainerState createState() => _TabRightTimeContainerState();
}

class _TabRightTimeContainerState extends State<TabRightTimeContainer> {
  Timer timer;
  Timer timer1;
  DateTime now ;
  String month ;
  String formattedDate ;
  String timeFormat ;
  String amPm;//class to get the lat&log
  SharedPreferences loginData;

  String key = '61da84456d2e1223634e30121bdff1c3';
  WeatherFactory ws;
  double lat, lon;
  String des = " ";
  double temp ;
  LocationData _currentPosition;
  String ic = " ";


  Location location = Location();

  double sharedTemp = 0.0 ;
  String sharedDes = " ";
  double sharedLat = 0.0;
  double sharedLon = 0.0 ;


  void initial() async {
    loginData = await SharedPreferences.getInstance();
    setState(() {
      sharedTemp = loginData.getDouble('temp');
      sharedDes = loginData.getString('des');
      sharedLon = loginData.getDouble('lon');
      sharedLat = loginData.getDouble('lat');
     // print("$weather  =============");
    });

  }


  void _getTime() {
    setState(() {
      DateTime now = DateTime.now();
       month = DateFormat('MMM').format(now);
      formattedDate = DateFormat('d ').format(now);
      timeFormat = DateFormat('h:mm').format(now);
      amPm = DateFormat('a').format(now);
    });
  }


  @override
  void initState() {
    getLoc();
    ws = new WeatherFactory(key);
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    Timer.periodic(Duration(minutes: 10), (Timer t) => getLoc());
        super.initState();
  }

  // @override
  // void dispose() {
  //   timer?.cancel();
  //   timer1?.cancel();
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 10.0),
      height: height * 0.22,
      width: width * 0.23,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(34, 0, 255, 1.0),
              Color.fromRGBO(184, 91, 174, 1.0),
              Color.fromRGBO(255, 128, 128, 0.9),
            ],
            stops: [0.3,0.9,010],
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(month??" ",
                  style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold,fontSize: height*0.020)),
              SizedBox(
                width: width*0.020,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 2.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.transparent,
                    border: Border.all(color: Colors.white)
                ),
                child: Text(formattedDate??" ",
                    style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w300, fontSize: height*0.020)
                ),
              )
            ],
          ),
          // SizedBox(
          //   height: height*0.010,
          // ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(timeFormat??" ",
                  style: GoogleFonts.poppins(
                      color: Colors.white,fontWeight: FontWeight.w100, fontSize: height*0.050)),
              SizedBox(
                width: width*0.010,
              ),
              Text(amPm??" ",
                  style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w100, fontSize: height*0.010)),

              SizedBox(
                width: width*0.035,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset("images/icons/weather.svg",height: height*0.040,),
                  //Image.network('http://openweathermap.org/img/w/$ic.png',height: height*0.040 ,scale: 1.0,),
                  SizedBox(
                    height: height*0.010,
                  ),

                  (sharedTemp == null)?CircularProgressIndicator(
                    backgroundColor: Colors.grey[700],
                    valueColor:
                    new AlwaysStoppedAnimation<Color>(
                        Colors.white),
                  ): Text("${sharedTemp.toString()}"" °C",
                      style: GoogleFonts.poppins(
                          color: Colors.white,fontWeight: FontWeight.w400,fontSize: height*0.020)),
                ],
              )
            ],
          ),
          // SizedBox(
          //   height: height*0.010,
          // ),
          Row(
            children: [
              Text(sharedDes,
                  style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w400,fontSize: height*0.020)),
            ],
          )
        ],
      ),
    );
  }
  void queryWeather() async {

    //print("hello query weather");
    FocusScope.of(context).requestFocus(FocusNode());

    loginData = await SharedPreferences.getInstance();
    loginData.setDouble('lat', lat);
    loginData.setDouble('lon', lon);
    //print("$lat na $lon");
    Weather weather = await ws.currentWeatherByLocation(sharedLat, sharedLon);
    //print("${weather.tempMax} , ${weather.temperature},  ${weather.weatherDescription},  ${weather.cloudiness}");
    setState(() {
      //_data = [weather];
      temp = weather.temperature.celsius.roundToDouble();

      //print("${weather.tempMax.runtimeType} temp is================");
      des = weather.weatherDescription;
      ic = weather.weatherIcon;
      //print("${ weather.weatherIcon} icon 000000000s");
      //print("$des des is================");
    });

    loginData = await SharedPreferences.getInstance();
    loginData.setDouble('temp', temp);
    loginData.setString('des', des);
    initial();
  }

  getLoc() async{
    //print("22222222222im inside the get loc hello999999999999999999");
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    location.onLocationChanged.listen((LocationData currentLocation) {
      //print("${currentLocation.longitude} : ${currentLocation.longitude}");
      setState(() {
        _currentPosition = currentLocation;
        lat = (_currentPosition.latitude);
        lon = (_currentPosition.longitude);
        //print("$lat and $lon  im inside the getloc");
        queryWeather();
      });
    });
  }
}
