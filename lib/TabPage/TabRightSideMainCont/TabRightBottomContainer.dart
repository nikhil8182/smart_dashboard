import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_dashboard/TabPage/TabRightSideMainCont/TabRightRoomsContainer.dart';
class TabRightBottomContainers extends StatefulWidget {

  @override
  _TabRightBottomContainersState createState() => _TabRightBottomContainersState();
}

class _TabRightBottomContainersState extends State<TabRightBottomContainers> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height*0.510,
      width: width*1.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("ROOMS",
          style: GoogleFonts.poppins(color: Color.fromRGBO(46, 56, 48, 1.0),fontSize: height*0.030,fontWeight: FontWeight.bold),
          ),
          // SizedBox(
          //   height: height*0.010,
          // ),
          Text("All",
          style: GoogleFonts.poppins(fontSize: height*0.020,fontWeight: FontWeight.bold),
          ),
          // Expanded(
          //     child:
          // ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5.0),
         child: Column(
           children: [
             TabRightRoomsContainer(),
             SizedBox(
               height: height*0.010,
             ),
             TabRightRoomsContainer(),
             SizedBox(
               height: height*0.010,
             ),
             TabRightRoomsContainer(),
             SizedBox(
               height: height*0.010,
             ),
             TabRightRoomsContainer(),
           ],
         ),
        ),
        ],
      ),
    );
  }
}
