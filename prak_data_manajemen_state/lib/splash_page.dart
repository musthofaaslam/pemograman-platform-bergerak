import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';
import 'home_page.dart';

class SplashPage extends StatefulWidget{
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State{

  @override
  void initState(){
    super.initState();
    checkLogin();
  }

  void checkLogin() async{

    final prefs = await SharedPreferences.getInstance();

    bool? isLogin = prefs.getBool('isLogin');

    await Future.delayed(Duration(seconds:2));

    if(isLogin == true){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    }else{
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Text("Splash Screen", style: TextStyle(fontSize:24)),
      ),
    );
  }
}