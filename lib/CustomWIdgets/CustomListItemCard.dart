import 'package:flutter/material.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomIconButton.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomText.dart';
import 'package:mama_k_app_admin/app/sizeConfig.dart';

class CustomListItemCard extends StatelessWidget {
  String title;
  final VoidCallback deleteCallback, editCallback;

  CustomListItemCard(
      {@required this.title,
      @required this.deleteCallback,
      @required this.editCallback});

  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: blockHeight * 1),
      width: double.infinity,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: blockWidth * 7.5,
          vertical: blockWidth * 4,
        ),
        decoration: BoxDecoration(
          color: Colors.lightGreen[100].withOpacity(0.7),
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CustomText(
              text: title,
            ),
            Row(
              children: [
                CustomIconButton(
                  icon: Icons.delete_forever,
                  callback: () {
                    deleteCallback();
                  },
                ),
                SizedBox(width: blockWidth * 5),
                CustomIconButton(
                  icon: Icons.arrow_forward_ios,
                  callback: () {
                    editCallback();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
