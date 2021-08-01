import 'dart:js';

import 'package:first_flutter_app/engine/customColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef OnTapCallback = void Function(String key);

class PrivacyView extends StatefulWidget {
  final String data;
  final List<String> keys;
  final TextStyle? style;
  final TextStyle? keyStyle;
  final OnTapCallback? onTapCallback;

  const PrivacyView({
    Key? key,
    required this.data,
    required this.keys,
    this.style,
    this.keyStyle,
    this.onTapCallback,
  }): super(key: key);

  @override
  _PrivaryViewState createState() => _PrivaryViewState();
}

class _PrivaryViewState extends State<PrivacyView> {

  List<String> _list = [];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container();
  }

  void _split() {
    int startIndex = 0;
    Map<String, dynamic>? _index;
    while ((_index = _nextIndex(startIndex)) != null) {
      int i = _index?['index'];
      String sub = widget.data.substring(startIndex, i);
      if (sub.isNotEmpty) {
        _list.add(sub);
      }
      _list.add(_index?['key']);

      // 如果key存在，则将下标从当前下标移动到下一处
      startIndex = i + (_index?['key'] as String).length;
    }
  }

  Map<String, dynamic>? _nextIndex(int startIndex) {
    int currentIndex = widget.data.length;
    String? key;
    widget.keys.forEach((element) {
      int index = widget.data.indexOf(element, startIndex);
      if (index != -1 && index < currentIndex) {
        currentIndex = index;
        key = element;
      }
    });
    if (key == null) {
      return null;
    }
    return {
      'key': '$key',
      'index': currentIndex
    };
  }
}