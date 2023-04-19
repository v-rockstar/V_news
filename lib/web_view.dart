import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebArticle extends StatefulWidget {
  final String url;
  const WebArticle({super.key, required this.url});

  @override
  State<WebArticle> createState() => _PractState();
}

class _PractState extends State<WebArticle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
        ));
  }
}
