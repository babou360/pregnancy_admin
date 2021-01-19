import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomDeleteModal.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomIconButton.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomLoading.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomText.dart';
import 'package:mama_k_app_admin/Screens/tips/add/addMainTopic.dart';
import 'package:mama_k_app_admin/app/sizeConfig.dart';
import 'package:mama_k_app_admin/models/mainTopic.dart';
import 'package:mama_k_app_admin/services/databaseService.dart';

class TipList extends StatelessWidget {
  DatabaseService db = DatabaseService();
  Stream str;

  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;

  onClickDelete(String id, BuildContext context) {
    db.deleteMainTopic(id);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    str = db.getTipCollection();
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
                            onClickDelete(doc["id"], context);
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
                    MainTopic mainTopic = MainTopic();
                    mainTopic.id = doc["id"];
                    mainTopic.title = doc["title"];
                    mainTopic.description = doc["description"];
                    mainTopic.imageURL = doc["imageURL"];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AddMainTopic(mainTopic: mainTopic, isEdit: true),
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
