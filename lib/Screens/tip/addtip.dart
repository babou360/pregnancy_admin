import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mama_k_app_admin/Screens/tip/tipspage.dart';
import 'package:path/path.dart' as Path;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ADDTIP extends StatefulWidget {
  @override
  _ADDTIPState createState() => _ADDTIPState();
}

class _ADDTIPState extends State<ADDTIP> {
final _formKey = GlobalKey<FormState>();
File _image;
final picker = ImagePicker();
TextEditingController titleController=TextEditingController();
TextEditingController subtitleController=TextEditingController();
TextEditingController descriptionController=TextEditingController();
String description;
String title;
String subtitle;
bool isLoading = false;
String imageUrl;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.green
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          child: IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: ()=> Navigator.pop(context),
                          ),
                        ),
                        Container(
                          child: Text('ADD NEW TIP',style: TextStyle(fontWeight: FontWeight.w700),)
                        ),
                        GestureDetector(
                          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) =>ADDTIP())),
                          child: Container(
                            alignment: Alignment.center,
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.green
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            child: GestureDetector(
                              onTap: getImage,
                              child: Icon(Icons.camera_alt))
                          ),
                        ),
                      ],
                    ),
                ),
                GestureDetector(
                  onTap: getImage,
                  child: Container(
                    color: Colors.grey,
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: _image == null
                    ?Image.asset('images/imageSelect.png',fit: BoxFit.contain)
                    :Image.file(_image)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                  cursorColor: Colors.black,
                  style: TextStyle(color:Colors.black,
                  fontWeight: FontWeight.w600,decorationColor: Colors.black ),
                  validator: (value){
                    if(value.isEmpty){
                      return 'Title Cannot be Empty';
                    } else{
                      return null;
                    }
                  },
                  controller: titleController,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black
                      )
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      )
                    ),
                    labelText: "Title",
                    hintText: "Title",
                    fillColor: Colors.black,
                    focusColor: Colors.black,
                    hoverColor: Colors.black,
                  ),
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  onChanged: (input)=> title=input
            ),
              ),
                ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    maxLines: 2,
                  cursorColor: Colors.black,
                  style: TextStyle(color:Colors.black,
                  fontWeight: FontWeight.w600,decorationColor: Colors.black ),
                  validator: (value){
                    if(value.isEmpty){
                      return 'SubTitle Cannot be Empty';
                    } else{
                      return null;
                    }
                  },
                  controller: subtitleController,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black
                      )
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      )
                    ),
                    labelText: "subtitle",
                    hintText: "SubTitle",
                    fillColor: Colors.black,
                    focusColor: Colors.black,
                    hoverColor: Colors.black,
                  ),
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  onChanged: (input)=> subtitle=input
            ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    maxLines: 5,
                  cursorColor: Colors.green,
                  style: TextStyle(color:Colors.black,
                  fontWeight: FontWeight.w600,decorationColor: Colors.black ),
                  validator: (value){
                    if(value.isEmpty){
                      return 'Description Cannot be Empty';
                    } else{
                      return null;
                    }
                  },
                  controller: descriptionController,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black
                      )
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      )
                    ),
                    labelText: "Description",
                    hintText: "Description",
                    fillColor: Color(0xFFFFC107),
                    focusColor: Color(0xFFFFC107),
                    hoverColor: Color(0xFFFFC107),
                  ),
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  onChanged: (input)=> description=input
            ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: _submit,
                  child: Container(
                    width: MediaQuery.of(context).size.width/2,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: isLoading? Colors.greenAccent : Colors.green,
                    ),
                    child: isLoading ?CircularProgressIndicator(backgroundColor: Colors.green,) : Text('Upload'),
                  ),
                ),
              )
              ],
            ),
          ),
          // ),
        ),
      ),
    );
  }


 Future uploadFile() async {    
   StorageReference storageReference = FirebaseStorage.instance    
       .ref()    
       .child('images/${Path.basename(_image.path)}}');    
   StorageUploadTask uploadTask = storageReference.putFile(_image);    
   await uploadTask.onComplete;    
   print('File Uploaded');    
   storageReference.getDownloadURL().then((fileURL) {    
     setState(() {    
       imageUrl = fileURL;    
     });    
   });    
 }

 Future  _submit() async{
   final FormState form = _formKey.currentState;
   if(!_formKey.currentState.validate()){
     Scaffold.of(context).showSnackBar(
         SnackBar(content: Text("Please fill out all the fields"),
         duration: new Duration(seconds: 2),
         behavior: SnackBarBehavior.floating,
         elevation: 3.0,
         backgroundColor: Colors.green,)
       );
     }else{
       if(_image != null && title.isNotEmpty && subtitle.isNotEmpty && description.isNotEmpty ){
        form.save();
        setState(() {
        isLoading=true;
        });
        StorageReference storageReference = FirebaseStorage.instance    
       .ref()    
       .child('images/${Path.basename(_image.path)}}');    
        StorageUploadTask uploadTask = storageReference.putFile(_image);    
        await uploadTask.onComplete;    
        print('File Uploaded'); 
        String downloadUrl =await storageReference.getDownloadURL()
        .then((url) {
          FirebaseFirestore.instance.collection('tips').add({
            'image':url,
            'title': title,
            'subtitle': subtitle,
            'description': description,
            'date': DateTime.now()
          });
        }); 
        setState(() {
          isLoading =false;
          _image= null;
          titleController.clear();
          subtitleController.clear();
          descriptionController.clear();
        });  
        Navigator.push(context, MaterialPageRoute(builder: (context) => TipsPage()));
     }
   }
  }
}