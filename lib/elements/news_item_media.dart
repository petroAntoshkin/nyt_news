import 'package:flutter/material.dart';
import 'package:network_to_file_image/network_to_file_image.dart';
import 'package:nyt_news/models/multimedia_model.dart';
import 'package:nyt_news/provider/news_provider.dart';
import 'package:provider/provider.dart';

class NewsItemMedia extends StatelessWidget {
  NewsItemMedia({@required this.multimedia});

  final Map<String, MultimediaModel> multimedia;

  @override
  Widget build(BuildContext context) {
    final MultimediaModel _mModel = multimedia['thumbLarge'] != null
        ? multimedia['thumbLarge']
        : multimedia[0];
    bool _fileCashed =
        Provider.of<NewsProvider>(context).isFileExist(_mModel.url);
    final bool _haveAnInternet =
        Provider.of<NewsProvider>(context).internetConnection;
    return Container(
      child: _fileCashed
          ? Stack(
              children: [
                Image.file(Provider.of<NewsProvider>(context, listen: false)
                    .getCashFileFromUrl(_mModel.url)),
                Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.check,
                      color: Colors.green,
                      size: 12.0,
                    )),
              ],
            )
          : _haveAnInternet
              ? Image(
                  fit: BoxFit.cover,
                  image: NetworkToFileImage(
                      url: _mModel.url,
                      file: Provider.of<NewsProvider>(context, listen: false)
                          .getCashFileFromUrl(_mModel.url),
                      debug: false),
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: LinearProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes
                            : null,
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(
                    'No internet connection',
                    textAlign: TextAlign.center,
                  ),
                ),
    );
  }
}
