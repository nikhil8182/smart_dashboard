import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_dashboard/TabPage/TabRightSideMainCont/TabRightBottomContainer.dart';
import 'package:smart_dashboard/TabPage/TabRightSideMainCont/TabRightTimeContainer.dart';

import 'TabRightBottomPowerContainer.dart';

class TabRightContainer extends StatefulWidget {


  @override
  _TabRightContainerState createState() => _TabRightContainerState();
}

class _TabRightContainerState extends State<TabRightContainer> {

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height*0.96,
      width: width*0.24,
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         TabRightTimeContainer(),
         SizedBox(
           height: height*0.010,
         ),
          Text("ROOMS",
            style: GoogleFonts.poppins(color: Color.fromRGBO(46, 56, 48, 1.0),fontSize: height*0.030,fontWeight: FontWeight.bold),
          ),
          // SizedBox(
          //   height: height*0.010,
          // ),
          Text("All",
            style: GoogleFonts.poppins(fontSize: height*0.020,fontWeight: FontWeight.bold),
          ),
         TabRightBottomContainers(),
          SizedBox(
            height: height*0.010,
          ),
          TabRightBottomPowerContainer(),
        ],
      ),
    );
  }
}
