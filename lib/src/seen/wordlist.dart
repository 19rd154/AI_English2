import 'package:flutter/material.dart';

class WordContainer extends StatelessWidget {
  const WordContainer({Key? key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return Padding(
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
  );
  }
}