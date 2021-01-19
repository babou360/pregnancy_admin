import 'package:flutter/material.dart';
import 'package:mama_k_app_admin/app/sizeConfig.dart';

class CustomImageView extends StatelessWidget {
  ImageProvider image;
  CustomImageView({@required this.image});

  double blockHeight = SizeConfig.safeBlockVertical;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: blockHeight * 25,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 3,
            blurRadius: 3,
            offset: Offset(0, 3),
          ),
        ],
        image: DecorationImage(
          image: image,
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
    );
  }
}
