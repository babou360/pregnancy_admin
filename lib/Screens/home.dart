import 'package:flutter/material.dart';
import 'package:mama_k_app_admin/Screens/baby/baby.dart';
import 'package:mama_k_app_admin/Screens/mother/mother.dart';
import 'package:mama_k_app_admin/Screens/tip/tipspage.dart';
import 'package:mama_k_app_admin/models/babyModel.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text('Home'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => TipsPage())),
            child: Center(
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width/2,
                height: 30,
                color: Colors.black,
                child: Text('Tips',style: TextStyle(color: Colors.white,),
              )
              ),
            ),
          ),
          SizedBox(height: 10,),
          GestureDetector(
            onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => BabyPage())),
            child: Center(
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width/2,
                height: 30,
                color: Colors.black,
                child: Text('Baby',style: TextStyle(color: Colors.white,),
              )
              ),
            ),
          ),
          SizedBox(height: 10,),
          GestureDetector(
            onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => MotherPage())),
            child: Center(
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width/2,
                height: 30,
                color: Colors.black,
                child: Text('Mother',style: TextStyle(color: Colors.white,),
              )
              ),
            ),
          )
        ],
      )
    );
  }
}