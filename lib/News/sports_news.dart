import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:v_news/News/entertainment_news.dart';
import 'package:v_news/Web%20View/sports.view.dart';

class SportsNews extends StatefulWidget {
  const SportsNews({
    super.key,
  });

  @override
  State<SportsNews> createState() => _SportsNews();
}

class _SportsNews extends State<SportsNews> {
  List news = [];
  late Map mapResponse;
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
        appBar: AppBar(
            centerTitle: true,
            elevation: 10,
            backgroundColor: Colors.black,
            title: const Text(
              'HEADLINES',
              style: TextStyle(
                  fontFamily: 'Roboto Slab',
                  fontSize: 29,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffffffff)),
            ),
            leading: const Padding(
              padding: EdgeInsets.only(left: 18, top: 5, bottom: 5),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://yt3.ggpht.com/a/AATXAJwJBQRVWARGtmkb7EVxtIAzWe_mACMzdE5TBQ=s900-c-k-c0xffffffff-no-rj-mo'),
              ),
            )),
        backgroundColor: Colors.black,
        body: RefreshIndicator(
          onRefresh: () {
            return Navigator.pushReplacement(
                context,
                PageTransition(
                    child: const EntertainmentNews(),
                    type: PageTransitionType.topToBottom,
                    duration: const Duration(seconds: 1)));
          },
          child: FutureBuilder(
              future: getApiCall(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: news.length,
                      itemBuilder: (context, index) {
                        url = news[index]['url'] ?? 'Error';
                        content = news[index]['content'] ?? 'Error';
                        return SingleChildScrollView(
                          child: InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WebSportsNews(
                                        newsIndex: index))),
                            child: Card(
                              color: Colors.grey.shade900,
                              elevation: 15,
                              margin: const EdgeInsets.all(15),
                              child: Column(children: [
                                Image(
                                  image: NetworkImage(urlToImage = news[index]
                                          ['urlToImage'] ??
                                      'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/breaking-news-poster-design-template-232c3f2700b91a0fd6e3a5a2e583a5da_screen.jpg?ts=1610645412'),
                                  fit: BoxFit.fill,
                                  height: 270,
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      title = news[index]['title'] ?? 'Error',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style: const TextStyle(
                                          fontFamily: 'Roboto Slab Regular',
                                          fontSize: 20,
                                          color: Color(0xf2f2f2f2))),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          source = news[index]['source']
                                                  ['name'] ??
                                              'Error',
                                          style: const TextStyle(
                                              fontFamily: 'Roboto Slab Regular',
                                              fontSize: 12,
                                              color: Color(0xf2f2f2f2))),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          date = news[index]['publishedAt'] ??
                                              'Error',
                                          style: const TextStyle(
                                              fontFamily: 'Roboto Slab Regular',
                                              fontSize: 12,
                                              color: Color(0xf2f2f2f2))),
                                    ),
                                  ],
                                )
                              ]),
                            ),
                          ),
                        );
                      });
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ));
  }
}
