import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_dashboard/TabPage/TabLeftSideMainCont/TabLeftCont.dart';
import 'package:smart_dashboard/TabPage/TabRightSideMainCont/TabRightContainer.dart';

import '../loginPage.dart';



FirebaseAuth auth = FirebaseAuth.instance;
final databaseReference = FirebaseDatabase.instance.reference();

class TabPage extends StatefulWidget {

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {

  SharedPreferences loginData;


  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      //backgroundColor: Colors.black,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        height: height*1.0,
        width: width*1.0,
        color:  Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                  height: height*0.25,
                  child: GestureDetector(
                      onDoubleTap: () async {
                        loginData = await SharedPreferences.getInstance();
                        loginData.setBool('login', true);
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => LoginPage()));
                      },
                      child: SvgPicture.asset("images/icons/onwords.svg"))),
             TabLeftContainer(),
              TabRightContainer()
            ],
          ),
        ),
      ),
    );
  }
}
