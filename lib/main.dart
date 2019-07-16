import 'package:flutter/material.dart';

import 'screens/home.dart';


void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(

      //Here below code we'll remove debug icon from top right corner
      debugShowCheckedModeBanner: false,


      title: 'uber clone',

      theme: ThemeData(

        primarySwatch: Colors.pink,

      ),

      home: MyHomePage(title:'Uber clone'),
      
    );
  }
}





