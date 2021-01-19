import 'package:flutter/material.dart';
import 'package:mama_k_app_admin/CustomWIdgets/appBar.dart';
import 'package:mama_k_app_admin/Screens/baby/addBaby.dart';
import 'package:mama_k_app_admin/Screens/baby/babyDetails.dart';
import 'package:mama_k_app_admin/Screens/tip/addtip.dart';
import 'package:mama_k_app_admin/Screens/tip/tipDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class BabyPage extends StatefulWidget {
  @override
  _BabyPageState createState() => _BabyPageState();
}

class _BabyPageState extends State<BabyPage> {

  navigateToDetail( DocumentSnapshot tips) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BabyDetails(
                  tip: tips,
    )));
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
                        child: Text('BABY',style: TextStyle(fontWeight: FontWeight.w700),)
                      ),
                      GestureDetector(
                        onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) =>AddBaby())),
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
                          child: Text('Add New',style: TextStyle(fontWeight: FontWeight.w700))
                        ),
                      ),
                    ],
                  ),
                ),
        ),
        body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('baby').snapshots(),
        builder: (context, snapshot){
          //final List<DocumentSnapshot> tips = snapshot.data.docs;
          final tips = snapshot.data.documents;
          if(snapshot.connectionState==ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if(snapshot.data==null){
              return Center(
                    child: Text('No Tips',style: TextStyle(fontWeight: FontWeight.w900)),
             );
            }
            else if( snapshot.data.documents.length<1){
              return Center(
                    child: Text('No Tips Please Create one',style: TextStyle(fontWeight: FontWeight.w600)),
             );
            }
          else if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot tips = snapshot.data.documents[index];
                return GestureDetector(
                  onTap: () => navigateToDetail(tips),
                  child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: GestureDetector(
                    onTap:() => navigateToDetail(tips),
                    child: Container(
                      color: Colors.grey[100],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width/4,
                              child: Image.network(tips['image'],fit: BoxFit.cover),
                            ),
                            SizedBox(width: 5),
                            Container(
                              width: MediaQuery.of(context).size.width/1.5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(tips['title'],overflow: TextOverflow.ellipsis,),
                                  SizedBox(height: 2,),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ));
              },
            );
          }else{
            return Center(
              child: Text('No Tips'),
            );
          }
        },
      ),
      ),
    );
  }
}
