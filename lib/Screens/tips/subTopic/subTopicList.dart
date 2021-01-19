import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomDeleteModal.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomIconButton.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomLoading.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomText.dart';
import 'package:mama_k_app_admin/Screens/tips/add/addSubTopic.dart';
import 'package:mama_k_app_admin/app/sizeConfig.dart';
import 'package:mama_k_app_admin/models/mainTopic.dart';
import 'package:mama_k_app_admin/models/subTopicModel.dart';
import 'package:mama_k_app_admin/services/databaseService.dart';

class SubTopicList extends StatelessWidget {
  MainTopic mainTopic = MainTopic();
  SubTopicList(this.mainTopic);
  DatabaseService db = DatabaseService();
  Stream str;

  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;

  onClickDelte(String mainId, String subId, BuildContext context) {
    db.deleteSubTopic(mainId, subId);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    str = db.getSubTopicCollection(this.mainTopic.id);
    return StreamBuilder<QuerySnapshot>(
      stream: str,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CustomLoading();
        } else {
          return ListView(
            scrollDirection: Axis.vertical,
            children: getExpenseItems(snapshot, context),
          );
        }
      },
    );
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot, BuildContext context) {
    return snapshot.data.docs
        .map(
          (doc) => ListTile(
            title: CustomText(
              text: doc["title"],
              size: blockWidth * 4,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(width: blockWidth * 5),
                CustomIconButton(
                  icon: Icons.delete_forever,
                  callback: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomDeleteModal(
                          callback: () {
                            onClickDelte(mainTopic.id, doc["id"], context);
                          },
                        );
                      },
                    );
                  },
                ),
                SizedBox(width: blockWidth * 5),
                CustomIconButton(
                  icon: Icons.arrow_forward_ios,
                  callback: () {
                    SubTopicModel subTopic = SubTopicModel();
                    subTopic.id = doc["id"];
                    subTopic.title = doc["title"];
                    subTopic.description = doc["description"];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddSubTopic(
                            mainTopic: mainTopic,
                            subTopic: subTopic,
                            isEdit: true),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        )
        .toList();
  }
}
