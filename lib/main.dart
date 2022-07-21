import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_dashboard/loginPage.dart';
import 'package:smart_dashboard/splashScreen.dart';
import 'package:smart_dashboard/theme/theme_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

//major work on  theme,buttons, network error, shared preferences etc ... completed on 24-nov-2021

FirebaseAuth auth = FirebaseAuth.instance;

void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  // await SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);

  SharedPreferences.getInstance().then((loginData) {
    var isDarkTheme = loginData.getInt("darValue") ?? 3 ;
    var darkTime = loginData.getInt('time') ?? 0;

    runApp(MyApp(isDarkTheme,darkTime));
  });
}

class MyApp extends StatelessWidget {
  final int darkNum;
  final int darkTim;
  MyApp(this.darkNum,this.darkTim);

  @override
  Widget build(BuildContext context){
    return ChangeNotifierProvider(
        create: (context) => ThemeProvider(darkNum,darkTim),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return OverlaySupport.global(
            child: MaterialApp(
              themeMode: themeProvider.getTheme(),
              theme: MyThemes.lightTheme,
              darkTheme: MyThemes.darkTheme,
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                // body: InstallationPage(),
                body: LoginPage(),
                // body: SplashScreenPage(),
              ),
            ),
          );
        }
    );
  }
  //     ChangeNotifierProvider(
  //   create: (context) => ThemeProvider(darkNum,darkTim),
  //   builder: (context, _) {
  //     final themeProvider = Provider.of<ThemeProvider>(context);
  //
  //     return OverlaySupport.global(
  //       child:MaterialApp(
  //       themeMode: themeProvider.getTheme(),
  //       theme: MyThemes.lightTheme,
  //       darkTheme: MyThemes.darkTheme,
  //       home: LoginPage(),
  //       debugShowCheckedModeBanner: false,
  //     ),
  //     );
  //   },
  // );
}
