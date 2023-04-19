import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import '../full_article.dart';
import '../web_view.dart';
import 'entertainment_news.dart';

class CardSample extends StatefulWidget {
  const CardSample({
    super.key,
  });

  @override
  State<CardSample> createState() => _PractState();
}

class _PractState extends State<CardSample> {
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
          backgroundColor: const Color(0x00000000),
          title: const Text(
            'HEADLINES',
            style: TextStyle(
                fontFamily: 'Roboto Slab Bold',
                fontSize: 29,
                color: Color(0xffffffff)),
          ),
          leading: const Icon(Icons.menu),
        ),
        backgroundColor: const Color(0x46464646),
        body: RefreshIndicator(
          onRefresh: () {
            return Navigator.pushReplacement(
                context,
                PageTransition(
                    child: const EntertainmentNews(),
                    type: PageTransitionType.bottomToTop,
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
                          child: SizedBox(
                              height: 250,
                              child: InkWell(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return 
                                      FullArticle(
                                        content: content,
                                        urlToImage: urlToImage,
                                        date: date,
                                        url: url,
                                        title: title,
                                        source: source,
                                      );
                                      // WebArticle(url: url);
                                    },
                                  ),
                                ),
                                child: Card(
                                  elevation: 20,
                                  margin: const EdgeInsets.all(15),
                                  child: Stack(
                                      alignment: Alignment.bottomLeft,
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  colorFilter: ColorFilter.mode(
                                                      Colors.grey.shade300,
                                                      BlendMode.colorBurn),
                                                  image: NetworkImage(
                                                      urlToImage = news[index]
                                                              ['urlToImage'] ??
                                                          'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/breaking-news-poster-design-template-232c3f2700b91a0fd6e3a5a2e583a5da_screen.jpg?ts=1610645412'),
                                                  fit: BoxFit.fill)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 30, horizontal: 10),
                                          child: Text(
                                              title = news[index]['title'] ??
                                                  'Error',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                              style: const TextStyle(
                                                  fontFamily:
                                                      'Roboto Slab Regular',
                                                  fontSize: 20,
                                                  color: Color(0xf2f2f2f2))),
                                        ),
                                        Positioned(
                                            bottom: 10,
                                            left: 10,
                                            child: Row(
                                              children: [
                                                Text(
                                                    source = news[index]
                                                                ['source']
                                                            ['name'] ??
                                                        'Error',
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontFamily:
                                                            'Roboto Slab Bold',
                                                        color:
                                                            Color(0xbabababa))),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                    date != null
                                                        ? 'Error'
                                                        : news[index]
                                                            ['publishedAt'],
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color:
                                                            Color(0xbabababa)))
                                              ],
                                            ))
                                      ]),
                                ),
                              )),
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
