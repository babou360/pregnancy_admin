import 'package:flutter/material.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomIconButton.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomLable.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomText.dart';
import 'package:mama_k_app_admin/Screens/tips/add/addMainTopic.dart';
import 'package:mama_k_app_admin/Screens/tips/tipList.dart';
import 'package:mama_k_app_admin/app/sizeConfig.dart';
import 'package:mama_k_app_admin/models/mainTopic.dart';
import 'package:mama_k_app_admin/services/databaseService.dart';

class Tips extends StatefulWidget {
  @override
  _TipsState createState() => _TipsState();
}

class _TipsState extends State<Tips> {
  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;
  DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: blockHeight * 3,
              horizontal: blockWidth * 5,
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CustomIconButton(
                      icon: Icons.arrow_back,
                      callback: () {
                        Navigator.pop(context);
                      },
                    ),
                    Container(
                      child: CustomText(
                        text: "Tips",
                        size: blockWidth * 7,
                      ),
                    ),
                    InkWell(
                      child: CustomLable(title: "Add New"),
                      onTap: () {
                        MainTopic mainTopic = MainTopic();
                        mainTopic.id = _databaseService.randomIdForMain();
                        mainTopic.title = "";
                        mainTopic.description = "";
                        mainTopic.imageURL = "";
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddMainTopic(
                                mainTopic: mainTopic, isEdit: false),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: blockHeight * 5),
                Container(
                  child: TipList(),
                  height: blockHeight * 85,
                ),
                SizedBox(height: blockHeight * 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
