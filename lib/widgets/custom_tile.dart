import 'package:flutter/material.dart';
import 'package:rssreader/models/article.dart';

class CustomTile extends StatelessWidget {
  const CustomTile({
    Key? key,
    required this.article,
  }) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => print(article.url),
        child: Card(
            child: ListTile(
          title: Text('${article.title}'),
          subtitle: Text('${article.description}'),
          //leading: Text((1 + index).toString()),
        )),
      ),
    );
  }
}
