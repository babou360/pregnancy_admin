import 'package:flutter/material.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomAdminButton.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomText.dart';
import 'package:mama_k_app_admin/Screens/babysDev/babysDev.dart';
import 'package:mama_k_app_admin/Screens/mothersDev/mothersDev.dart';
import 'package:mama_k_app_admin/Screens/tips/tips.dart';
import 'package:mama_k_app_admin/app/sizeConfig.dart';
import 'package:mama_k_app_admin/services/databaseService.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  DatabaseService db = DatabaseService();

  @override
  void initState() {
    db.configureDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double blockHeight = SizeConfig.safeBlockVertical;
    double blockWidth = SizeConfig.safeBlockHorizontal;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: blockWidth * 7.5,
              vertical: blockHeight * 10,
            ),
            width: double.infinity,
            child: Column(
              children: <Widget>[
                CustomText(
                  text: "Mama K App",
                  color: Colors.green[700],
                  size: blockWidth * 12,
                  weight: FontWeight.w600,
                ),
                SizedBox(height: blockHeight),
                CustomText(
                  text: "Admin Dashboard",
                  color: Colors.green[400],
                  size: blockWidth * 8,
                  weight: FontWeight.w300,
                ),
                SizedBox(height: blockHeight * 6),
                CustomAdminButton(
                  title: "Baby's development",
                  callback: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BabysDev()),
                    );
                  },
                ),
                CustomAdminButton(
                  title: "Mothers's development",
                  callback: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MothersDev()),
                    );
                  },
                ),
                CustomAdminButton(
                  title: "Tips",
                  callback: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Tips()),
                    );
                  },
                ),
                CustomAdminButton(
                  title: "Payments",
                  callback: () {
                    // TODO : navigate to payments screen
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
