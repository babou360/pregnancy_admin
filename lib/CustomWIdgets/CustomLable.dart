import 'package:flutter/material.dart';
import 'package:mama_k_app_admin/app/sizeConfig.dart';

class CustomLable extends StatelessWidget {
  String title;
  CustomLable({@required this.title});

  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: blockWidth * 5,
        vertical: blockHeight * 0.75,
      ),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.2),
        borderRadius: BorderRadius.all(
          Radius.circular(50.0),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: blockWidth * 4,
          color: Colors.green[900],
        ),
      ),
    );
  }
}
