import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';

class HomePage extends StatelessWidget{

  void logout(BuildContext context) async{

    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('isLogin');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginPage()),
    );

  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: (){
              logout(context);
            },
          )
        ],
      ),
      body: Center(
        child: Text("Selamat Datang", style: TextStyle(fontSize:24)),
      ),
    );

  }
}