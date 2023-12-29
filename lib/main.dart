import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor_app_admin_panel/views/screens/main_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: kIsWeb || Platform.isAndroid?FirebaseOptions(
        apiKey: 'AIzaSyDIiDrWdZyp_gj0lFApCF2N5xzDjhUV470',
        appId: "1:761654940887:web:551645997505fe6825cc92",
        messagingSenderId: "761654940887",
        projectId: "my-personal-project-d4328",
      storageBucket: "my-personal-project-d4328.appspot.com",

    ):null
  );


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  MainScreen(),
    );
  }
}


