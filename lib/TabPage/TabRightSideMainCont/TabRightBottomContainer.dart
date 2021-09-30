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
    return SingleChildScrollView(
      child: Container(
        height: height*0.390,
        width: width*1.0,
        child: TabRightRoomsContainer(),
      ),
    );
  }
}
