import 'package:flutter/material.dart';
import 'wordlist.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';

  //文字読み上げ機能
  FlutterTts flutterTts = FlutterTts();
  
  Future<void> _speak(String _speakText) async {
    await flutterTts.setLanguage("English");
    await flutterTts.setSpeechRate(1.0);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(_speakText);
  }

  Future<void> _stop() async {
    await flutterTts.stop();
  }

SpeechToText speechToText = SpeechToText();
var isListening = false;

class TalkScreen extends StatefulWidget {
  const TalkScreen({Key? key}) : super(key: key);

  @override
  State<TalkScreen> createState() => _TalkScreenState();
}

class _TalkScreenState extends State<TalkScreen> {
  String text = "音声を文字に変換します";
  bool isListening = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('AI会話'),
      ),
      body: Row(
        children: [
          Column(
            children: [
              // 単語一覧を表示
              Text('単語一覧'),
              Container(
                width: 150,
                height: 290,
                decoration: BoxDecoration(color: Colors.white),
                child: Scrollbar(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: 100, // 本当のアイテム数に置き換えてください
                    itemBuilder: (BuildContext context, int index) {
                      return WordContainer();
                    },
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: 450,
                    height: 200,
                    child: Image.network(
                      'https://www.water-phoenix.com/wp-content/uploads/2016/02/hyo8.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: 150,
                  height: 20,
                  child: Text('会話BOX'),
                ),
                // テキストを表示
                Text('$text'),
                TextButton(onPressed: ()async{await _speak(text);},
                 child: Text("読み上げ")),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // マイクボタンが押されたときに音声認識を開始
          Voiceget();

        },
        child: Icon(Icons.mic),
      ),
      
    );
  }

  Future<void> Voiceget() async {
    if (!isListening) {
      var available = await speechToText.initialize();
      if (available) {
        setState(() {
          isListening = true;
        });
        // 音声認識を開始し、認識結果をテキストに表示
        speechToText.listen(
          onResult: (result) {
            setState(() {
              text = result.recognizedWords;
              print('ここだよ$text');
            });
          },
          localeId: 'English', // 日本語の設定
        );
      }
    } else {
      await Future.delayed(Duration(seconds: 5));
      setState(() {
        isListening = false;
      });
      // 音声認識を停止
      speechToText.stop();
    }
  }
}