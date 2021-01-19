import 'package:flutter/material.dart';
import 'package:mama_k_app_admin/app/sizeConfig.dart';

class CustomButton extends StatelessWidget {
  double width, height, fontSize;
  String title;
  Color bgColor, textColor;
  final VoidCallback callback;

  CustomButton(
      {@required this.title,
      @required this.bgColor,
      @required this.textColor,
      @required this.callback,
      this.height,
      this.width,
      this.fontSize});

  double blockHeight = SizeConfig.safeBlockVertical;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (height != null) ? height : blockHeight * 7,
      width: (width != null) ? width : double.infinity,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
          side: BorderSide(color: bgColor),
        ),
        color: bgColor,
        textColor: textColor,
        splashColor: Colors.green[200],
        child: Text(
          title,
          style: TextStyle(
            fontSize: (fontSize != null) ? fontSize : blockHeight * 3,
            fontWeight: FontWeight.w400,
          ),
        ),
        onPressed: () {
          callback();
        },
      ),
    );
  }
}
