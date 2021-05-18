import 'package:flutter/material.dart';
import 'package:nyt_news/provider/news_provider.dart';
import 'package:provider/provider.dart';

class ConnectionIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool _connected = Provider.of<NewsProvider>(context).internetConnection;
    return Center(
      child: Icon(
        Icons.signal_cellular_connected_no_internet_4_bar,
        color: _connected ? Color(0x00ffffff) : Colors.red,
      ),
    );
  }
}
