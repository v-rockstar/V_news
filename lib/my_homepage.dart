import 'dart:async';
import 'package:flutter/material.dart';
import 'Card Sample/card_sample.dart';
import 'Container Sample/container_sample.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  StreamController<int> streamController = StreamController();

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 7), (timer) {
      increamentCounter();
    });

    super.initState();
  }

  int increamentCounter() {
    streamController.sink.add(_counter++);
    return _counter;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder<int>(
                stream: streamController.stream,
                builder: (context, snapshot) {
                  return Text(
                    '$_counter',
                  );
                }),
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ContainerSample(),
                      ));
                },
                icon: const Icon(Icons.read_more),
                label: const Text('Container Sample')),
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CardSample(),
                      ));
                },
                icon: const Icon(Icons.read_more),
                label: const Text('API key Sample')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
