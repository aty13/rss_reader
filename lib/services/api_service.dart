import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';
import 'package:rssreader/models/article.dart';

class ApiService {
  Future parseRSS(String url) async {
    var response = await http.get(Uri.parse(url));
    var channel = RssFeed.parse(response.body);
    var items = channel.items;
    List<Article> articles =
        items!.map((item) => Article.fromRss(item)).toList();
    return articles;
  }
}
