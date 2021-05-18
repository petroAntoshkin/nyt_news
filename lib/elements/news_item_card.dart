import 'package:flutter/material.dart';
import 'package:nyt_news/elements/news_item_media.dart';
import 'package:nyt_news/models/news_model.dart';
import 'package:nyt_news/provider/news_provider.dart';
import 'package:nyt_news/styles_and_presets.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsItemCard extends StatelessWidget {
  NewsItemCard({@required this.index});

  final int index;

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    final _maxWid = MediaQuery.of(context).size.width * 0.95;
    final _divider = 2.8;
    final NewsModel oneNewItem =
        Provider.of<NewsProvider>(context).getNewsByIndex(index);
    final String _copyright = oneNewItem == null
        ? ''
        : oneNewItem.multimedia['thumbLarge'] != null
            ? oneNewItem.multimedia['thumbLarge'].copyright
            : oneNewItem.multimedia[0].copyright;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: oneNewItem == null
          ? ElevatedButton(
              onPressed: () =>
                  Provider.of<NewsProvider>(context, listen: false).refresh(),
              child: Row(
                children: [
                  Icon(Icons.refresh),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('Clear cash and reload'),
                  ),
                ],
              ),
            )
          : Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4), //color of shadow
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0.5, 1),
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                    0.6,
                    0.68,
                    0.695,
                    0.7,
                    0.71,
                  ],
                  colors: [
                    Color(0xffffb08b),
                    Color(0xffe48c68),
                    Color(0xff94664d),
                    Color(0xff4e1c04),
                    Color(0xffffcdb0),
                  ],
                  transform: GradientRotation(0.2),
                ),
              ),
              child: GestureDetector(
                onTap: () => _launchURL(oneNewItem.shortUrl),
                child: Container(
                  color: Color(0x00ff0000),
                  child: SizedBox(
                    width: _maxWid,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            oneNewItem.title,
                            style: Presets.newsTitleStyle,
                          ),
                          SizedBox(height: 6.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: _maxWid / _divider,
                                height: _maxWid / _divider,
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        oneNewItem.byline,
                                        style: Presets.newsAuthorStyle,
                                      ),
                                      Text(
                                        _copyright.isEmpty
                                            ? ''
                                            : '© $_copyright',
                                        style: Presets.newsMediaCopyrightStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: _maxWid / _divider,
                                height: _maxWid / _divider,
                                child: oneNewItem.multimedia != null
                                    ? NewsItemMedia(
                                        multimedia: oneNewItem.multimedia)
                                    : Container(),
                              ),
                              // NewsItemMedia(multimedia: oneNewItem.multimedia),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
