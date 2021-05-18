import 'package:flutter/material.dart';
import 'dart:io';

class CashManager {
  final String cashFolderString;
  Directory _cashFolder;
  List<FileSystemEntity> _cashedFiles;
  CashManager({@required this.cashFolderString}){
    _cashFolder = Directory(this.cashFolderString);
    _cashFolder.create();
    _getCashFiles();
  }

  void _getCashFiles() {
    _cashedFiles = [];
    _cashedFiles = _cashFolder.listSync();
  }

  void clearCash() {
    _cashedFiles = [];
    List<FileSystemEntity> _list = _cashFolder.listSync();
    for (int i = 0; i < _list.length; i++) File(_list[i].path).delete();
  }

  bool isFileExist(String url) {
    bool _res = false;
    String _candidate = '${_cashFolder.path}${getFileNameFromUrl(url)}';
    for(int i = 0; i < _cashedFiles.length; i++){
      if(_candidate == _cashedFiles[i].path){
        _res = true;
        return _res;
        break;
      }
    }
    return _res;
  }

  void cashStringData(String contents){
    File _dataFile = File('${_cashFolder.path}/cashed.json');
    _dataFile.writeAsString(contents);
  }

  Future<String> getCashedJson() async{
    String _res = '';
    File _jsonFile = File('${_cashFolder.path}/cashed.json');
    if(await _jsonFile.exists())
      _res = await _jsonFile.readAsString();
    return _res;
  }

  String getFileNameFromUrl(String url) => url.split('/').last;

  String getFilePathFromUrl(String url) => '${_cashFolder.path}/${getFileNameFromUrl(url)}';

  int get cashedFilesCount => _cashFolder.listSync().length;

}
