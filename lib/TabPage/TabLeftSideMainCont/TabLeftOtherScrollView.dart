import 'package:flutter/material.dart';
import 'package:smart_dashboard/TabPage/TabLeftSideMainCont/TabLeftOthersCont.dart';

class TabLeftOtherScrollView extends StatefulWidget {


  @override
  _TabLeftOtherScrollViewState createState() => _TabLeftOtherScrollViewState();
}

class _TabLeftOtherScrollViewState extends State<TabLeftOtherScrollView> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
        child: Container(
        height: height*0.20,
        width: width*1.0,
          child: TabLeftOthersContainer(),
        )
    );
  }
}
