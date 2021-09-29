import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TabLeftLightsContainer extends StatefulWidget {

  @override
  _TabLeftLightsContainerState createState() => _TabLeftLightsContainerState();
}

class _TabLeftLightsContainerState extends State<TabLeftLightsContainer> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){},
      child: Container(
        padding: EdgeInsets.all(20.0),
        height: height*0.20,
        width: width*0.12,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height*0.060,
              width: width*0.04,
              decoration: BoxDecoration(
                color: Color.fromRGBO( 247,179, 28, 0.19 ),
                borderRadius: BorderRadius.circular(15.0)
              ),
              child: Center(
                child: SvgPicture.asset("images/icons/light.svg",height: height*0.035,),
              ),
            ),
            SizedBox(
              height: height*0.015,
            ),
            Text("Ceiling Light" , style: GoogleFonts.poppins(color: Theme.of(context).backgroundColor,fontSize: height*0.018),),
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
