class MultimediaModel {
  String url;
  String format;
  String type;
  String caption;
  String copyright;

  MultimediaModel({
    this.url,
    this.format,
    this.type,
    this.caption,
    this.copyright
  });

  void parseMultimediaJson(var contents){
    this.url = contents['url'];
    this.format = contents['format'];
    this.type = contents['type'];
    this.caption = contents['caption'];
    this.copyright = contents['copyright'];
  }
}
