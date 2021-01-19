import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomButton.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomIconButton.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomImageVIew.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomLable.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomLoading.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomText.dart';
import 'package:mama_k_app_admin/app/sizeConfig.dart';
import 'package:mama_k_app_admin/models/motherMonthModel.dart';
import 'package:mama_k_app_admin/services/databaseService.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';

class AddMonth extends StatefulWidget {
  int month;
  AddMonth(this.month);
  @override
  _AddMonthState createState() => _AddMonthState();
}

class _AddMonthState extends State<AddMonth> {
  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;

  DatabaseService _databaseService = DatabaseService();
  Stream userStream;
  MotherInMonth motherMonth = MotherInMonth();
  String imageURL;
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
    userStream = _databaseService.getMomMOnthForAdmin(this.widget.month);
    super.initState();
  }

  onClickSubmit() {
    if (_imageFile != null) {
      String imagePath = "MotherInMonth/month" +
          this.widget.month.toString() +
          "-" +
          Path.basename(_imageFile.path).toString();
      _databaseService.uploadImage(
          imagePath, _imageFile, this.motherMonth, context);
    } else {
      //TODO: image cant be empty dialog
      print("image can't be null");
    }
  }

  @override
  Widget build(BuildContext context) {
    motherMonth.month = this.widget.month;
    return StreamBuilder(
      stream: userStream,
      builder: (context, currentStream) {
        if (currentStream.hasData && currentStream.data.exists) {
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
                          SizedBox(width: blockWidth * 2),
                          Container(
                            width: blockWidth * 50,
                            child: CustomText(
                                text: "Mother's Monthly development"),
                          ),
                          SizedBox(width: blockWidth * 1),
                          CustomLable(
                            title: "Month " + this.widget.month.toString(),
                          ),
                        ],
                      ),
                      SizedBox(height: blockHeight * 5),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
