import 'package:flutter/material.dart';
import 'package:flutter_application_2/src/seen/DataClass/WordMeaningData.dart';

import 'DataClass/UrlBase.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WordContainer extends StatefulWidget {
  const WordContainer({Key? key}) : super(key: key);


  @override
  State<WordContainer> createState() => WordContainerState();
}
  class WordContainerState extends State<WordContainer>{
  late WordMeaningData wordmean;

   @override
  Widget build(BuildContext context) {
    return InkWell(
          onTap: () async{final result = await WordMean_get_Http();
                    setState(() => wordmean = result as WordMeaningData);

            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('${wordmean.word}:${wordmean.mean}'),
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
  Future<Object> WordMean_get_Http() async {
    HttpURL _search = HttpURL();
    var url = Uri.http('${_search.hostname}', 'api/words/happy');
    
    var response = await http.get(url);
    if (response.statusCode == 200) {
      String responseBody = utf8.decode(response.bodyBytes);
      print('Number of books about http: $responseBody.');
      
      
      dynamic responseData = jsonDecode(responseBody);

      
        
          WordMeaningData wordMeaningData = WordMeaningData(
            id: responseData['id'],
            word: responseData['word'],
            mean: responseData['mean'],
          );
          
        
      
    

      return wordMeaningData;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return [];
    }
  }
}
