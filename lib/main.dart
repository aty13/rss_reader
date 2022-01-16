import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/io_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RSS Reader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future parseRSS() async {
    final client = IOClient(HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true));

    // RSS feed
    var response =
        await client.get(Uri.parse('https://www.liga.net/news/world/rss.xml'));
    var channel = RssFeed.parse(response.body);
    var item = channel.items;
    print(channel);

    client.close();
    return item;
  }

  @override
  void initState() {
    parseRSS();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RSS Feed'),
      ),
      body: StreamBuilder(
        stream: parseRSS().asStream(),
        builder: <AsyncSnapshot>(context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                      child: ListTile(
                    title: Text(snapshot.data[index].title),
                    subtitle: Text(snapshot.data[index].description),
                    leading: Text((1 + index).toString()),
                  )),
                );
              },
            );
          } else if (snapshot.hasError ||
              snapshot.connectionState == ConnectionState.none) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: parseRSS,
        tooltip: 'Increment',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
