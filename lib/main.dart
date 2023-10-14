/*Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    // 画面の向きの決定(横向き)
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]).then((_) {
    runApp(const MyApp());
  });
}*/
import 'package:flutter/material.dart';
import 'src/app.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/services.dart';

// インスタンス
const storage = FlutterSecureStorage();


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final String Username= await storage.read(key: "username") ?? "";
  final String Password = await storage.read(key: "password") ?? "";
  final String? userid_obj = await storage.read(key: "userid");
  int userid = -1; // デフォルト値を -1 に設定

  if (userid_obj != null && userid_obj.isNotEmpty) {
    userid = int.tryParse(userid_obj) ?? -1;
  }
  print('ここだよ$Username');
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    // 画面の向きの決定(横向き)
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]).then((_) {
    runApp(MyApp(username: Username, password: Password,userid: userid,));
  });
  
 
}

