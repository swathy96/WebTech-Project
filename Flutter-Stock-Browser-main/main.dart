import 'package:flutter/material.dart';
import '../screens/homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Stock Browser',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.white, backgroundColor: Colors.black),
        home: HomeScreen(key: key));
  }
}
