part of 'news_provider.dart';

class NewsParser{
  List<NewsModel> parseNews(String body){
    List<NewsModel> _res = [];
    int _len = json.decode(body)['num_results'];
    for(int i = 0; i < _len; i++){
      NewsModel _model = NewsModel();
      _model.parseNewsJson(json.decode(body)['results'][i]);
      _res.add(_model);
    }
    return _res;
  }
}