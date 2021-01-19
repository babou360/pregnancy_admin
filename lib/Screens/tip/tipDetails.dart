import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mama_k_app_admin/CustomWIdgets/appBar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mama_k_app_admin/Screens/tip/tipspage.dart';

class TipDetails extends StatefulWidget {
  DocumentSnapshot tip;
   TipDetails({Key key, this.tip}) : super(key: key);
  @override
  _TipDetailsState createState() => _TipDetailsState();
}

class _TipDetailsState extends State<TipDetails> {
  bool isLoading =false;

  delete() async{
    setState(() {
      isLoading = true;
    });
     FirebaseFirestore.instance.collection('tips')
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
                          child: Text('Tip Details',style: TextStyle(fontWeight: FontWeight.w700),)
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
                        Text(widget.tip['subtitle'],style: TextStyle(fontSize: 10,fontWeight: FontWeight.w400,color: Colors.grey)),
                        SizedBox(height: 20,),
                        Text(widget.tip['description'] ,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black54)),
                      ],
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