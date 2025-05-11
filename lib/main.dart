import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app_assesment/home_screen.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
