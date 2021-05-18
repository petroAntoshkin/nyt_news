import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:nyt_news/managers/casher.dart';
import 'package:nyt_news/models/news_model.dart';
import 'package:path_provider/path_provider.dart';

part 'news_parser.dart';

class NewsProvider extends ChangeNotifier {
  Directory _appDirectory;
  bool _haveAnInternet = true;
  List<NewsModel> _allNews;
  String _errorText = '';
  CashManager _cashManager;
  //https://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=keAwgenFgj1sDw5u4Ed0fnIfKjkHGOWk
  final Uri _newssUrl = Uri.https(
      'api.nytimes.com',
      '/svc/topstories/v2/science.json',
      {'api-key': 'keAwgenFgj1sDw5u4Ed0fnIfKjkHGOWk'});

  NewsProvider() {
    _checkConnection();
  }

  void _checkConnection() async {
    _initCashFolder();

    _haveAnInternet = false;
    try {
      _haveAnInternet = await InternetConnectionChecker().hasConnection;
    } on Exception {
      _haveAnInternet = false;
    }
    if(_haveAnInternet) _getNews();
    notifyListeners();
    InternetConnectionChecker().onStatusChange.listen(
          (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            _haveAnInternet = true;
            _getNews();
            break;
          case InternetConnectionStatus.disconnected:
            _haveAnInternet = false;
            if(_cashManager != null) _applyCashedInfo();
            break;
        }
        notifyListeners();
      },
    );
    // _applyCashedInfo();
    // _haveAnInternet = true;
    // var connectivityResult = await (Connectivity().checkConnectivity());
    // if (connectivityResult == ConnectivityResult.none) {
    //   _haveAnInternet = false;
    //   _applyCashedInfo();
    // } else {
    //   _getNews();
    // }
  }

  Future<void> _getNews() async {
    // deleteCashedImages();
    Response res;
    try {
      res = await get(_newssUrl);
    } catch (e) {
      print(e.toString());
    }

    if (res.statusCode == 200) {
      _allNews = [];
      _allNews = NewsParser().parseNews((res.body));
      _cashManager.cashStringData(res.body);
    } else {
      _errorText = res.reasonPhrase;
      // throw "Unable to retrieve posts.";
    }
    notifyListeners();
  }

  NewsModel getNewsByIndex(int index) => index>= _allNews.length ? null : _allNews[index];

  String get error => _errorText;

  bool get internetConnection => _haveAnInternet;


  void refresh(){
    _cashManager.clearCash();
    _allNews = [];
    notifyListeners();
    _getNews();
  }

  //-------------------------- cash section-------------------------------

  void _initCashFolder() async{
    _appDirectory = await getApplicationDocumentsDirectory();
    _cashManager = new CashManager(cashFolderString: '${_appDirectory.path}/cash/');
    _applyCashedInfo();
  }

  File getCashFileFromUrl(String url) => File(_cashManager.getFilePathFromUrl(url));

  void _applyCashedInfo() async {
    _errorText = '';
    _allNews = [];
    String _cashed = await _cashManager.getCashedJson();
    if(_cashed.isEmpty){
      _errorText = 'No cashed Info';
    }
    else _allNews = NewsParser().parseNews(_cashed);
    notifyListeners();
  }

  List<NewsModel> get allNews {
    List<NewsModel> _res = _allNews == null || _allNews.isEmpty
        ? []
        : List.generate(_allNews.length, (index) => _allNews[index]);
    return _res;
  }

  bool isFileExist(String url) => _cashManager.isFileExist(url);

}
