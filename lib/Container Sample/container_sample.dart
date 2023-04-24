import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:v_news/Web%20View/sports.view.dart';

class ContainerSample extends StatefulWidget {
  const ContainerSample({super.key});

  @override
  State<ContainerSample> createState() => _NewsPageState();
}

class _NewsPageState extends State<ContainerSample> {
  List news = [];
  late Map mapResponse;
  late String content;
  late String url;

  Future<List> getApiCall() async {
    http.Response response;
    response = await http.get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&category=sports&sortBy=publishedAt&apiKey=a44560dd47ab471ea440233c1c8aee10"));
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = jsonDecode(response.body.toString());
        news = mapResponse['articles'];
      });
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
          style: TextStyle(fontSize: 27),
        ),
        leading: const Icon(Icons.menu),
      ),
      backgroundColor: const Color(0x46464646),
      body: FutureBuilder(
          future: getApiCall(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: news.length,
                  itemBuilder: (context, index) {
                    url = news[index]['url'].toString();
                    return SingleChildScrollView(
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          WebSportsNews(newsIndex: index))),
                              child: Contents(
                                url: news[index]['urlToImage'] ?? 'Error',
                                text: news[index]['title'] ?? 'Error',
                                source: news[index]['source']['name'] ??
                                    'Error'.toString(),
                                dateTime: news[index]['publishedAt'] ?? 'Error',
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

class Contents extends StatelessWidget {
  final String url;
  final String text;
  final String source;
  final String dateTime;
  const Contents(
      {super.key,
      required this.url,
      required this.text,
      required this.source,
      required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      height: 200,
      width: 330,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(url),
              colorFilter:
                  const ColorFilter.mode(Colors.black38, BlendMode.colorBurn),
              fit: BoxFit.fill)),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 27),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(text,
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    source,
                    style: const TextStyle(fontSize: 10, color: Colors.white),
                  ),
                  const SizedBox(width: 17),
                  Text(
                    dateTime,
                    style: const TextStyle(fontSize: 10, color: Colors.white),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
