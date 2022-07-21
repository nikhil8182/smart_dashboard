import 'package:flutter/material.dart';
import 'package:smart_dashboard/TabPage/TabLeftSideMainCont/TabLeftMainTitleAndLightAndFan.dart';


class TabLeftContainer extends StatefulWidget {

  @override
  _TabLeftContainerState createState() => _TabLeftContainerState();
}

class _TabLeftContainerState extends State<TabLeftContainer>with WidgetsBindingObserver {

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // return Padding(
    //     padding: EdgeInsets.symmetric(horizontal: 19.0),
    //     child: Container(
    //       height: height * 0.965,
    //       width: width * 0.70,
    //       padding: EdgeInsets.all(20.0),
    //       decoration: BoxDecoration(
    //         color: Theme.of(context).primaryColor,
    //         borderRadius: BorderRadius.circular(40.0),
    //       ),
    //       //child: TabLeftMainContainerTitle(roomName: widget.roomName,ip: widget.ip,index: widget.index,),
    //       child: Container(
    //           child: Padding(
    //             padding: EdgeInsets.all(5.0),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               children: [
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Row(
    //                           children: [//widget.roomName.toString().replaceAll("_", " "),
    //                             Text(widget.roomName.toString().replaceAll("_", " "),
    //                                 style: GoogleFonts.poppins(
    //                                   fontWeight: FontWeight.bold,
    //                                   fontSize: height*0.030,
    //                                   color: Theme.of(context).backgroundColor,)),
    //                             // Switch(
    //                             //   value: livingRoomSts,
    //                             //   onChanged: (bool value){
    //                             //     setState(() {
    //                             //       livingRoomSts = value;
    //                             //     });
    //                             //   },
    //                             //
    //                             // )
    //                           ],
    //                         ),
    //                         SizedBox(
    //                           height: height*0.010,
    //                         ),
    //                         Text("Lights",
    //                         style: GoogleFonts.poppins(
    //                           fontSize: height*0.020,
    //                         ),
    //                         ),
    //                       ],
    //                     ),
    //                     Column(
    //                       children: [
    //                         ChangeThemeButtonWidget(),
    //                         SizedBox(
    //                           height: height*0.010,
    //                         ),
    //                         Text("$text Mode",
    //                             style: GoogleFonts.poppins(
    //                               fontSize: height*0.010,
    //                               color: Theme.of(context).backgroundColor,)),
    //                       ],
    //                     )
    //                   ],
    //                 ),
    //                 SizedBox(
    //                   height: height*0.015,
    //                 ),
    //                 //TabLeftLightsContainer(),
    //
    //                 // Container(
    //                 //   height: height * 0.20,
    //                 //   width: width * 1.0,
    //                 //   child: ListView(
    //                 //     scrollDirection: Axis.horizontal,
    //                 //     children: _buildButtonsWithNames(),
    //                 //   ),
    //                 // ),
    //
    //                 // SizedBox(
    //                 //   height: height*0.015,
    //                 // ),
    //                 // Text("Fans",style:GoogleFonts.poppins( fontSize: height*0.020,),),
    //                 // SizedBox(
    //                 //   height: height*0.015,
    //                 // ),
    //                 // TabLeftFanContainer(),
    //                 // SizedBox(
    //                 //   height: height*0.020,
    //                 // ),Text("Others Rooms",style: GoogleFonts.poppins( fontSize: height*0.020,
    //                 //   color:Theme.of(context).backgroundColor,),),
    //                 // SizedBox(
    //                 //   height: height*0.021,
    //                 // ),
    //                 // TabLeftOtherScrollView()
    //               ],
    //             ),
    //           )),
    //     ),
    // );

    return Container(
      height: height * 0.965,
      width: width * 0.70,
      child: TabLeftMainTitleContainer(),
    );
  }
}
