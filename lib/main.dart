import 'package:flutter/material.dart';
import 'package:posprintertest/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PosPrinterTest',
      home: Home(),
    );
  }
}
