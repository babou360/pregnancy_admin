import 'package:flutter/material.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomDeleteModal.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomIconButton.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomListItemCard.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomText.dart';
import 'package:mama_k_app_admin/Screens/babysDev/babyDevAdd.dart';
import 'package:mama_k_app_admin/app/sizeConfig.dart';
import 'package:mama_k_app_admin/models/babyModel.dart';
import 'package:mama_k_app_admin/services/databaseService.dart';

class BabysDev extends StatefulWidget {
  @override
  _BabysDevState createState() => _BabysDevState();
}

class _BabysDevState extends State<BabysDev> {
  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;

  DatabaseService _databaseService = DatabaseService();

  Baby babyWeek = Baby();

  onClickDelete(int week) {
    _databaseService.deleteBabyWeek(week);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: blockWidth * 5,
              vertical: blockHeight * 5,
            ),
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CustomIconButton(
                        icon: Icons.arrow_back,
                        callback: () {
                          Navigator.pop(context);
                        }),
                    Container(
                        child: CustomText(
                      text: "Baby's development - Weekly",
                      size: blockWidth * 5.5,
                    )),
                  ],
                ),
                SizedBox(height: blockHeight * 5),
                Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).size.height * 0.22,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 40,
                        itemBuilder: (context, position) {
                          return CustomListItemCard(
                            title: "Week " + (position + 1).toString(),
                            deleteCallback: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDeleteModal(
                                    callback: () {
                                      onClickDelete(position + 1);
                                    },
                                  );
                                },
                              );
                            },
                            editCallback: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BabyDevAdd(position + 1),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
