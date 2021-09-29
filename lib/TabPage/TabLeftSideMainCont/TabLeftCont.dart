import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smart_dashboard/TabPage/TabLeftSideMainCont/TabLeftFanCont.dart';
import 'package:smart_dashboard/TabPage/TabLeftSideMainCont/TabLeftLightsCont.dart';
import 'package:smart_dashboard/TabPage/TabLeftSideMainCont/TabLeftOthersCont.dart';
import 'package:smart_dashboard/theme/change_theme_button_widget.dart';
import 'package:smart_dashboard/theme/theme_provider.dart';


class TabLeftContainer extends StatefulWidget {


  @override
  _TabLeftContainerState createState() => _TabLeftContainerState();
}

class _TabLeftContainerState extends State<TabLeftContainer> {
bool livingRoomSts = false;
  @override
  Widget build(BuildContext context) {
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
        ? 'Light'
        : 'Dark';
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 19.0),
      child: Container(
        height: height * 0.965,
        width: width * 0.70,
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: Container(
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Living Room ",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: height*0.030,
                                    color: Theme.of(context).backgroundColor,)),
                              Switch(
                                value: livingRoomSts,
                                onChanged: (bool value){
                                  setState(() {
                                    livingRoomSts = value;
                                  });
                                },

                              )
                            ],
                          ),
                          SizedBox(
                            height: height*0.010,
                          ),
                          Text("Lights",
                          style: GoogleFonts.poppins(
                            fontSize: height*0.020,
                          ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          // GestureDetector(
                          //   onTap: (){},
                          //   child: Container(
                          //     height: height*0.06,
                          //     width: width*0.04,
                          //     decoration: BoxDecoration(
                          //       color: Color.fromRGBO(196, 196, 196, 1.0),
                          //       borderRadius: BorderRadius.circular(15.0),
                          //     ),
                          //    child: Center(
                          //      child: SvgPicture.asset("images/icons/sun.svg"),
                          //    ),
                          //
                          //   ),
                          // ),
                          ChangeThemeButtonWidget(),
                          SizedBox(
                            height: height*0.010,
                          ),
                          Text("$text Mode",
                              style: GoogleFonts.poppins(
                                fontSize: height*0.010,
                                color: Theme.of(context).backgroundColor,)),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: height*0.015,
                  ),
                  TabLeftLightsContainer(),
                  SizedBox(
                    height: height*0.015,
                  ),
                  Text("Fans",style:GoogleFonts.poppins( fontSize: height*0.020,),),
                  SizedBox(
                    height: height*0.015,
                  ),
                  TabLeftFanContainer(),
                  SizedBox(
                    height: height*0.020,
                  ),Text("Others Rooms",style: GoogleFonts.poppins( fontSize: height*0.020,
                    color:Theme.of(context).backgroundColor,),),
                  SizedBox(
                    height: height*0.021,
                  ),
                  TabLeftOthersContainer(),
                ],
              ),
            )),
      ),
    );
  }
}
