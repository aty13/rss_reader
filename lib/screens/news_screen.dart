import 'package:flutter/material.dart';
import 'package:rssreader/services/api_service.dart';

import 'package:rssreader/widgets/widgets.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    ApiService().parseRSS();
    //parseRSS();
    super.initState();
  }

  void _showAction(BuildContext context, int index) {
    const actionTitles = ['Create Post', 'Upload Photo', 'Upload Video'];
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(actionTitles[index]),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RSS Feed'),
        actions: [
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.change_circle),
          )
        ],
      ),
      body: StreamBuilder(
        stream: ApiService().parseRSS().asStream(),
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
      floatingActionButton: ExpandableFAB(
        distance: 112.0,
        children: [
          ActionButton(
            onPressed: () => _showAction(context, 0),
            icon: const Icon(Icons.format_size),
          ),
          ActionButton(
            onPressed: () => _showAction(context, 1),
            icon: const Icon(Icons.insert_photo),
          ),
          ActionButton(
            onPressed: () => _showAction(context, 2),
            icon: const Icon(Icons.videocam),
          ),
        ],
      ),
    );
  }
}
