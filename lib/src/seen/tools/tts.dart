import 'package:flutter_tts/flutter_tts.dart';


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

