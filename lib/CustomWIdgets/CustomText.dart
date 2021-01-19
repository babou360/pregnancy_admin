import 'package:flutter/material.dart';
import 'package:mama_k_app_admin/app/sizeConfig.dart';

class CustomText extends StatelessWidget {
  String text;
  FontWeight weight;
  Color color;
  double size;

  CustomText({@required this.text, this.weight, this.color, this.size});

  double blockWidth = SizeConfig.safeBlockHorizontal;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: (weight != null) ? weight : FontWeight.w300,
        fontSize: (size != null) ? size : blockWidth * 5,
        color: (color != null) ? color : Colors.black54,
      ),
      softWrap: true,
    );
  }
}
