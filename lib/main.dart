import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';
//import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;

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
  final _urlController = TextEditingController();
  String _url = 'https://rss.dw.com/xml/rss-ru-all';
//
//https://www.liga.net/news/world/rss.xml
  Future parseRSS() async {
    // final client = IOClient(HttpClient()
    //   ..badCertificateCallback =
    //       ((X509Certificate cert, String host, int port) => true));
    // // RSS feed
    var response = await http.get(Uri.parse(_url));
    var channel = RssFeed.parse(response.body);
    var item = channel.items;
    // client.close();
    return item;
  }

  void changeURL() {
    setState(() {
      _url = _urlController.text;
    });
    parseRSS();
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('Enter a valid URL'),
                TextField(
                  controller: _urlController,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                changeURL();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
          title: const Text('RSS Feed'),
          actions: [
            const Spacer(),
            IconButton(
                onPressed: _showMyDialog, icon: Icon(Icons.change_circle))
          ],
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              parseRSS();
            });
          },
          tooltip: 'Change',
          child: const Icon(
            Icons.change_circle,
          ),
        ));
  }
}
