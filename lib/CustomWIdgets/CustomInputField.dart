import 'package:flutter/material.dart';
import 'package:mama_k_app_admin/app/globals.dart';

class CustomInputField extends StatefulWidget {
  String hintText, fieldType;
  TextEditingController
      fieldController; // fieldType should be "mobile" or "text" or "none"
  IconData prefixIcon;
  TextInputType inputType;
  Color fillColor;

  CustomInputField(
      {@required this.hintText,
      @required this.fieldType,
      @required this.fieldController,
      @required this.prefixIcon,
      this.fillColor,
      this.inputType});

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  double blockHeight = Globals.blockHeight;
  double blockWidth = Globals.blockWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: this.widget.fieldController,
        validator: (this.widget.fieldType != "none") ? validateField : null,
        maxLines: null,
        keyboardType: (this.widget.inputType == null)
            ? TextInputType.text
            : this.widget.inputType,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(50.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(50.0),
          ),
          prefixIcon: Icon(this.widget.prefixIcon),
          hintText: this.widget.hintText,
          filled: true,
          fillColor: (this.widget.fillColor == null)
              ? Colors.green[50]
              : this.widget.fillColor,
          border: InputBorder.none,
        ),
      ),
    );
  }

  String validateField(String value) {
    switch (this.widget.fieldType) {
      case "text":
        return validateEmpty(value);
        break;
    }
  }

  String validateEmpty(String value) {
    if (value.isEmpty) {
      return "This field can't be empty";
    } else {
      return null;
    }
  }
}
