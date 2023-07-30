import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notesapp/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //used to change the color of the status bar
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do List',
      home:Home(),
    );
  }
}
