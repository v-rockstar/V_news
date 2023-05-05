import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;

class WebTechnologyNews extends StatefulWidget {
  final int newsIndex;
  const WebTechnologyNews({super.key, required this.newsIndex});

  @override
  State<WebTechnologyNews> createState() => _WebTechnologyNews();
}

class _WebTechnologyNews extends State<WebTechnologyNews> {
  List news = [];
  late Map mapResponse;
  late String url;

  Future getApiCall() async {
    try {
      http.Response response;
      response = await http.get(Uri.parse(
          "https://newsapi.org/v2/top-headlines?country=in&category=technology&sortBy=publishedAt&apiKey=215f3e1f47324e86b38477b359b8d2f4"));
      if (response.statusCode == 200) {
        setState(() {
          mapResponse = jsonDecode(response.body.toString());
          news = mapResponse['articles'];
        });
      }
    } catch (e) {
      (e.toString());
    }

    return news;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: FutureBuilder(
          future: getApiCall(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var index = widget.newsIndex;
              return InAppWebView(
                initialUrlRequest:
                    URLRequest(url: Uri.parse(news[index]['url'].toString())),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    ));
  }
}
