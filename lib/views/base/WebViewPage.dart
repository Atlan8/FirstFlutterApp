import 'dart:convert';

import 'package:first_flutter_app/engine/customColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  String url;
  final String title;
  final bool isLocalUrl;

  late WebViewController _webViewController;

  WebViewPage({
    Key? key,
    required this.title,
    required this.url,
    this.isLocalUrl = false
  }): super(key: key);

  @override
  _WebViewPage createState() => _WebViewPage();
}

class _WebViewPage extends State<WebViewPage> {

  JavascriptChannel jsBridge(BuildContext context) => JavascriptChannel(
      name: 'jsbridge', // 与 H5 端保持一致，否则会收不到消息
      onMessageReceived: (JavascriptMessage message) async {
        // debugPrint(message.message);
      }
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 1,
          width: double.infinity,
          child: const DecoratedBox(decoration: BoxDecoration(color: CustomColors.borderGray)),
        ),
        Expanded(
          flex: 1,
            child: WebView(
              initialUrl:
              widget.isLocalUrl
                  ? Uri.dataFromString(widget.url, mimeType: 'text/html', encoding: Encoding.getByName('utf-8')).toString()
              : widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              javascriptChannels: [
                jsBridge(context)
              ].toSet(),
              onWebViewCreated: (WebViewController controller) {
                widget._webViewController = controller;
                if (widget.isLocalUrl) {
                  _loadHtmlAssets(controller);
                } else {
                  controller.loadUrl(widget.url);
                }

                // controller.canGoBack().then((value) => debugPrint(value.toString()));
                // controller.canGoForward().then((value) => debugPrint(value.toString()));
                // controller.currentUrl().then((value) => debugPrint(value.toString()));
              },
              onPageFinished: (String value) {
                // widget._webViewController.evaluateJavascript('document.title')
                // .then((title) => debugPrint(title));
              },
            )
        )
      ],
    );
  }

  //
  _loadHtmlAssets(WebViewController controller) async {
    String htmlPath = await rootBundle.loadString(widget.url);
    controller.loadUrl(Uri.dataFromString(htmlPath, mimeType: 'text/html',encoding: Encoding.getByName('utf-8')).toString());
  }
}