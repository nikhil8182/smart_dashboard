import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../TabLeftSideMainCont/TabLeftMainTitleAndLightAndFan.dart';

class TabRightBottomPowerContainer extends StatefulWidget {

  @override
  _TabRightBottomPowerContainerState createState() => _TabRightBottomPowerContainerState();
}

class _TabRightBottomPowerContainerState extends State<TabRightBottomPowerContainer> {
  bool eBill = false;
  var data;
  String ip ;
  int count = 0;
  List deviceStatus=[] ;
  List onlineDeviceStatus = [];
  Timer timer;
  SharedPreferences loginData ;
  String authKey = " ";
  var dataJson;
  bool bothOffOn ;
  bool noLocalServer;
  var localServer;
  var smartHome;

  // initial() async {
  //   loginData = await SharedPreferences.getInstance();
  //   setState(() {
  //     ip = loginData.getString('ip');
  //     getDevice();
  //   });
  // }
  //
  // getDevice() async {
  //   if((ip != 'false') && (ip != null)){
  //     // http.Response res = await http.get(Uri.parse('http://$ip/sensor/'));
  //     // deviceStatus = jsonDecode(res.body);
  //     final response = await http.get(Uri.parse("http://$ip/",));
  //     var dumStatus = jsonDecode(response.body);
  //     final fanRes = await http.get(Uri.parse("http://$ip/fan",));
  //     var fanStatus = jsonDecode(fanRes.body);
  //
  //     http.Response res = await http.get(Uri.parse('http://$ip/sensor/'));
  //     data = json.decode(res.body);
  //     setState(() {
  //       eBill = data['Eb_Status'];
  //          print("")
  //       deviceStatus.clear();
  //       for (int i = 0; i < dumStatus.length; i++) {
  //         deviceStatus.add(dumStatus[i]["Device_Status"].toString());
  //       }
  //       for (int i = 0; i < fanStatus.length; i++) {
  //         deviceStatus.add(fanStatus[i]["Fan_Speed"].toString());
  //       }
  //       count = 0;
  //       for(int i = 0 ; i < deviceStatus.length ; i++){
  //         if((deviceStatus[i] == "true")||(deviceStatus[i] == "1")||(deviceStatus[i] == "2")||(deviceStatus[i] == "3")||(deviceStatus[i] == "4")||(deviceStatus[i] == "5"))
  //         {
  //           count++;
  //         }
  //       }
  //       //print("count is $count");
  //     });
  //   }else{
  //     ///have add dashboard content
  //     print("the second page has online service still ");
  //   }
  //
  // }
  //
  // @override
  // void initState() {
  //   initial();
  //   Timer.periodic(Duration(seconds: 1), (Timer t) => getDevice());
  //   super.initState();
  //
  // }
  keyValues() async {
    loginData = await SharedPreferences.getInstance();
    final locIp = loginData.getString('ip') ?? null;
    final onIp = loginData.getString('onlineIp') ?? null;

    if((locIp != null)&&(locIp != "false")){
      try{
        final response = await http.get(Uri.parse("http://$locIp/")).timeout(
            const Duration(milliseconds: 500),onTimeout: (){
          //ignore:avoid_print
          //print(" inside the timeout  in second screeen");
          ip = onIp;
          getDevice();
          return;
        });
        if(response.statusCode > 0) {
          ip = locIp;
          getDevice();
        }
      }catch(e){
        // print(e);
      }
    }else if(locIp == "false")
    {
      ip = locIp;
      getDevice();
    }
  }

  firstProcess() async {
    loginData = await SharedPreferences.getInstance();
    setState(() {
      authKey = loginData.getString('ownerId');
      fireData();
    });
  }

  Future<void> fireData() async {
    //print("im at before atlast of firedata");

    databaseReference.child(authKey).once().then((snapshot) async {

      dataJson = snapshot.snapshot.value;

      setState(() {
        noLocalServer = dataJson['noLocalServer'];
        localServer = dataJson['localServer'];
        // bothOffOn = localServer["BothOfflineAndOnline"];
        bothOffOn = localServer != null ? localServer["BothOfflineAndOnline"]: false;
        if(noLocalServer != true){
          if(bothOffOn == true){

            keyValues();
            //firebase ****************
          }else{

            keyValues();
            //print("im inside the else of both on and off ");
          }
        }else{
          ip = "false";
          smartHome = dataJson['SmartHome'];
          getDevice();
        }
      });

    });
  }



