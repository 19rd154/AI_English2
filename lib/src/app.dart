import 'package:flutter/material.dart';
import 'package:flutter_application_2/src/seen/conversationlist.dart';
import 'package:flutter_application_2/src/seen/list.dart';
import 'package:flutter_application_2/src/seen/signout.dart';
import 'package:flutter_application_2/src/seen/signup.dart';
import 'package:flutter_application_2/src/seen/talking.dart';
import 'package:flutter_application_2/src/app.dart';
import 'package:flutter_application_2/src/seen/DataClass/ConversationData.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';



import 'seen/DataClass/WordListData.dart';
import 'seen/DataClass/UrlBase.dart';
import 'package:flutter/services.dart';


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



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key,required this.username,required this.password,required this.userid})
   : super(key: key);
    final String? username;
    final String? password;
    final int userid;
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>{  
  void didChangeDependencies() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.didChangeDependencies();
  }
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
                        builder: (context) => TalkScreen(username: widget.username,password: widget.password,userid: widget.userid,),
                        fullscreenDialog: true,
                      ));
                      }, 
                    style: TextButton.styleFrom(backgroundColor: Color(0xFFC51162 ), // 背景色を設定
                primary: Colors.white,) ,
                    child: Text('Conversation Start!',style: const TextStyle( // ← TextStyleを渡す.textのフォントや大きさの設定
                                fontSize: 18,)),))),  
                    
                    TextButton(
                      onPressed: () async{final getlist = await WordList_get_Http('1');
                      List<WordListData> WordList=[];
                      setState(() => WordList = getlist);
                      print(WordList);
                      Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context) => listScreen(username: widget.username,password: widget.password,userid: widget.userid,wordlist: WordList),
                        fullscreenDialog: true,
                      ));
                      }, 
                    style: TextButton.styleFrom(backgroundColor: Color(0xFFC51162 ), // 背景色を設定
                primary: Colors.white,) ,
                    child: Text('             word list             ',style: const TextStyle( // ← TextStyleを渡す.textのフォントや大きさの設定
                                fontSize: 18,)),),  
                    
                    
                    SizedBox(width: 500,height:100),
                    TextButton(
                      onPressed: () async{final getlist = await ConversationDataList_get_Http('${widget.userid}');
                      List<ConversationListData> ConversationList=[];
                      setState(() => ConversationList= getlist);
                      print(ConversationList);
                      Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context) => conversationlistScreen(username: widget.username,password: widget.password,userid: widget.userid,wordlist: ConversationList),
                        fullscreenDialog: true,
                      ));
                      }, 
                    style: TextButton.styleFrom(backgroundColor: Color(0xFFC51162 ), // 背景色を設定
                    primary: Colors.white,) ,
                    child: Text('             conversation list             ',style: const TextStyle( // ← TextStyleを渡す.textのフォントや大きさの設定
                                fontSize: 18,)),),  
                    
                    
                    SizedBox(width: 500,height:100),
                   
                     
                    
                      
                    
                  ],),
              ),
          ),
    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    floatingActionButton: FloatingActionButton.extended( // ここから
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => (LogoutScreen(username: widget.username,password: widget.password,)),
                              fullscreenDialog: true,
                            ),
                          );
                        },
                        icon: Icon(Icons.logout_outlined), label: Text('Logout'),
                      ),
                  );// ここまでを追加);
  }
  Future<List<WordListData>> WordList_get_Http(String userid) async {
    HttpURL _search = HttpURL();
    int status;
    var url; 
    print('ここだよ:${_search.hostname}api/userwords/$userid');
      url = Uri.http('${_search.hostname}', 'api/userwords/$userid');
    

    var response = await http.get(url);
    if (response.statusCode == 200) {
      String responseBody = utf8.decode(response.bodyBytes);
      print('Number of books about http: $responseBody.');
      List<dynamic> responseData = jsonDecode(responseBody);
      List<WordListData> wordlistdataList = [];
      for (var itemData in responseData) {
        WordListData wordListData = WordListData(
          words: itemData['word'],
        );
        wordlistdataList.add(wordListData);
      }
      
      
      return wordlistdataList;
    } else {
      print('Request failed with status: ${response.statusCode}.');status=response.statusCode;
      return [];
    }
  }

  Future<List<ConversationListData>> ConversationDataList_get_Http(String userid) async {
    HttpURL _search = HttpURL();
    int status;
    var url; 
    print('ここだよ:${_search.hostname}api/conversations/$userid');
      url = Uri.http('${_search.hostname}', 'api/conversations/$userid');
    

    var response = await http.get(url);
    if (response.statusCode == 200) {
      String responseBody = utf8.decode(response.bodyBytes);
      print('Number of books about http: $responseBody.');
      List<dynamic> responseData = jsonDecode(responseBody);
      List<ConversationListData> wordlistdataList=[];
      for (var itemData in responseData) {
        ConversationListData wordListData = ConversationListData(
          context: itemData['context'],
        );
        wordlistdataList.add(wordListData);
      }
      
      
      return wordlistdataList;
    } else {
      //print('Request failed with status: ${response.statusCode}.');status=response.statusCode;
      return [];
    }
  }
}
