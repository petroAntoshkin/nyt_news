import 'package:nyt_news/models/multimedia_model.dart';

class NewsModel {
  String section;
  String title;
  String abstract;
  String byline;
  String publishedDate;
  String shortUrl;
  Map<String, MultimediaModel> multimedia;

  NewsModel({
    this.section,
    this.title,
    this.abstract,
    this.byline,
    this.publishedDate,
    this.shortUrl,
    this.multimedia,
  });

  void parseNewsJson(var contents){
    this.section = contents['section'];
    this.title = contents['title'];
    this.abstract = contents['abstract'];
    this.byline = contents['byline'];
    this.publishedDate = contents['published_date'];
    this.multimedia = new Map();
    for(int i = 0; i < (contents['multimedia'] as List).length; i++){
      MultimediaModel _multi = MultimediaModel();
      _multi.parseMultimediaJson(contents['multimedia'][i]);
      // this.multimedia.add(_multi);
      this.multimedia.putIfAbsent(_multi.format, () => _multi);
    }
    this.shortUrl = contents['short_url'];
  }

}
