import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:v_news/News/business_news.dart';
import 'package:v_news/News/science_news.dart';
import 'package:v_news/News/sports_news.dart';
import 'package:v_news/News/technology_news.dart';
import 'package:v_news/Web%20View/landing_view.dart';
import 'entertainment_news.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({
    super.key,
  });

  @override
  State<LandingPage> createState() => _LandingNews();
}

class _LandingNews extends State<LandingPage> {
  List news = [];
  late Map mapResponse;
  String? urlToImage;
  late String url;
  String? source;
  String? title;
  String? date;
  String? content;
  int indexes = 0;
  List<Widget> categories = const [
    CategoryItems(name: 'Sports'),
    CategoryItems(name: 'Entertainment'),
    CategoryItems(name: 'Science'),
    CategoryItems(name: 'Business'),
    CategoryItems(name: 'Technology'),
  ];

  Future<List> getApiCall() async {
    try {
      http.Response response;
      response = await http.get(Uri.parse(
          "https://newsapi.org/v2/top-headlines?country=in&sortBy=publishedAt&apiKey=215f3e1f47324e86b38477b359b8d2f4"));
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
            backgroundColor: Colors.black26,
            title: const Text(
              'HEADLINES',
              style: TextStyle(
                  fontFamily: 'Roboto Slab Bold',
                  fontSize: 29,
                  color: Color(0xffffffff)),
            ),
            leading: const Padding(
              padding: EdgeInsets.only(left: 18, top: 5, bottom: 5),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://yt3.ggpht.com/a/AATXAJwJBQRVWARGtmkb7EVxtIAzWe_mACMzdE5TBQ=s900-c-k-c0xffffffff-no-rj-mo'),
              ),
            )),
        backgroundColor: Colors.black38,
        body: RefreshIndicator(
          color: Colors.amber,
          onRefresh: () {
            return Navigator.pushReplacement(
                context,
                PageTransition(
                    child: const LandingPage(),
                    type: PageTransitionType.bottomToTop,
                    duration: const Duration(seconds: 1)));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Builder(
                builder: (context) {
                  return const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Categories >>',
                      style: TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.w700,
                          fontSize: 23),
                    ),
                  );
                }
              ),
              SizedBox(
                  height: 70,
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        setState(() {
                          indexes = index;
                          if (index == 0) {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: const SportsNews(),
                                    type: PageTransitionType.fade,
                                    duration: const Duration(seconds: 1)));
                          } else if (index == 1) {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: const EntertainmentNews(),
                                    type: PageTransitionType.fade,
                                    duration: const Duration(seconds: 1)));
                          } else if (index == 2) {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: const ScienceNews(),
                                    type: PageTransitionType.fade,
                                    duration: const Duration(seconds: 1)));
                          } else if (index == 3) {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: const BusinessNews(),
                                    type: PageTransitionType.fade,
                                    duration: const Duration(seconds: 1)));
                          } else if (index == 4) {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: const TechnologyNews(),
                                    type: PageTransitionType.fade,
                                    duration: const Duration(seconds: 1)));
                          }
                        });
                      },
                      child: categories[index],
                    ),
                  )),
              Expanded(
                child: FutureBuilder(
                    future: getApiCall(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: news.length,
                            itemBuilder: (context, index) {
                              url = news[index]['url'] ?? 'Error';
                              content = news[index]['content'] ?? 'Error';
                              return InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            WebLandingNews(newsIndex: index))),
                                child: Card(
                                  color: Colors.grey.shade900,
                                  elevation: 15,
                                  margin: const EdgeInsets.all(15),
                                  child: Column(children: [
                                    Image(
                                      image: NetworkImage(urlToImage = news[
                                              index]['urlToImage'] ??
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
                                          title =
                                              news[index]['title'] ?? 'Error',
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
                                                  fontFamily:
                                                      'Roboto Slab Regular',
                                                  fontSize: 12,
                                                  color: Color(0xf2f2f2f2))),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              date = news[index]
                                                      ['publishedAt'] ??
                                                  'Error',
                                              style: const TextStyle(
                                                  fontFamily:
                                                      'Roboto Slab Regular',
                                                  fontSize: 12,
                                                  color: Color(0xf2f2f2f2))),
                                        ),
                                      ],
                                    )
                                  ]),
                                ),
                              );
                            });
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            ],
          ),
        ));
  }
}

class CategoryItems extends StatelessWidget {
  final String name;
  const CategoryItems({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(17),
      decoration: BoxDecoration(
          color: Colors.indigo, borderRadius: BorderRadius.circular(40)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            name,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
