import 'package:flutter/material.dart';
import 'package:mama_k_app_admin/app/sizeConfig.dart';

class CustomLoading extends StatelessWidget {
  double blockHeight = SizeConfig.safeBlockVertical;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: blockHeight * 20),
          Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        ],
      ),
    );
  }
}
