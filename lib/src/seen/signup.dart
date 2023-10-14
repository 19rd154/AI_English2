import 'package:flutter/material.dart';
import 'package:flutter_application_2/src/app.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'DataClass/UrlBase.dart';
// インスタンス
const storage = FlutterSecureStorage();
class signupPage extends StatefulWidget {
  const signupPage({Key? key,}) : super(key: key);
  @override
  State<signupPage> createState() => _signupPageState();
}

class _signupPageState extends State<signupPage> {
  final bool _isObscure = true;
  String _username = '';
  String _password = '';
  String _errorText = ''; // Add this line

  
  
void _nameget(String Username) {
    setState(() {
      _username = Username;
    });
  }
  void _passget(String Password) {
    setState(() {
      _password = Password;
      print(_password);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  enabled: true,
                  onFieldSubmitted: _nameget,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    hintText: 'ユーザ名を入力してください',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  obscureText: _isObscure,
                  enabled: true,
                  onFieldSubmitted: _passget,
                  maxLines: 1,
                  decoration: const InputDecoration(
                      hintText: 'パスワードを入力',),
                ),
              ),
              Center(
        child: ElevatedButton(
          onPressed: () async {
            if (_username.isNotEmpty && _password.isNotEmpty) {
              _errorText = ''; // Clear any previous error
              int userid = await UserID_get_Http(_username);
              String _userid = userid.toString();
              await storage.write(key: "username", value: _username);
              await storage.write(key: "password", value: _password);
              await storage.write(key: "userid", value: _userid);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen(username: _username,password: _password,userid: userid,)),
              );
            } else {
              setState(() {
                _errorText = 'ユーザ名とパスワードを入力してください';
              });
            }
          },
          child: const Text('サインアップ'),
        ),
      ),
            ],
          ),
        ),
      ),
    );
  }
  Future<int> UserID_get_Http(String username) async {
    HttpURL _search = HttpURL();
    int status;
    var url; 
    print('ここだよ:${_search.hostname}api/users/$username');
      url = Uri.http('${_search.hostname}', 'api/users/$username');
    

    var response = await http.get(url);
    if (response.statusCode == 200) {
  String responseBody = utf8.decode(response.bodyBytes);
  print('Number of books about http: $responseBody.');
  Map<String, dynamic> responseData = jsonDecode(responseBody);
if (responseData.isNotEmpty && responseData[0] is int) {
  int userid = responseData[0] as int;
  setState(() {
    status = response.statusCode;
    print(status);
    print("userid: $userid");
  });
      return userid;
    } else {
      print("Invalid response format");
    }
  } else {
    print('Request failed with status: ${response.statusCode}.');
    status = response.statusCode;
  }

  // エラーの場合、0を返す
  return 0;
    }
  
}