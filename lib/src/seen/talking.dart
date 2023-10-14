import 'package:flutter/material.dart';
import 'package:flutter_application_2/src/app.dart';
import 'package:flutter_application_2/src/seen/DataClass/ConversationData.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'wordlist.dart';
import 'DataClass/WordListData.dart';
import 'DataClass/UrlBase.dart';

import 'package:flutter_unity_widget/flutter_unity_widget.dart';

//文字読み上げ機能
FlutterTts flutterTts = FlutterTts();

Future<void> _speak(String _speakText) async {
  await flutterTts.setLanguage("English");
  await flutterTts.setSpeechRate(0.5);
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
  TalkScreen(
      {Key? key,
      required this.username,
      required this.password,
      required this.userid})
      : super(key: key);
  final String? username;
  final String? password;
  int userid;
  @override
  State<TalkScreen> createState() => _TalkScreenState();
}

class _TalkScreenState extends State<TalkScreen> {
  String text = "";
  bool isListening = false;
  List<WordListData> wordList = [];
  int flag = 0;
  bool isDisabled = false;
  int sessionflag = 0;
  int session_time = -1;
  int count = 0;

  UnityWidgetController? _unityWidgetController;

  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      body: Stack(
        children: <Widget>[
          UnityWidget(
            onUnityCreated: onUnityCreated,
            onUnityMessage: onUnityMessage,
            onUnitySceneLoaded: onUnitySceneLoaded,
            fullscreen: false,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: Container(
                  width: 550,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xFFC51162).withOpacity(0.5), // 背景色を指定
                    borderRadius: BorderRadius.circular(8.0), // 角を丸くする半径を指定
                    border: Border.all(
                      color: Colors.pink, // ボーダーの色を設定
                      width: 1.0, // ボーダーの幅を設定
                    ),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft, // テキストを右寄せに配置
                        child: flag == 0 ? Text('あなた') : Text('桃瀬ひより'),
                      ),
                      SizedBox(
                        height: 5,
                        width: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('$text',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: const TextStyle(
                              fontSize: 15,
                              fontFamily: 'Klee_One',
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: isDisabled
            ? null
            : () async {
                // マイクボタンが押されたときに音声認識を開始
                flag = 0;
                isDisabled = true;
                Voiceget();
                if (sessionflag == 0) {
                  sessionflag = 1;
                  int session_time =
                      await sessiontime_get_Http(widget.username);
                  print("session_time:$session_time");
                }
                await Future.delayed(Duration(seconds: 5));
                String result = await _post_request(text, session_time, count);
                count++;
                setState(() {
                  text = result;
                });
                flag = 1;
                _speak(text);

                final getlist = await WordList_get_Http('1');
                setState(() => wordList = getlist);
                isDisabled = false;
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
              print('ここだよ:$text');
            });
          },
          localeId: 'English', // 日本語の設定
        );
      }
    } else {
      setState(() {
        isListening = false;
      });
      // 音声認識を停止
      speechToText.stop();
    }
  }

  Future<int> sessiontime_get_Http(String? username) async {
    HttpURL _search = HttpURL();
    var url;

    url = Uri.http('${_search.hostname}', 'api/users/session/$username');
    print(url);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      String responseBody = utf8.decode(response.bodyBytes);
      print('Number of books about http: $responseBody.');
      dynamic responseData = jsonDecode(responseBody);
      print("kore${responseData['session_times']}");
      SessionData result = SessionData(
        times: responseData['session_times'],
      );

      return result.times;
    }

    // エラー時や値が存在しない場合にはデフォルト値を返すことができます
    return -1; // または他の適切なデフォルト値を返す
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
      setState(() {
        status = response.statusCode;
        print(status);
      });

      return wordlistdataList;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      status = response.statusCode;
      return [];
    }
  }

  Future<String> _post_request(
      String text, int session_times, int count) async {
    HttpURL poster = HttpURL();
    Uri url = Uri.parse('http://${poster.hostname}/api/conversations');
    Map<String, String> headers = {'content-type': 'application/json'};
    String body = json.encode({
      'userid': 1,
      'context': '$text',
      'conversation_times': count,
      'session_times': session_times,
    });

    http.Response response = await http.post(url, headers: headers, body: body);
    if (response.statusCode != 200) {
      setState(() {
        int statusCode = response.statusCode;
        print("Failed to post $statusCode");
      });
      return '';
    }

    String responseBody = utf8.decode(response.bodyBytes);
    print('Number of books about http: $responseBody.');
    dynamic responseData = jsonDecode(responseBody);

    ConversationData conversationData = ConversationData(
      context: responseData['response'],
    );

    return conversationData.context;
  }

  // Live2D関係

  bool _isTalking = false;
  // Communcation from Flutter to Unity
  void changeStatus(String isTalking) {
    _unityWidgetController?.postMessage(
      'Avator',
      'ChangeStatus',
      isTalking,
    );
  }

  // Communication from Unity to Flutter
  void onUnityMessage(message) {
    print('Received message from unity: ${message.toString()}');
  }

  // Callback that connects the created controller to the unity controller
  void onUnityCreated(controller) {
    _unityWidgetController = controller;
  }

  // Communication from Unity when new scene is loaded to Flutter
  void onUnitySceneLoaded(SceneLoaded? sceneInfo) {
    // sceneInfo is null when the scene is unloaded
    if (sceneInfo == null) {
      print('シーンが見つかりませんでした。');
    } else {
      print('${sceneInfo.name}シーンが読み込まれました。');
    }
  }
}
