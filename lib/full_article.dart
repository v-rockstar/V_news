import 'package:flutter/material.dart';

class FullArticle extends StatefulWidget {
  final String? source;
  final String? title;
  final String? content;
  final String? url;
  final String? date;
  final String? urlToImage;
  const FullArticle({
    required this.title,
    required this.source,
    super.key,
    required this.content,
    required this.url,
    required this.date,
    required this.urlToImage,
  });

  @override
  State<FullArticle> createState() => _FullArticleState();
}

class _FullArticleState extends State<FullArticle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                colorFilter: const ColorFilter.mode(
                                    Colors.black38, BlendMode.colorBurn),
                                image:
                                    NetworkImage(widget.urlToImage ?? 'error'),
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
                                        onPressed: () => Navigator.pop(context),
                                        icon: const Icon(
                                          Icons.arrow_back,
                                          color: Colors.white,
                                        )))),
                            SizedBox(
                                height: MediaQuery.of(context).size.height / 2),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(widget.title ?? 'Error',
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(widget.source ?? 'Error',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Roboto Slab',
                                          color: Colors.white)),
                                ),
                                Text(widget.date ?? '',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Roboto Slab',
                                        color: Colors.white))
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(widget.content ?? 'Error',
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
            }));
  }
}
