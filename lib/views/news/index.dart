import 'package:first_flutter_app/engine/customColors.dart';
import 'package:first_flutter_app/views/base/WebViewPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsPage extends StatefulWidget {
  NewsPage({
    Key? key
  }): super(key: key);

  _NewsState createState() => _NewsState();
}

class _NewsState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: '登录即代表同意并阅读',
        style: TextStyle(fontSize: 14, color: CustomColors.black),
        children: [
          TextSpan(
            text: '《用户协议》',
            style: TextStyle(color: Theme.of(context).primaryColor),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return WebViewPage(title: '《用户协议》', url: 'https://flutter.dev');
                }));
              }
          ),
          TextSpan(text: '和'),
          TextSpan(
            text: '《隐私政策》',
            style: TextStyle(color: Theme.of(context).primaryColor),
            
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return WebViewPage(title: "《隐私政策》", url: 'https://flutter.dev');
                }));
              }
          )
        ]
      )
    );
  }
}