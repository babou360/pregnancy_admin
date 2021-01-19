import 'package:flutter/material.dart';

class CustomDeleteModal extends StatelessWidget {
  final VoidCallback callback;
  CustomDeleteModal({@required this.callback});

  @override
  Widget build(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("DELETE"),
      onPressed: () {
        callback();
      },
    );

    return AlertDialog(
      title: Text("Confirm Delete"),
      content: Text("Are you sure you want to delete this ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
  }
}