  getDevice() async {
    //print("im inside the in second screeen  is $ip");
    if((ip != 'false') && (ip != null))
    {
      final res = await http.get(Uri.parse("http://$ip/",));
      var dumStatus = jsonDecode(res.body);
      final fanRes = await http.get(Uri.parse("http://$ip/fan",));
      var fanStatus = jsonDecode(fanRes.body);

      http.Response response = await http.get(Uri.parse('http://$ip/sensor/'));
      data = json.decode(response.body);

      setState(() {
        eBill = data[0]['EB_Status'];
        // batteryLevel = data[0]['UPS'];
        // waterLevel = data[0]['Water_Level'];
        // voltage = data[0]['Voltage'];
        // amps = data[0]['Ampere'];
        // door = data[0]["Door"];
        // unit = data[0]["Units"];
        // today_bill = data[0]["Todays_Bill"];
        // total_bill = data[0]["Total_Bill"];
        // smartDoor = data[0]['Door_Motor'];
        //
        // if((batteryLevel<= 40)&&(countValue == 0)){
        //   countValue = 1;
        //   NotificationApi.showNotification(
        //     title: 'Battery percentage',
        //     body: 'your UPS Battery Percentage is less than 20 %',
        //     payload: 'Battery.low',
        //   );
        // }else if((batteryLevel>= 80)&&(countValue == 1)){
        //   countValue = 0;
        //   NotificationApi.showNotification(
        //     title: 'Battery percentage',
        //     body: 'your UPS Battery Percentage is good -80 %',
        //     payload: 'Battery.high',
        //   );
        // }else{
        //   print("nothing");
        // }
        deviceStatus.clear();
        for (int i = 0; i < dumStatus.length; i++) {
          deviceStatus.add(dumStatus[i]["Device_Status"].toString());
        }
        for (int i = 0; i < fanStatus.length; i++) {
          deviceStatus.add(fanStatus[i]["Fan_Speed"].toString());
        }
        count = 0;
        for(int i = 0 ; i < deviceStatus.length ; i++){
          if((deviceStatus[i] == "true")||(deviceStatus[i] == "1")||(deviceStatus[i] == "2")||(deviceStatus[i] == "3")||(deviceStatus[i] == "4")||(deviceStatus[i] == "5"))
          {
            count++;
          }
        }
        //print("count is $count");
      });
    }else if(ip == "false"){

      var val = smartHome['Devices'];
      var fanVal = smartHome['Fan'];
      var sensorValues = smartHome['Sensor'];

      setState(() {
        //acount =1;
        eBill = sensorValues['EB_Status'];
        // batteryLevel = sensorValues['UPS'];
        // waterLevel = sensorValues['Water_Level'];
        // voltage = sensorValues['Voltage'];
        // amps = sensorValues['Ampere'];
        // door = sensorValues['Door'];
        // smartDoor = sensorValues['door_motor'];
        count = 0;


        onlineDeviceStatus.clear();

        for (int i = 1; i <= val.length; i++) {
          onlineDeviceStatus.add(val['Id$i']["Device_Status"].toString());
        }
        for (int i = 1; i <= fanVal.length; i++) {
          onlineDeviceStatus.add(fanVal['Id$i']["Fan_Speed"].toString());
        }

        for(int i = 0 ; i < onlineDeviceStatus.length ; i++)
        {
          if((onlineDeviceStatus[i] == "true")||(onlineDeviceStatus[i] == "1")||(onlineDeviceStatus[i] == "2")||(onlineDeviceStatus[i] == "3")||(onlineDeviceStatus[i] == "4")||(onlineDeviceStatus[i] == "5"))
          {
            count++;
          }
        }
      });
      //showAnotherAlertDialog(context);
    }else{
      //print("the second page has online service still ");
    }

  }



  int acount= 0;

  @override
  void initState() {
    //initial();
    // keyValues();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t)
    {
      firstProcess();
      //keyValues();
      getDevice();

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height*0.200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Power Source",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500, color: Color.fromRGBO(0, 0, 0, 1.0),fontSize: height*0.018,),
          ),
          SizedBox(
            height: height*0.010,
          ),
          Row(
            children: [
              Container(
                height: height*0.050,
                width: width*0.110,
                decoration: BoxDecoration(
                    color: eBill ? Color.fromRGBO(247, 179, 28,1.0) : Color.fromRGBO(194, 194, 194,1.0),
                  borderRadius:  BorderRadius.circular(10.0)
                ),
                child: Center(
                  child: Text("Electricity"
                  ,style: GoogleFonts.poppins(color:Colors.white,fontSize: height*0.0130,fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              SizedBox(
                width : width * 0.010,
              ),
              Container(
                height: height*0.050,
                width: width*0.110,
                decoration: BoxDecoration(
                    color: eBill ? Color.fromRGBO(194, 194, 194,1.0) : Color.fromRGBO(247, 179, 28,1.0),
                    borderRadius:  BorderRadius.circular(10.0)
                ),
                child: Center(
                  child: Text("Inverter"
                    ,style: GoogleFonts.poppins(color:Colors.white,fontSize: height*0.0130,fontWeight: FontWeight.w300),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: height*0.015,
          ),
          Text("Total running devices",
          style: GoogleFonts.poppins(fontSize: height*0.018,color: Colors.black,fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: height*0.005,
          ),
          Text(count.toString(),
            style: GoogleFonts.poppins(fontSize: height*0.025,color: Colors.black,fontWeight: FontWeight.w900),
          ),

        ],
      ),
    );
  }
}
