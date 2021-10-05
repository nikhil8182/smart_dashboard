import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TabRightTimeContainer extends StatefulWidget {


  @override
  _TabRightTimeContainerState createState() => _TabRightTimeContainerState();
}

class _TabRightTimeContainerState extends State<TabRightTimeContainer> {

  TimeOfDay _selectedTime;

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay timePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),

    );
    if (timePicked != null)
      setState(() {
        _selectedTime = timePicked.replacing(hour: timePicked.hourOfPeriod);
      });

    print(_selectedTime.toString());
  }

  time(){
    TimeOfDay noonTime = TimeOfDay(hour: 15, minute: 0); // 3:00 PM
    TimeOfDay morningTime = TimeOfDay(hour: 5, minute: 0); // 5:00 AM

    print(noonTime.period); // gives DayPeriod.pm
    print(morningTime.period); // gives DayPeriod.am

    //example 1
    if (noonTime.period == DayPeriod.am)
      print("$noonTime is AM");
    else
      print("$noonTime is PM");

    //example 2
    if (morningTime.period == DayPeriod.am)
      print("$morningTime is AM");
    else
      print("$morningTime is PM");
  }
@override
  void initState() {

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    DateTime now = DateTime.now();
    String month = DateFormat('MMM').format(now);
    String formattedDate = DateFormat('d ').format(now);
    String timeFormat = DateFormat('kk:mm').format(now);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 12.0),
      height: height * 0.22,
      width: width * 0.23,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(34, 0, 255, 1.0),
              Color.fromRGBO(184, 91, 174, 1.0),
              Color.fromRGBO(255, 128, 128, 0.9),
            ],
            stops: [0.3,0.9,010],
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(month,
                  style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold,fontSize: height*0.020)),
              SizedBox(
                width: width*0.020,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 2.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.transparent,
                    border: Border.all(color: Colors.white)
                ),
                child: Text(formattedDate,
                    style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w300, fontSize: height*0.020)
                ),
              )
            ],
          ),
          // SizedBox(
          //   height: height*0.010,
          // ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(timeFormat,
                  style: GoogleFonts.poppins(
                      color: Colors.white,fontWeight: FontWeight.w100, fontSize: height*0.050)),
              SizedBox(
                width: width*0.010,
              ),
              Text("AM",
                  style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w100, fontSize: height*0.010)),

              SizedBox(
                width: width*0.035,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset("images/icons/weather.svg",height: height*0.040,),
                  SizedBox(
                    height: height*0.010,
                  ),
                  Text("31°C",
                      style: GoogleFonts.poppins(
                          color: Colors.white,fontWeight: FontWeight.w400,fontSize: height*0.020))
                ],
              )
            ],
          ),
          // SizedBox(
          //   height: height*0.010,
          // ),
          Row(
            children: [
              Text("Partially Cloudy",
                  style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w400,fontSize: height*0.020)),
            ],
          )
        ],
      ),
    );
  }
}
