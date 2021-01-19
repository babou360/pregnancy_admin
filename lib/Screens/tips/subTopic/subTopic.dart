import 'package:flutter/material.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomIconButton.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomLable.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomText.dart';
import 'package:mama_k_app_admin/Screens/tips/add/addSubTopic.dart';
import 'package:mama_k_app_admin/Screens/tips/subTopic/subTopicList.dart';
import 'package:mama_k_app_admin/app/sizeConfig.dart';
import 'package:mama_k_app_admin/models/mainTopic.dart';
import 'package:mama_k_app_admin/models/subTopicModel.dart';
import 'package:mama_k_app_admin/services/databaseService.dart';

class SubTopic extends StatefulWidget {
  MainTopic mainTopic = MainTopic();
  SubTopic(this.mainTopic);
  @override
  _SubTopicState createState() => _SubTopicState();
}

class _SubTopicState extends State<SubTopic> {
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
                        text: "Sub Topics",
                        size: blockWidth * 7,
                      ),
                    ),
                    InkWell(
                      child: CustomLable(title: "Add New"),
                      onTap: () {
                        SubTopicModel subTopic = SubTopicModel();
                        subTopic.id = _databaseService
                            .randomIdForSub(this.widget.mainTopic.id);
                        subTopic.title = "";
                        subTopic.description = "";
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddSubTopic(
                                mainTopic: this.widget.mainTopic,
                                subTopic: subTopic,
                                isEdit: false),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: blockHeight * 5),
                Container(
                  child: SubTopicList(this.widget.mainTopic),
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
