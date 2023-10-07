import 'package:flutter/material.dart';
import 'wordlist.dart';

class TalkScreen extends StatelessWidget {
  const TalkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,
        title: const Text('AI会話'),
         
        ),
      body:Row(
        children:[
          Column(
            children: [Text('単語一覧'),
              Container(width: 150,
              height: 290,
              decoration: BoxDecoration(color: Colors.white),
              child: 
                  Scrollbar(
                  child:ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: 100,//List(List名).length
                  itemBuilder: (BuildContext context, int index) {
                    return WordContainer();
                  }
    ),)
  ),
            ],
          ),
          Column(
            children: [
              Center(
                child:Container(width: 450,
                  height: 200,
                  
                  child: Image.network('https://www.water-phoenix.com/wp-content/uploads/2016/02/hyo8.png',
                    fit: BoxFit.cover,)
                )
              ),
              Container(width: 150,
              height: 40,
              child: Text('会話BOX'),),
            ],
          ),
        ]
      ),
    );
    }
}
