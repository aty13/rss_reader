import 'package:flutter/material.dart';
import 'package:rssreader/screens/news_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RSS Reader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NewsScreen(),
    );
  }
}
