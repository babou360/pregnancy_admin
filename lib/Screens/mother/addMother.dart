import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mama_k_app_admin/CustomWIdgets/customSlider.dart';
import 'package:mama_k_app_admin/Screens/baby/baby.dart';
import 'package:mama_k_app_admin/Screens/mother/mother.dart';
import 'package:mama_k_app_admin/Screens/tip/addtip.dart';
import 'package:mama_k_app_admin/Screens/tip/tipspage.dart';
import 'package:path/path.dart' as Path;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddMother extends StatefulWidget {
  @override
  _AddMotherState createState() => _AddMotherState();
}

class _AddMotherState extends State<AddMother> {
final _formKey = GlobalKey<FormState>();
File _image;
final picker = ImagePicker();
TextEditingController titleController=TextEditingController();
TextEditingController subtitleController=TextEditingController();
TextEditingController descriptionController=TextEditingController();
TextEditingController lengthController=TextEditingController();
TextEditingController weightController=TextEditingController();
List<String> weeks = [
  '1','2','3','4','5','6','7','8','9'
];
String _week;
String description;
String title;
String length;
String weight;
bool isLoading = false;
bool isTaped = false;
String imageUrl;
int _value = 6;  
int week = 0;

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

  checkIsTaped (){
    if(isTaped){
      setState(() {
        isTaped = false;
      });
    }else{
      setState(() {
        isTaped = true;
      });
    }
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
                          child: Text('ADD NEW BABY TIP',style: TextStyle(fontWeight: FontWeight.w700),)
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
                // Container( 
                //   child: Slider(
                //     value: _value.toDouble(),  
                //     min: 1.0,  
                //     max: 40.0,  
                //     divisions: 10,  
                //     activeColor: Colors.green,  
                //     inactiveColor: Colors.orange,  
                //     label: 'Set volume value',
                //      onChanged: (double newValue) {  
                //       setState(() {  
                //         _value = newValue.round();  
                //         });  
                //       },  
                //       semanticFormatterCallback: (double newValue) {  
                //         return '${newValue.round()} dollars';  
                //     } 
                //   )
                // ),
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
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text('Select Month>>',style: TextStyle(fontWeight: FontWeight.w700)),
                        ),
                        DropdownButton<String>(
                                  hint: Text("_______________",style: TextStyle(fontWeight: FontWeight.w700,color: Colors.grey),),
                                dropdownColor: Colors.white,
                                value: _week,
                                // icon: Icon(Icons.arrow_drop_down,color: Color(0xFF80E1D1)),
                                icon: Icon(Icons.arrow_drop_down,color: Colors.black),
                                iconSize: 24,
                                elevation: 16,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey
                                // color: Color(0xFF80E1D1)
                                ),
                                onChanged: (String newValue) {
                                setState(() {
                                _week = newValue;
                                });
                                },
                                items: weeks.map((weeks) {
                                return DropdownMenuItem(
                            child: new Text(weeks),
                            value: weeks,
                            );
                          }).toList(),
                            ),
                      ],
                    ),
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
                  cursorColor: Colors.black,
                  style: TextStyle(color:Colors.black,
                  fontWeight: FontWeight.w600,decorationColor: Colors.black ),
                  validator: (value){
                    if(value.isEmpty){
                      return 'Length Cannot be Empty';
                    } else{
                      return null;
                    }
                  },
                  controller: lengthController,
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
                    labelText: "Length",
                    hintText: "Length In Cm",
                    fillColor: Colors.black,
                    focusColor: Colors.black,
                    hoverColor: Colors.black,
                  ),
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  onChanged: (input)=> length=input
            ),
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
                      return 'Weight Cannot be Empty';
                    } else{
                      return null;
                    }
                  },
                  controller: weightController,
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
                    labelText: "Weight",
                    hintText: "Weight in KG",
                    fillColor: Colors.black,
                    focusColor: Colors.black,
                    hoverColor: Colors.black,
                  ),
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  onChanged: (input)=> weight=input
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
       if(_image != null && title.isNotEmpty && description.isNotEmpty ){
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
          FirebaseFirestore.instance.collection('mother').doc(_week).set({
            'month': _week,
            'image':url,
            'title': title,
            'description': description,
            'length': length,
            'weight': weight,
            'date': DateTime.now()
          });
        }); 
        setState(() {
          isLoading =false;
          _image= null;
          titleController.clear();
          descriptionController.clear();
        });  
        Navigator.push(context, MaterialPageRoute(builder: (context) => MotherPage()));
     }
   }
  }
}