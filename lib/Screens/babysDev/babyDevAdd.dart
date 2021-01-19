import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomButton.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomIconButton.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomImageVIew.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomInputField.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomLable.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomLoading.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomText.dart';
import 'package:mama_k_app_admin/app/sizeConfig.dart';
import 'package:mama_k_app_admin/models/babyModel.dart';
import 'package:mama_k_app_admin/services/databaseService.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';

class BabyDevAdd extends StatefulWidget {
  int week;
  BabyDevAdd(this.week);
  @override
  _BabyDevAddState createState() => _BabyDevAddState();
}

class _BabyDevAddState extends State<BabyDevAdd> {
  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;

  final _formKey = GlobalKey<FormState>();
  final sizeController = TextEditingController();
  final weightController = TextEditingController();
  final descController = TextEditingController();

  DatabaseService _databaseService = DatabaseService();
  Stream userStream;
  Baby babyWeek = Baby();
  double size, weight;
  String description, imageURL;
  File _imageFile;

  Future getImage() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _imageFile = image;
        imageURL = image.path;
      });
    });
  }

  clearImage() {
    setState(() {
      _imageFile = null;
      imageURL = null;
    });
  }

  @override
  void initState() {
    _imageFile = null;
    userStream = _databaseService.getBabyWeekForAdmin(this.widget.week);
    super.initState();
  }

  onClickSubmit() {
    if (_formKey.currentState.validate()) {
      if (_imageFile != null) {
        this.babyWeek.size = double.parse(sizeController.text);
        this.babyWeek.weight = double.parse(weightController.text);
        this.babyWeek.tipDescription = this.descController.text;
        String imagePath = "babyWeek/week" +
            this.widget.week.toString() +
            "-" +
            Path.basename(_imageFile.path).toString();
        _databaseService.uploadImage(
            imagePath, _imageFile, this.babyWeek, context);
      } else {
        // TODO: image can be empty dialog
        print("image can't be null");
      }
    } else {
      // TODO: form validation failed dialog
      print("form validate fail");
    }
  }

  @override
  Widget build(BuildContext context) {
    this.babyWeek.week = this.widget.week;

    return StreamBuilder(
      stream: userStream,
      builder: (context, currentStream) {
        if (currentStream.hasData && currentStream.data.exists) {
          sizeController.text = currentStream.data['size'].toString();
          weightController.text = currentStream.data['weight'].toString();
          descController.text = currentStream.data['tipDescription'];
          imageURL = currentStream.data['imageURL'];

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
                          Container(
                            child: CustomText(text: "Baby's development"),
                          ),
                          CustomLable(
                            title: "Week " + this.widget.week.toString(),
                          ),
                        ],
                      ),
                      SizedBox(height: blockHeight * 5),
                      Container(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Container(
                                    child: CustomText(
                                      text: "Pick an image",
                                    ),
                                  ),
                                  SizedBox(width: blockWidth * 15),
                                  Row(
                                    children: [
                                      CustomIconButton(
                                        icon: Icons.add_a_photo,
                                        color: Colors.green[600],
                                        callback: () {
                                          getImage();
                                        },
                                      ),
                                      SizedBox(width: blockWidth * 5),
                                      (imageURL == null)
                                          ? Container()
                                          : CustomIconButton(
                                              icon: Icons.delete,
                                              color: Colors.green[600],
                                              callback: () {
                                                clearImage();
                                              },
                                            ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: blockHeight * 2.5),
                              CustomImageView(image: loadImage()),
                              SizedBox(height: blockHeight * 5),
                              CustomInputField(
                                hintText: "Size",
                                fieldType: "text",
                                fieldController: sizeController,
                                prefixIcon: Icons.keyboard,
                                inputType: TextInputType.number,
                              ),
                              SizedBox(height: blockHeight * 2.5),
                              CustomInputField(
                                hintText: "Weight",
                                fieldType: "text",
                                fieldController: weightController,
                                prefixIcon: Icons.keyboard,
                                inputType: TextInputType.number,
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
        } else {
          return SafeArea(
            child: Scaffold(body: CustomLoading()),
          );
        }
      },
    );
  }

  loadImage() {
    if (imageURL == "" && _imageFile == null) {
      return AssetImage("images/imageSelect.png"); // load defaluld icon
    } else if (_imageFile != null) {
      return AssetImage(_imageFile.path); // load selected image
    } else {
      return NetworkImage(imageURL); // load from database
    }
  }
}
