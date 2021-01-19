import 'package:flutter/material.dart';
import 'package:mama_k_app_admin/app/sizeConfig.dart';

class CustomAdminButton extends StatelessWidget {
  String title;
  final VoidCallback callback;
  CustomAdminButton({@required this.title, @required this.callback});

  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: blockHeight * 1),
      width: blockWidth * 90,
      height: blockWidth * 25,
      child: RaisedButton(
        color: Colors.green[200],
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: blockWidth * 6,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
        onPressed: () {
          callback();
        },
      ),
    );
  }
}
