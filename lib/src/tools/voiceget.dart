
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

const BG_COLOR = Color(0xff2C2C2C);
const TEXT_COLOR = Color(0xffFEFDFC);

class VoiceGet extends StatefulWidget {
  String gettext;
  VoiceGet({super.key, required this.gettext});

  @override
  State<VoiceGet> createState() => _VoiceGetState();
}

class _VoiceGetState extends State<VoiceGet> {
  SpeechToText speechToText = SpeechToText();
  var text = "音声を文字に変換します";
  var isListening = false;

  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
        endRadius: 75.0,
        animate: isListening,
        duration: const Duration(milliseconds: 2000),
        glowColor: BG_COLOR,
        repeatPauseDuration: const Duration(milliseconds: 100),
        showTwoGlows: true,
        child: GestureDetector(
          onTapDown: (details) async {
            if (!isListening) {
              var available = await speechToText.initialize();
              if (available) {
                setState(() {
                  isListening = true;
                  speechToText.listen(
                    onResult: (result) {
                      setState(() {
                        text = result.recognizedWords;
                        print('kokodayo$text');
                        widget.gettext=text;
                      });
                    },
                    localeId: 'ja_JP',// 日本語の設定
                  );
                });
              }
            }
          },
          onTapUp: (details) {
            setState(() {
              isListening = false;
            });
            speechToText.stop();
          },
          child: CircleAvatar(
            backgroundColor: BG_COLOR,
            radius: 35,
            child: Icon(
              isListening ? Icons.mic : Icons.mic_none,
              color: Colors.white,
            ),
          ),
        ),
      );
  }
}