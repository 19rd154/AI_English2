import 'package:flutter/material.dart';
import 'package:flutter_application_2/src/seen/signout.dart';
import 'package:flutter_application_2/src/seen/signup.dart';
import 'package:flutter_application_2/src/seen/talking.dart';



class MyApp extends StatefulWidget {
  MyApp({Key? key,required this.username,required this.password,required this.userid})
   : super(key: key);
  final String? username;
  final String? password;
  int? userid; 
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: widget.username==""? 
      const signupPage():
      HomeScreen(username: widget.username,password: widget.password,userid: widget.userid!,),
    );
  }
}



class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key,required this.username,required this.password,required this.userid})
   : super(key: key);
    final String? username;
    final String? password;
    final int userid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,
        title: const Text('Bocchi the Talk!'),
        backgroundColor: Colors.black,
         
        ),
      body:SingleChildScrollView(//スクロールを可能に！
        child:
              Center(
                child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),child:Container(width: 200,
                        height: 40,
                    child:TextButton(
                      onPressed: () {
                      Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context) => TalkScreen(username: username,password: password,userid: userid,),
                        fullscreenDialog: true,
                      ));
                      }, 
                    style: TextButton.styleFrom(backgroundColor: Color(0xFFC51162 ), // 背景色を設定
                primary: Colors.white,) ,
                    child: Text('Conversation Start!',style: const TextStyle( // ← TextStyleを渡す.textのフォントや大きさの設定
                                fontSize: 18,)),))),  
                    
                    Text('Word List'),
                    
                    
                    SizedBox(width: 500,height:100),
                   
                     
                    
                      
                    
                  ],),
              ),
          ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    floatingActionButton: FloatingActionButton.extended( // ここから
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => (LogoutScreen(username: username,password: password,)),
                              fullscreenDialog: true,
                            ),
                          );
                        },
                        icon: Icon(Icons.logout_outlined), label: Text('Logout'),
                      ),
                  );// ここまでを追加);
  }
  
}
