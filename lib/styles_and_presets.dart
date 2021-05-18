import 'package:flutter/material.dart';

class Presets{
  static const TEXT_SIZE_LARGE = 23.0;
  static const TEXT_SIZE_MIDDLE = 20.0;
  static const TEXT_SIZE_SMALL = 12.0;
  static const TEXT_SIZE_DEFAULT = 14.0;
  static final Color _textColorDefault = Color(0xff666666);
  static final headerColor = Colors.lightBlue;

  static final String _fontNameDefault = 'Verdana';
  static final String _fontNameTitle = 'Times New Roman';

  static final newsTitleStyle = TextStyle(
    fontFamily: _fontNameTitle,
    fontSize: TEXT_SIZE_LARGE,
    fontWeight: FontWeight.w700,
    color: Color(0xff000000),
  );
  static final newsAuthorStyle = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: TEXT_SIZE_DEFAULT,
    color: Color(0x99000000),
  );
  static final newsMediaCopyrightStyle = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: TEXT_SIZE_SMALL,
    color: Color(0x99000000),
  );

}