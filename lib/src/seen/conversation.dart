import 'package:flutter/material.dart';
import 'package:flutter_application_2/src/seen/DataClass/WordListData.dart';
import 'package:flutter_application_2/src/seen/DataClass/WordMeaningData.dart';

import 'DataClass/UrlBase.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ConversationContainer extends StatefulWidget {
  final ConversationListData worddata;

  ConversationContainer({Key? key, required this.worddata}) : super(key: key);

  @override
  State<ConversationContainer> createState() => ConversationContainerState();
}

class ConversationContainerState extends State<ConversationContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(1),
        ),
        border: Border.all(
          color: Colors.black, // 枠線の色を設定
          width: 1, // 枠線の幅を設定
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${widget.worddata.context}',
            style: const TextStyle(fontSize: 15, fontFamily: 'Klee_One'),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}