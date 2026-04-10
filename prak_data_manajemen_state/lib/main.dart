import 'package:flutter/material.dart';
import 'splash_page.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title:'Flutter Login Example',
      home: SplashPage(),
    );
  }
}