import 'package:flutter/material.dart';
import 'package:rssreader/models/source.dart';

class NewsSources with ChangeNotifier {
  List<Source> sources = [
    Source(name: 'DW', url: 'https://rss.dw.com/xml/rss-ru-all'),
    Source(name: 'Liga', url: 'https://www.liga.net/news/world/rss.xml')
  ];

  int currentSource = 0;

  void addSource(Source source) {
    sources.add(source);
  }

  void changeSource(int value) {
    currentSource = value;
    notifyListeners();
  }
}
