import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';


class TabLeftFanContainer extends StatefulWidget {
  @override
  _TabLeftFanContainerState createState() => _TabLeftFanContainerState();
}

class _TabLeftFanContainerState extends State<TabLeftFanContainer> {
  double fan1 = 0.0;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(20.0),
      height: height * 0.22,
      width: width * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Container(
          height: height * 0.050,
          width: width * 0.03,
          decoration: BoxDecoration(
              color: Color.fromRGBO(247, 179, 28, 0.19),
              borderRadius: BorderRadius.circular(10.0)),
          child: Center(
            child: SvgPicture.asset(
              "images/icons/fan.svg",
              height: height * 0.025,
            ),
          ),
        ),
        SizedBox(
          height: height * 0.015,
        ),
        Text(
          "Fan",
          style: GoogleFonts.poppins(
              color: Theme.of(context).backgroundColor,
              fontSize: height * 0.018),
        ),
        SizedBox(
          height: height * 0.001,
        ),
        Expanded(
          child: Slider(
            min: 0.0,
            max: 4.0,
            divisions: 5,
            label: fan1.round().toString(),
            activeColor: Color.fromRGBO(247, 179, 28, 0.6),
            inactiveColor: Colors.grey.shade300,
            value: fan1,
            onChanged: (double value) {
              setState(() {
                fan1 = value;
              });
            },
          ),
        ),
        //     SfSlider(
        //       min: 0.0,
        //       max: 5.0,
        //       value: fan1.round(),
        //       interval: 1.0,
        //       tooltipShape:SfPaddleTooltipShape(),
        //       activeColor:Color.fromRGBO(247, 179, 28, 0.59),
        //       inactiveColor: Colors.white38,
        //       showTicks: true,
        //       showLabels: true,
        //       enableTooltip: true,
        //
        //       // minorTicksPerInterval: 1,
        //       onChanged: (dynamic newValue){
        //         setState(() {
        //           fan1 = newValue;
        //         });
        //       },
        //     ),

      ]),
    );
  }
}
