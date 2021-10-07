import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class TabRightBottomPowerContainer extends StatefulWidget {

  @override
  _TabRightBottomPowerContainerState createState() => _TabRightBottomPowerContainerState();
}

class _TabRightBottomPowerContainerState extends State<TabRightBottomPowerContainer> {
  bool eBill = false;
  var data;
  String ip = "192.168.1.18:8000";
  int count = 0;
  List deviceStatus=[];
  Timer timer;

  Future<dynamic> getData() async {
    http.Response response =
    await http.get(Uri.parse('http://$ip/'));
    data = json.decode(response.body);
    setState(() {
      eBill = data['Eb_Status_About'];
    });
  }

  getDevice() async {
    getData();
    final res = await http.get(Uri.parse("http://$ip/value",));
    deviceStatus = jsonDecode(res.body);
    setState(() {
      count = 0;
      //print("${deviceStatus[0].length} ============");
      for(int i = 0 ; i < deviceStatus[0].length ; i++){
        // print("${deviceStatus[0][i]}");
        if((deviceStatus[0][i] == "1")||(deviceStatus[0][i] == 1)){
          count++;
        }
      }
    });

  }

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      getDevice();
    });
    getDevice();
    // TODO: implement initState
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
