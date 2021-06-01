import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'HomePage.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // final appDocumentDirectory =
  //     await pathProvider.getApplicationDocumentsDirectory();
  // Hive.init(appDocumentDirectory.path);
  // await Hive.openBox('bestScore');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
