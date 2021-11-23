import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:smart_dashboard/theme/theme_provider.dart';


class ChangeThemeButtonWidget extends StatefulWidget {
  @override
  _ChangeThemeButtonWidgetState createState() => _ChangeThemeButtonWidgetState();
}

class _ChangeThemeButtonWidgetState extends State<ChangeThemeButtonWidget> {
  bool themeSts = false ;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: (){
           setState(() {

             if(themeSts == false){
              print("im inside the if cond");
               themeSts = true;
               print("themests $themeSts");
             }
             else{
               print("im inside the else cond");
               themeSts = false;
               print("themests $themeSts");
             }
             final provider = Provider.of<ThemeProvider>(context, listen: false);
             provider.toggleTheme(themeSts);
           });
      },
      child: Container(
        height: height*0.06,
        width: width*0.04,
        decoration: BoxDecoration(
          color: Color.fromRGBO(196, 196, 196, 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          //toggle has to work by mobile****************

          child: Provider.of<ThemeProvider>(context).getTheme() == ThemeMode.dark ?
          SvgPicture.asset("images/icons/moon.svg",height: height*0.035,):
          SvgPicture.asset("images/icons/sun.svg",height: height*0.030,),
        ),
      ),
    );
  }
}
