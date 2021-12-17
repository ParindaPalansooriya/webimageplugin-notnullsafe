import 'package:flutter/material.dart';
import 'package:webimageplugin/image_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: WebImage("https://images.pexels.com/photos/163016/crash-test-collision-60-km-h-distraction-163016.jpeg"),
        ),
      ),
    );
  }
}
