import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rssreader/widgets/source_tile.dart';

import 'package:rssreader/providers/source_provider.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    NewsSources sourcesProvider = Provider.of(context, listen: false);
    return Container(
      margin: const EdgeInsets.all(50),
      //padding: EdgeInsets.all(100),
      color: Colors.grey.shade500,
      child: ListView.builder(
        itemCount: sourcesProvider.sources.length,
        itemBuilder: (context, index) => SourceTile(
          source: sourcesProvider.sources[index],
          callback: () => sourcesProvider.changeSource(index),
        ),
      ),
    );
  }
}
