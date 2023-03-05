import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_readonlinejson/online_data.dart';
import 'package:provider_readonlinejson/stories_page.dart';

 void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => OnlineData(),
        builder: (context, child) {
          return StoriesPage();
        },
      ),
    );
  }
}