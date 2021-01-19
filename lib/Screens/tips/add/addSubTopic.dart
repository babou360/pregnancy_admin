import 'package:flutter/material.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomButton.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomIconButton.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomInputField.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomText.dart';
import 'package:mama_k_app_admin/app/sizeConfig.dart';
import 'package:mama_k_app_admin/models/mainTopic.dart';
import 'package:mama_k_app_admin/models/subTopicModel.dart';
import 'package:mama_k_app_admin/services/databaseService.dart';

class AddSubTopic extends StatefulWidget {
  MainTopic mainTopic = MainTopic();
  SubTopicModel subTopic = SubTopicModel();
  bool isEdit;
  AddSubTopic(
      {@required this.mainTopic,
      @required this.subTopic,
      @required this.isEdit});
  @override
  _AddSubTopicState createState() => _AddSubTopicState();
}

class _AddSubTopicState extends State<AddSubTopic> {
  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;

  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descController = TextEditingController();

  DatabaseService _databaseService = DatabaseService();
  String id;

  onClickSubmit() {
    if (_formKey.currentState.validate()) {
      this.widget.subTopic.title = titleController.text;
      this.widget.subTopic.description = descController.text;
      _databaseService.insertSubTopic(
          this.widget.mainTopic.id, this.widget.subTopic);
      Navigator.pop(context);
    } else {
      //TODO: add form validation dialog
      print("form validate fail");
    }
  }

  @override
  Widget build(BuildContext context) {
    titleController.text = this.widget.subTopic.title;
    descController.text = this.widget.subTopic.description;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: blockHeight * 3,
              horizontal: blockWidth * 5,
            ),
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CustomIconButton(
                      icon: Icons.arrow_back,
                      callback: () {
                        Navigator.pop(context);
                      },
                    ),
                    Container(
                      child: CustomText(
                        text: (this.widget.isEdit == true)
                            ? "Update Topic"
                            : "Add new Topic",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: blockHeight * 5),
                Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        CustomInputField(
                          hintText: "Title",
                          fieldType: "text",
                          fieldController: titleController,
                          prefixIcon: Icons.keyboard,
                        ),
                        SizedBox(height: blockHeight * 2.5),
                        CustomInputField(
                          hintText: "Description",
                          fieldType: "text",
                          fieldController: descController,
                          prefixIcon: Icons.keyboard,
                        ),
                        SizedBox(height: blockHeight * 2.5),
                        CustomButton(
                          title: "Submit",
                          bgColor: Colors.green[400],
                          textColor: Colors.white,
                          height: blockHeight * 6,
                          callback: () {
                            onClickSubmit();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
