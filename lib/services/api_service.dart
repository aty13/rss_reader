import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;

class ApiService {
  String _url = 'https://rss.dw.com/xml/rss-ru-all';
//
//https://www.liga.net/news/world/rss.xml
  Future parseRSS() async {
    var response = await http.get(Uri.parse(_url));
    var channel = RssFeed.parse(response.body);

    var item = channel.items;
    print(item![0].description);
    
    return item;
  }
}
