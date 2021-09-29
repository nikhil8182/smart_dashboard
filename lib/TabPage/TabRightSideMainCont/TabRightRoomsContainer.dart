import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TabRightRoomsContainer extends StatefulWidget {

  @override
  _TabRightRoomsContainerState createState() => _TabRightRoomsContainerState();
}

class _TabRightRoomsContainerState extends State<TabRightRoomsContainer> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height*0.090,
        width: width*0.235,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(25),bottomRight:Radius.circular(25.0),topLeft:Radius.circular(5.0),bottomLeft: Radius.circular(5.0),  ),
          color: Color.fromRGBO(241, 241, 241, 1.0),
        ),
        child: ListTile(
          title: Text("Living Room",
            style: GoogleFonts.poppins(color:Colors.black,fontWeight: FontWeight.w600,fontSize: height*0.020),),
          subtitle: Text("6 Devices"
              ,style: GoogleFonts.poppins(color:Colors.black,fontSize: height*0.012)
          ),
        )
    );
  }
}
