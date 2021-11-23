import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:smart_dashboard/loginPage.dart';
import 'package:smart_dashboard/theme/theme_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

//minor changes are made on 23-nov-2021 5:30 pm

FirebaseAuth auth = FirebaseAuth.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();


  // await SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    builder: (context, _) {
      final themeProvider = Provider.of<ThemeProvider>(context);

      return OverlaySupport.global(
        child:MaterialApp(
        themeMode: themeProvider.themeMode,
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheme,
        home: LoginPage(),
        debugShowCheckedModeBanner: false,
      ),
      );
    },
  );
}
