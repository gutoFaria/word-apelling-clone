import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_english_game/controller.dart';
import 'package:word_english_game/homepage.dart';

void main() {
  // pacote provider changeNotifierprovider
  runApp(ChangeNotifierProvider(
    create: (_) => Controller(),
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Word Game English',
      theme: ThemeData(
          textTheme: const TextTheme(
              displayLarge: TextStyle(
                  fontFamily: 'PartyConfetti',
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.white))),
      home: const HomePage(),
    );
  }
}
