import 'package:flutter/material.dart';
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
