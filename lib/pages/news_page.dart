import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nyt_news/elements/connection_indicator.dart';
import 'package:nyt_news/elements/news_item_card.dart';
import 'package:nyt_news/elements/response_waiter.dart';
import 'package:nyt_news/models/news_model.dart';
import 'package:nyt_news/provider/news_provider.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<NewsModel> _allNews = Provider.of<NewsProvider>(context).allNews;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ConnectionIndicator(),
            SvgPicture.asset('assets/nyt_name.svg'),
            ConnectionIndicator(),
          ],
        ),
      ),
      body: _allNews.isEmpty
          ? Center(child: ResponseWatcher())
          : ListView.builder(
              itemCount: _allNews.length + 1,
              itemBuilder: (BuildContext context, int index) =>
                  NewsItemCard(index: index),
            ),
    );
  }
}
