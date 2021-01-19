import 'package:flutter/material.dart';
import 'package:mama_k_app_admin/Screens/home.dart';
import 'package:mama_k_app_admin/Screens/splash.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mama na Mwana",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      // home: AdminScreen(),
      home: Splash(),
      // initialRoute: '/adminHome',
      // routes: {
      //   '/adminHome': (context) => AdminScreen(),
      //   '/baby': (context) => BabysDev(),
      // },
    );
  }
}
