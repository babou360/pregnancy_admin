import 'package:flutter/material.dart';
import 'package:mama_k_app_admin/app/sizeConfig.dart';

class CustomIconButton extends StatelessWidget {
  IconData icon;
  final VoidCallback callback;
  Color color;
  CustomIconButton({@required this.icon, @required this.callback, this.color});

  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(blockWidth * 2),
        decoration: BoxDecoration(
          color: Colors.green[200].withOpacity(0.4),
          borderRadius: BorderRadius.all(
            Radius.circular(25.0),
          ),
        ),
        child: Icon(
          icon,
          color: (color != null) ? color : Colors.black26,
        ),
      ),
      onTap: () {
        callback();
      },
    );
  }
}
