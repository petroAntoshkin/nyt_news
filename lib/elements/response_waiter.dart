import 'package:flutter/material.dart';
import 'package:nyt_news/provider/news_provider.dart';
import 'package:provider/provider.dart';

class ResponseWatcher extends StatefulWidget {
  @override
  _ResponseWatcherState createState() => _ResponseWatcherState();
}

class _ResponseWatcherState extends State<ResponseWatcher> {
  @override
  Widget build(BuildContext context) {
    final String _error = Provider.of<NewsProvider>(context).error;
    final bool _haveInternet = Provider.of<NewsProvider>(context).internetConnection;
    return Container(
      child: _error.isEmpty || _haveInternet ? CircularProgressIndicator()
      : Text(_error),
    );
  }
}
