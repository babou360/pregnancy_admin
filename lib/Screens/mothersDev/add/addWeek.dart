import 'package:flutter/material.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomButton.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomIconButton.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomInputField.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomLable.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomLoading.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomText.dart';
import 'package:mama_k_app_admin/app/sizeConfig.dart';
import 'package:mama_k_app_admin/models/motherWeekModel.dart';
import 'package:mama_k_app_admin/services/databaseService.dart';

class AddWeek extends StatefulWidget {
  int week;
  AddWeek(this.week);
  @override
  _AddWeekState createState() => _AddWeekState();
}

class _AddWeekState extends State<AddWeek> {
  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;

  final _formKey = GlobalKey<FormState>();
  final descController = TextEditingController();

  DatabaseService _databaseService = DatabaseService();
  Stream userStream;
  MotherInWeek motherWeek = MotherInWeek();
  String description;

  @override
  void initState() {
    super.initState();
    userStream = _databaseService.getMomWeekForAdmin(this.widget.week);
  }

  onClickSubmit() {
    if (_formKey.currentState.validate()) {
      motherWeek.tipDescription = descController.text;
      _databaseService.insertMotherWeek(motherWeek);
      Navigator.pop(context);
    } else {
      // TODO: form validation failed dialog
      print("form validate fail");
    }
  }

  @override
  Widget build(BuildContext context) {
    this.motherWeek.week = this.widget.week;
    return StreamBuilder(
      stream: userStream,
      builder: (context, currentStream) {
        if (currentStream.hasData && currentStream.data.exists) {
          descController.text = currentStream.data['tipDescription'];
          return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: blockWidth * 5,
                    vertical: blockHeight * 5,
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
                          SizedBox(width: blockWidth * 3),
                          Container(
                            width: blockWidth * 50,
                            child:
                                CustomText(text: "Mother's Weekly development"),
                          ),
                          SizedBox(width: blockWidth * 2),
                          CustomLable(
                            title: "Week " + this.widget.week.toString(),
                          ),
                        ],
                      ),
                      Container(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: blockHeight * 10),
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
        } else {
          return SafeArea(
            child: Scaffold(body: CustomLoading()),
          );
        }
      },
    );
  }
}
