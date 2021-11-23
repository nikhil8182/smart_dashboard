import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TabRightBottomPowerContainer extends StatefulWidget {

  @override
  _TabRightBottomPowerContainerState createState() => _TabRightBottomPowerContainerState();
}

class _TabRightBottomPowerContainerState extends State<TabRightBottomPowerContainer> {
  bool eBill = false;
  var data;
  String ip ;
  int count = 0;
  List deviceStatus=[];
  Timer timer;
  SharedPreferences loginData ;

  //
  // Future<dynamic> getData() async {
  //   http.Response response =
  //   await http.get(Uri.parse('http://$ip/'));
  //   data = json.decode(response.body);
  //   setState(() {
  //     eBill = data['Eb_Status_About'];
  //   });
  // }
  //
  // getDevice() async {
  //   getData();
  //   final res = await http.get(Uri.parse("http://$ip/value",));
  //   deviceStatus = jsonDecode(res.body);
  //   setState(() {
  //     count = 0;
  //     for(int i = 0 ; i < deviceStatus[0].length ; i++){
  //       if((deviceStatus[0][i] == "1")||(deviceStatus[0][i] == 1)){
  //         count++;
  //       }
  //     }
  //   });
  //
  // }
  //
  // @override
  // void initState() {
  //   timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
  //     getDevice();
  //   });
  //   getDevice();
  //   // TODO: implement initState
  //   super.initState();
  // }

  initial() async {
    loginData = await SharedPreferences.getInstance();
    setState(() {
      ip = loginData.getString('ip');
    });
  }

  getDevice() async {
    if((ip != 'false') && (ip != null)){
      final res = await http.get(Uri.parse("http://$ip/value",));
      deviceStatus = jsonDecode(res.body);

      http.Response response = await http.get(Uri.parse('http://$ip/'));
      data = json.decode(response.body);
      setState(() {
        eBill = data['Eb_Status_About'];

        // batteryLevel = data['UPS_Battery_Percentage_About'];
        // waterLevel = data['level'];
        // voltage = data['Onwords_Office_Voltage_Consuption_About'];
        // amps = data['Onwords_Office_Amp_Consuption_About'];
        // unit = data['Onwords_Office_Unit_Consuption_About'];
        // bill = data['Onwords_Office_Current_Bill_About'];

        // print("ebill $eBill ");
        // print("batteryLevel  $batteryLevel");
        // print("$waterLevel water level ");
        // print("vol is $voltage");
        // print("amps is $amps");
        // print("unit is $unit");
        count = 0;
        for(int i = 0 ; i < deviceStatus[0].length ; i++){
          if((deviceStatus[0][i] == "1")||(deviceStatus[0][i] == 1)){
            count++;
          }
        }
        //print("count is $count");
      });
    }else{
      print("the second page has online service still ");
    }

  }

  @override
  void initState() {
    initial();
    Timer.periodic(Duration(seconds: 1), (Timer t) => getDevice());
    super.initState();
    // Future.delayed(Duration.zero, () {
    //   this.showAlertDialog(context);
    // });
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
