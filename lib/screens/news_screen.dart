import 'package:flutter/material.dart';
import 'package:rssreader/services/api_service.dart';
import 'package:provider/provider.dart';

import 'package:rssreader/widgets/widgets.dart';
import 'package:rssreader/models/article.dart';
import 'package:rssreader/providers/source_provider.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  // @override
  // void initState() {
  //   ApiService().parseRSS();
  //   super.initState();
  // }

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
    final sourcesProvider = Provider.of<NewsSources>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('RSS Feed'),
        actions: [
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.change_circle),
          ),
        ],
      ),
      body: FutureBuilder(
        future: ApiService().parseRSS(
            sourcesProvider.sources[sourcesProvider.currentSource].url),
        builder: <AsyncSnapshot>(context, snapshot) {
          if (snapshot.hasData) {
            List<Article> articles = snapshot.data;

            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, int index) {
                return CustomTile(article: articles[index]);
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
      drawer: AppDrawer(),
    );
  }
}
