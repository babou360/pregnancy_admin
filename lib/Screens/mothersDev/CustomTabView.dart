import 'package:flutter/material.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomDeleteModal.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomListItemCard.dart';
import 'package:mama_k_app_admin/Screens/mothersDev/add/addMonth.dart';
import 'package:mama_k_app_admin/Screens/mothersDev/add/addWeek.dart';
import 'package:mama_k_app_admin/app/sizeConfig.dart';
import 'package:mama_k_app_admin/services/databaseService.dart';

class CustomTabView extends StatefulWidget {
  String type;
  CustomTabView({@required this.type});

  @override
  _CustomTabViewState createState() => _CustomTabViewState();
}

class _CustomTabViewState extends State<CustomTabView> {
  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;

  DatabaseService _databaseService = DatabaseService();

  int itemCount;
  String categoryName;

  onClickDelete(int position) {
    if (this.widget.type == "weekly") {
      _databaseService.deleteMomWeek(position);
    } else {
      _databaseService.deleteMomMonth(position);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    if (this.widget.type == "weekly") {
      itemCount = 40;
      categoryName = "Week ";
    } else if (this.widget.type == "monthly") {
      itemCount = 10;
      categoryName = "Month ";
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: blockWidth * 5),
      width: double.infinity,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: itemCount,
        itemBuilder: (context, position) {
          return CustomListItemCard(
            title: categoryName + (position + 1).toString(),
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
                  builder: (context) => (this.widget.type == "weekly")
                      ? AddWeek(position + 1)
                      : AddMonth(position + 1),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
