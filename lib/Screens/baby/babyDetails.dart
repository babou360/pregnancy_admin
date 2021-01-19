import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mama_k_app_admin/CustomWIdgets/appBar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mama_k_app_admin/Screens/tip/tipspage.dart';

class BabyDetails extends StatefulWidget {
  DocumentSnapshot tip;
   BabyDetails({Key key, this.tip}) : super(key: key);
  @override
  _BabyDetailsState createState() => _BabyDetailsState();
}

class _BabyDetailsState extends State<BabyDetails> {
  bool isLoading =false;

  delete() async{
    setState(() {
      isLoading = true;
    });
     FirebaseFirestore.instance.collection('baby')
    .doc(widget.tip.id)
    .get().then((doc){
      if(doc.exists){
        doc.reference.delete();
      }
    });
    setState(() {
      isLoading = false;
    });
    Fluttertoast.showToast(
    msg: 'Tip Deleted',
    toastLength: Toast.LENGTH_SHORT,
    // gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.yellow[900],
    textColor: Colors.white,
    fontSize: 16.0
    );
    Navigator.push(context, MaterialPageRoute(builder: (context) => TipsPage()));
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
            height: 70,
            child: Padding(
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
                          child: Text('Baby Details',style: TextStyle(fontWeight: FontWeight.w700),)
                        ),
                        GestureDetector(
                          onTap: delete,
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
                            child: isLoading? CircularProgressIndicator() : Icon(Icons.delete)
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Card(
              child: Column(
                children: [
                  Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: CachedNetworkImage(
                          imageUrl: widget.tip['image'], fit: BoxFit.cover,
                          progressIndicatorBuilder: (context, url, downloadProgress) => 
                                  CircularProgressIndicator(value: downloadProgress.progress,backgroundColor: Colors.orange,),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.tip['title'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                        SizedBox(height: 20,),
                        Text(widget.tip['description'] ,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black54)),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Baby's Dimensions on Week ",style: TextStyle(fontWeight: FontWeight.w600)),
                      Text(widget.tip['week'].toString()),
                    ],
                  ),
                  SizedBox(height: 6,),
                  Container(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.orange[100],
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width/3,
                            decoration: BoxDecoration(
                                    color: Colors.orange[100],
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                                  ),
                            child: Column(
                              children: [
                                Container(
                                  // margin: const EdgeInsets.only(bottom: 10),
                                  alignment: Alignment.center,
                                  height: 50,
                                  width: MediaQuery.of(context).size.width/2,
                                  child: Text('Length'),
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  width: MediaQuery.of(context).size.width/2,
                                  child: Text(widget.tip['length'].toString() + ' CM'),
                                  decoration: BoxDecoration(
                                    color: Colors.orange[100],
                                    // borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width/3,
                            decoration: BoxDecoration(
                                    color: Colors.orange[100],
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                                  ),
                            child: Column(
                              children: [
                                Container(
                                  // margin: const EdgeInsets.only(bottom: 10),
                                  alignment: Alignment.center,
                                  height: 50,
                                  width: MediaQuery.of(context).size.width/2,
                                  child: Text('Weight'),
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  width: MediaQuery.of(context).size.width/2,
                                  child: Text(widget.tip['weight'].toString() + ' KG'),
                                  decoration: BoxDecoration(
                                    color: Colors.orange[100],
                                    // borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],),
            ),
          ),
        ),
      ),
    );
  }
}