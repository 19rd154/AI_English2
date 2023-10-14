import 'package:flutter/material.dart';
import 'package:flutter_application_2/src/seen/DataClass/WordListData.dart';
import 'package:flutter_application_2/src/seen/DataClass/WordMeaningData.dart';

import 'DataClass/UrlBase.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ConversationContainer extends StatefulWidget {
  ConversationListData worddata;
  ConversationContainer({Key? key,required this.worddata}) : super(key: key);


  @override
  State<ConversationContainer> createState() => ConversationContainerState();
}
class ConversationContainerState extends State<ConversationContainer>{
  late WordMeaningData wordmean;

   @override
  Widget build(BuildContext context) {
    return 
          
        Container(
          padding: const EdgeInsets.symmetric(
            // 内側の余白を指定
            horizontal: 20,
            vertical: 8,
          ),
          decoration: const BoxDecoration(
            color: Colors.white, // 背景色を指定
            borderRadius: BorderRadius.all(
              Radius.circular(32), // 角丸を設定
            ),
          ),
          child: Text('$context',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3, 
                            style: const TextStyle(fontSize: 15,fontFamily: 'Klee_One',)
                          ),
        );
  }
}