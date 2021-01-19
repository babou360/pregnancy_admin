import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomButton.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomIconButton.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomImageVIew.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomInputField.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomLable.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomText.dart';
import 'package:mama_k_app_admin/Screens/tips/subTopic/subTopic.dart';
import 'package:mama_k_app_admin/models/mainTopic.dart';
import 'package:mama_k_app_admin/services/databaseService.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';
import 'package:mama_k_app_admin/app/sizeConfig.dart';

class AddMainTopic extends StatefulWidget {
  MainTopic mainTopic = MainTopic();
  bool isEdit;
  AddMainTopic({@required this.mainTopic, @required this.isEdit});
  @override
  _AddMainTopicState createState() => _AddMainTopicState();
}

class _AddMainTopicState extends State<AddMainTopic> {
  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;

  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descController = TextEditingController();

  DatabaseService _databaseService = DatabaseService();
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
    super.initState();
  }

  onClickSubmit() {
    if (_formKey.currentState.validate()) {
      this.widget.mainTopic.title = titleController.text;
      this.widget.mainTopic.description = descController.text;

      if (_imageFile != null) {
        String imagePath = "MainTopic/Topic" +
            this.widget.mainTopic.id.toString() +
            "-" +
            Path.basename(_imageFile.path).toString();
        _databaseService.uploadImage(
            imagePath, _imageFile, this.widget.mainTopic, context);
      } else {
        _databaseService.insertMainTopic(this.widget.mainTopic, context);
      }
    } else {
      //TODO: add form validation dialog
      print("form validate fail");
    }
  }

  @override
  Widget build(BuildContext context) {
    titleController.text = this.widget.mainTopic.title;
    descController.text = this.widget.mainTopic.description;
    this.imageURL = this.widget.mainTopic.imageURL;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: blockHeight * 3,
              horizontal: blockWidth * 5,
            ),
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
                    (this.widget.isEdit == true)
                        ? InkWell(
                            child: CustomLable(title: "Sub Topics"),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SubTopic(this.widget.mainTopic),
                                ),
                              );
                            },
                          )
                        : Container(),
                  ],
                ),
                SizedBox(height: blockHeight * 5),
                Container(
                  child: Form(
                    key: _formKey,
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
