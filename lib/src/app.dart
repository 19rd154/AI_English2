import 'package:flutter/material.dart';
import 'package:flutter_application_2/src/seen/talking.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}



class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,
        title: const Text('AI会話'),
         
        ),
      body:SingleChildScrollView(//スクロールを可能に！
        child:
              Center(
                child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),child:Container(width: 150,
                        height: 40,
                    child:TextButton(
                      onPressed: () {
                      Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context) => TalkScreen(),
                        fullscreenDialog: true,
                      ));
                      }, 
                    style: TextButton.styleFrom(backgroundColor: Color(0xFFC51162 ), // 背景色を設定
                primary: Colors.white,) ,
                    child: Text('対話開始',style: const TextStyle( // ← TextStyleを渡す.textのフォントや大きさの設定
                                fontSize: 18,)),))),  
                    
                    Text('単語確認'),
                    
                    
                    SizedBox(width: 500,height:100),
                   
                     
                    
                      
                    
                  ],),
              ),
          ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    floatingActionButton: FloatingActionButton( // ここから
                        onPressed: () {
                          /*Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReviewSend(),
                              fullscreenDialog: true,
                            ),
                          );*/
                        },
                        child: const Icon(Icons.add),
                      ),
                  );// ここまでを追加);
  }
  
}
