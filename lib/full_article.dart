import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class FullArticle extends StatefulWidget {
  final int newsIndex;
  const FullArticle({required this.newsIndex, super.key});

  @override
  State<FullArticle> createState() => _FullArticleState();
}

class _FullArticleState extends State<FullArticle> {
  late Map mapResponse;
  List news = [];
  String? urlToImage;
  late String url;
  String? source;
  String? title;
  String? date;
  String? content;

  Future getApiCall() async {
    try {
      http.Response response;
      response = await http.get(Uri.parse(
          "https://newsapi.org/v2/top-headlines?country=in&category=sports&sortBy=publishedAt&apiKey=215f3e1f47324e86b38477b359b8d2f4"));
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
        backgroundColor: Colors.transparent,
        body: FutureBuilder(
            future: getApiCall(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      index = widget.newsIndex;
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        colorFilter: const ColorFilter.mode(
                                            Colors.black38,
                                            BlendMode.colorBurn),
                                        image: NetworkImage(news[index]
                                                ['urlToImage'] ??
                                            'error'),
                                        fit: BoxFit.fill)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: CircleAvatar(
                                            backgroundColor: Colors.grey,
                                            child: IconButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                icon: const Icon(
                                                  Icons.arrow_back,
                                                  color: Colors.white,
                                                )))),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                2),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          news[index]['title'] ?? 'Error',
                                          style: const TextStyle(
                                              fontFamily: 'Roboto Slab',
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white)),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              news[index]['source']['name'] ??
                                                  'Error',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Roboto Slab',
                                                  color: Colors.white)),
                                        ),
                                        Text(news[index]['publishedAt'] ?? '',
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Roboto Slab',
                                                color: Colors.white))
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          news[index]['content'] ?? 'Error',
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontFamily: 'Roboto Slab',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white70)),
                                    )
                                  ],
                                )),
                          ],
                        ),
                      );
                    });
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
