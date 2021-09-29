import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TabLeftOthersContainer extends StatefulWidget {

  @override
  _TabLeftOthersContainerState createState() => _TabLeftOthersContainerState();
}

class _TabLeftOthersContainerState extends State<TabLeftOthersContainer> {

  bool kitchenSts = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){},
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 20.0),
          height: height*0.20,
          width: width*0.15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: height*0.060,
                    width: width*0.04,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO( 247,179, 28, 0.19 ),
                        borderRadius: BorderRadius.circular(15.0)
                    ),
                    child: Center(
                      child: SvgPicture.asset("images/icons/kitchen.svg",height: height*0.035,),
                    ),
                  ),
                  SizedBox(
                    width: width*0.040,
                  ),
                  Switch(
                      value: kitchenSts, onChanged: (bool value){
                    setState(() {
                      kitchenSts = value;
                    });
                  })
                ],
              ),
              SizedBox(
                height: height*0.015,
              ),
              Text("Kitchen" ,
                style: GoogleFonts.poppins(color: Theme.of(context).backgroundColor,fontSize: height*0.018),),
              SizedBox(
                height: height*0.006,
              ),
              Text("off",style: GoogleFonts.poppins(fontSize: height*0.015),),
            ],
          )
      ),
    );
  }
}
