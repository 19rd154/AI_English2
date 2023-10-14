import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'signup.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/services.dart';

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({Key? key, required this.username, required this.password})
      : super(key: key);
  final String? username;
  final String? password;

  @override
  _Logoutscreenstate createState() => _Logoutscreenstate();
}

class _Logoutscreenstate extends State<LogoutScreen> {
  

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        
        title: const Text('Bocchi the Talk!'),
        backgroundColor: Colors.black,
      ),body: Center(
        child: Column(mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: ElevatedButton(style: ElevatedButton.styleFrom(primary: Color(0xFFC51162 )),
                onPressed:  () async{
                  try{
                    await storage.delete(key: "username");
                    await storage.delete(key: "password");
                  }catch (e) {
                    // Handle any errors that might occur during deletion
                    print("Error deleting data: $e");
                  }
                  print("success");
                  Navigator.push(context, MaterialPageRoute(builder: (context) => signupPage()));
                },
                child: Text('logout'),
              ),
            ),
          ],
        ),
      ),
    );

  }
}