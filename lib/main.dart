import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:v_news/Card%20Sample/sports_news.dart';
import 'my_homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
          splashIconSize: 170,
          splashTransition: SplashTransition.scaleTransition,
          pageTransitionType: PageTransitionType.fade,
          animationDuration: const Duration(seconds: 2),
          splash: const Image(
              image: NetworkImage(
                  'https://yt3.ggpht.com/a/AATXAJwJBQRVWARGtmkb7EVxtIAzWe_mACMzdE5TBQ=s900-c-k-c0xffffffff-no-rj-mo')),
          nextScreen: const SportsNews()),
    );
  }
}
