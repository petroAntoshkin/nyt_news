import 'package:flutter/material.dart';
import 'package:nyt_news/pages/news_page.dart';
import 'package:nyt_news/provider/news_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewsProvider(),
      child: Consumer<NewsProvider>(
          builder: (context, NewsProvider notifier, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: NewsPage(),
            );
          }),
    );
  }
}

