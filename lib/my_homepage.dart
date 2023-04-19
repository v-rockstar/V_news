import 'package:flutter/material.dart';
import 'Card Sample/card_sample.dart';
import 'Container Sample/container_sample.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('V News'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
    );
  }
}
