import 'package:flutter/material.dart';
import 'package:mama_k_app_admin/Screens/app.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}
