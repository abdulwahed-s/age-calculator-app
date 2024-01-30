// ignore_for_file: prefer_const_constructors

import 'package:age/age.dart';
import 'package:age/hijri.dart';
import 'package:age/milad.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Milad()
      , 
      routes: {
        "milad" : (context) => Milad()
        ,"hijry" : (context) => Hijry()
        ,"ageh" :(context) => Hell()
      },
    );
  }
}
