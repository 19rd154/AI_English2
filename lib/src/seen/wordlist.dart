import 'package:flutter/material.dart';
import 'package:flutter_application_2/src/seen/DataClass/WordMeaningData.dart';

import 'DataClass/UrlBase.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WordContainer extends StatelessWidget {
  const WordContainer({Key? key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Aの動作の確認'),
                  );
                });
          },
          child:Padding(
          padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        child: Container(
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
          child: Text('a'),
        )
      )
    );
  }
      Future<List<Object>> WordList_get_Http(int userid,String value) async {
    HttpURL _search = HttpURL();
    int status;
    var url; 
    if (value == 'api/words/word') {
        url = Uri.http('${_search.hostname}', '${value}');
      } else if (value == 'api/userwords') {
        url = Uri.http('${_search.hostname}', '${value}',{'userid':userid},);
      }
    
    var response = await http.get(url);
    if (response.statusCode == 200) {
      String responseBody = utf8.decode(response.bodyBytes);
      print('Number of books about http: $responseBody.');
      List<dynamic> responseData = jsonDecode(responseBody);
      List<WordMeaningData> wordmeaningdataList = [];
      for (var itemData in responseData) {
        WordMeaningData wordMeaningData = WordMeaningData(
          id: itemData['id'],
          word: itemData['word'],
          mean: itemData['mean'],
        );
        wordmeaningdataList.add(wordMeaningData);
      }
      
      
      
      return wordmeaningdataList;
    } else {
      print('Request failed with status: ${response.statusCode}.');status=response.statusCode;
      return [];
    }
  }
}
