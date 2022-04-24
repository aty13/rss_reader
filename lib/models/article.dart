import 'package:webfeed/webfeed.dart';

class Article {
  String? title;
  String? description;
  String? url;

  Article({
    required this.title,
    this.description,
    this.url,
  });

  factory Article.fromRss(RssItem list) {
    return Article(
      title: list.title,
      description: list.description,
      url: list.link,
    );
  }
}
