import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mama_k_app_admin/models/babyModel.dart';
import 'package:mama_k_app_admin/models/mainTopic.dart';
import 'package:mama_k_app_admin/models/motherMonthModel.dart';
import 'package:mama_k_app_admin/models/motherWeekModel.dart';
import 'package:mama_k_app_admin/models/subTopicModel.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  final firestoreInstance = FirebaseFirestore.instance;
  final storageInstance = FirebaseStorage.instance;

  configureDatabase() async {
    await firestoreInstance.collection("babyWeek").get().then((value) => {
          if (value.docs.isEmpty)
            {
              print("babyWeek2 Collection empty, need to create"),
              initBabyWeek(),
            }
          else
            {
              print("babyWeek2 Collection exists. no need to create"),
            }
        });

    await firestoreInstance.collection("momsInWeek").get().then((value) => {
          if (value.docs.isEmpty)
            {
              print("momsInWeek Collection empty, need to create"),
              initMomsWeek(),
            }
          else
            {
              print("babyWeek2 Collection exists. no need to create"),
            }
        });

    await firestoreInstance.collection("momsInMonth").get().then((value) => {
          if (value.docs.isEmpty)
            {
              print("momsInMonth Collection empty, need to create"),
              initMomsMonth(),
            }
          else
            {
              print("momsInMonth Collection exists. no need to create"),
            }
        });
  }

// Initial document setup
  initBabyWeek() async {
    for (int i = 1; i <= 40; i++) {
      await firestoreInstance
          .collection('babyWeek')
          .doc("week" + i.toString())
          .set(
        {
          'week': i,
          'size': 0.0,
          'weight': 0.0,
          'imageURL': '',
          'tipDescription': '',
        },
      );
    }
    print("babyWeek is done");
  }

  initMomsWeek() async {
    for (int i = 1; i <= 40; i++) {
      await firestoreInstance
          .collection('momsInWeek')
          .doc("week" + i.toString())
          .set(
        {
          'week': i,
          'month': 1,
          'tipDescription': '',
        },
      );
    }
    print("MomsInWeek is done");
  }

  initMomsMonth() async {
    for (int i = 1; i <= 10; i++) {
      await firestoreInstance
          .collection('momsInMonth')
          .doc("month" + i.toString())
          .set(
        {
          'month': i,
          'imageURL': '',
        },
      );
    }
    print('momsInMonth is done');
  }

//Baby's Development
  insertBabyWeek(Baby baby, BuildContext context) async {
    await firestoreInstance
        .collection('babyWeek')
        .doc("week" + baby.week.toString())
        .set(
      {
        'week': baby.week,
        'size': baby.size,
        'weight': baby.weight,
        'imageURL': baby.imageURL,
        'tipDescription': baby.tipDescription,
      },
    );
    Navigator.of(context).pop();
  }

  Stream<dynamic> getBabyWeekForAdmin(int week) {
    return firestoreInstance
        .collection("babyWeek")
        .doc("week" + week.toString())
        .snapshots();
  }

  deleteBabyWeek(int week) {
    return firestoreInstance
        .collection("babyWeek")
        .doc("week" + week.toString())
        .delete();
  }

// Mother's development

  insertMotherWeek(MotherInWeek week) async {
    await firestoreInstance
        .collection('momsInWeek')
        .doc("week" + week.week.toString())
        .set(
      {
        'month': week.month,
        'week': week.week,
        'tipDescription': week.tipDescription,
      },
    );
  }

  insertMotherMonth(MotherInMonth month, BuildContext context) async {
    await firestoreInstance
        .collection('momsInMonth')
        .doc("month" + month.month.toString())
        .set(
      {
        'month': month.month,
        'imageURL': month.imageURL,
      },
    );
    Navigator.of(context).pop();
  }

  Stream<dynamic> getMomWeekForAdmin(int week) {
    return firestoreInstance
        .collection('momsInWeek')
        .doc("week" + week.toString())
        .snapshots();
  }

  Stream<dynamic> getMomMOnthForAdmin(int month) {
    return firestoreInstance
        .collection('momsInMonth')
        .doc("month" + month.toString())
        .snapshots();
  }

  deleteMomWeek(int week) {
    return firestoreInstance
        .collection("momsInWeek")
        .doc("week" + week.toString())
        .delete();
  }

  deleteMomMonth(int month) {
    return firestoreInstance
        .collection("momsInMonth")
        .doc("month" + month.toString())
        .delete();
  }

// TIPS

  insertMainTopic(MainTopic mainTopic, BuildContext context) async {
    await firestoreInstance.collection('tips').doc(mainTopic.id).set(
      {
        'id': mainTopic.id,
        'title': mainTopic.title,
        'description': mainTopic.description,
        'imageURL': mainTopic.imageURL,
      },
    );
    Navigator.of(context).pop();
  }

  insertSubTopic(String mainTopicId, SubTopicModel subTopic) async {
    await firestoreInstance
        .collection('tips')
        .doc(mainTopicId)
        .collection("subTopics")
        .doc(subTopic.id)
        .set(
      {
        'id': subTopic.id,
        'title': subTopic.title,
        'description': subTopic.description,
      },
    );
  }

  Stream<dynamic> getTipCollection() {
    return firestoreInstance.collection("tips").snapshots();
  }

  Stream<dynamic> getSubTopicCollection(String docId) {
    return firestoreInstance
        .collection("tips")
        .doc(docId)
        .collection("subTopics")
        .snapshots();
  }

  deleteMainTopic(String id) {
    return firestoreInstance.collection("tips").doc(id).delete();
  }

  deleteSubTopic(String mainTopic, String subTopic) {
    return firestoreInstance
        .collection("tips")
        .doc(mainTopic)
        .collection("subTopics")
        .doc(subTopic)
        .delete();
  }

  String randomIdForMain() {
    var _randomId = firestoreInstance.collection("tips").doc().id;
    return _randomId;
  }

  String randomIdForSub(String mainTopicId) {
    var _randomId = firestoreInstance
        .collection("tips")
        .doc(mainTopicId)
        .collection("subTopics")
        .doc()
        .id;
    return _randomId;
  }

  Future uploadImage(
      String filePath, File file, dynamic model, BuildContext context) async {
    // need to be delete prev: image
    StorageReference storageReference = storageInstance.ref();
    StorageUploadTask uploadTask =
        storageReference.child(filePath).putFile(file);

    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then((downloadURL) {
      model.imageURL = downloadURL;
      if (model is Baby) {
        insertBabyWeek(model, context);
      } else if (model is MotherInMonth) {
        insertMotherMonth(model, context);
      } else if (model is MainTopic) {
        insertMainTopic(model, context);
      }
    });
  }
}
