import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TabRightBottomPowerContainer extends StatefulWidget {

  @override
  _TabRightBottomPowerContainerState createState() => _TabRightBottomPowerContainerState();
}

class _TabRightBottomPowerContainerState extends State<TabRightBottomPowerContainer> {
  bool electricSts = false;
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
              GestureDetector(
                onTap: (){
                  setState(() {
                    if(electricSts == false){
                      electricSts = true;
                    }
                    else{
                      electricSts = false;
                    }
                  });
                },
                child: Container(
                  height: height*0.050,
                  width: width*0.110,
                  decoration: BoxDecoration(
                    color: electricSts ? Color.fromRGBO(194, 194, 194,1.0) : Color.fromRGBO(247, 179, 28,1.0),
                    borderRadius:  BorderRadius.circular(10.0)
                  ),
                  child: Center(
                    child: Text("Electricity"
                    ,style: GoogleFonts.poppins(color:Colors.white,fontSize: height*0.0130,fontWeight: FontWeight.w300),
                    ),
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
                    color: Color.fromRGBO(194, 194, 194,1.0),
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
          Text("26",
            style: GoogleFonts.poppins(fontSize: height*0.025,color: Colors.black,fontWeight: FontWeight.w900),
          ),

        ],
      ),
    );
  }
}
