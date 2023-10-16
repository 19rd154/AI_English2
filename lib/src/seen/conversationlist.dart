import 'package:flutter/material.dart';
import 'package:flutter_application_2/src/app.dart';
import 'package:flutter_application_2/src/seen/DataClass/ConversationData.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


import 'conversation.dart';
import 'wordlist.dart';
import 'DataClass/WordListData.dart';
import 'DataClass/UrlBase.dart';
import 'package:flutter/services.dart';


class conversationlistScreen extends StatefulWidget {
  conversationlistScreen({Key? key,required this.username,required this.password,required this.userid,required this.wordlist})
   : super(key: key);
  final String? username;
  final String? password;
  final List<ConversationListData>? wordlist;
  final int userid;
  @override
  State<conversationlistScreen> createState() => conversationlistScreenState();
}

class conversationlistScreenState extends State<conversationlistScreen> {
  String text = "";
  bool isListening = false;
  int flag = 0;
  bool isDisabled = false;
  int sessionflag=0;
  int session_time=-1;
  int count=0;
    void didChangeDependencies() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.didChangeDependencies();
  }

        

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: 
          Center(
            child: Column(
              children: [
                SizedBox(height: 40,width: 1,),
                // 単語一覧を表示
                Text('会話履歴'),
                Container(
                  width: 400,
                  height: 600,
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.5)),
                  child: Scrollbar(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: widget.wordlist?.length, // 本当のアイテム数に置き換えてください
                      itemBuilder: (BuildContext context, int index) {
                        return  ConversationContainer(worddata: widget.wordlist![index]);
                      },
                    ),
                  ),
                ),ElevatedButton(onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => (HomeScreen(username: widget.username,password: widget.password,userid: widget.userid,)),
                      fullscreenDialog: true,
                    ),
                  );
                },child: Text('Back')),
              ],),
          ));

  }



  
    
  }