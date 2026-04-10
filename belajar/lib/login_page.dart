import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State{

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() async{

    String username = usernameController.text;
    String password = passwordController.text;

    if(username == "admin" && password == "123"){

      final prefs = await SharedPreferences.getInstance();

      await prefs.setBool('isLogin', true);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomePage()),
      );

    }else{

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Username atau password salah")),
      );

    }

  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: "Username"),
            ),

            SizedBox(height:10),

            TextField(
              controller: passwordController,
              obscureText:true,
              decoration: InputDecoration(labelText: "Password"),
            ),

            SizedBox(height:20),

            ElevatedButton(
              onPressed: login,
              child: Text("Login"),
            )

          ],
        ),
      ),
    );
  }
}