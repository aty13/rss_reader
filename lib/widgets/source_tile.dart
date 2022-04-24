import 'package:flutter/material.dart';
import 'package:rssreader/models/source.dart';

class SourceTile extends StatelessWidget {
  const SourceTile({Key? key, required this.source, required this.callback})
      : super(key: key);

  final Source source;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: callback.call(),
        child: Card(
            child: ListTile(
          title: Text(source.name),
          subtitle: Text(source.url),
        )),
      ),
    );
  }
}
