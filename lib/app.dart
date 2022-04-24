import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssreader/screens/news_screen.dart';
import 'package:rssreader/providers/source_provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: NewsSources(),
      child: MaterialApp(
        title: 'RSS Reader',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const NewsScreen(),
      ),
    );
  }
}
