import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:word_english_game/allWords.dart';
import 'package:word_english_game/controller.dart';
import 'package:word_english_game/drag.dart';
import 'package:word_english_game/drop.dart';
import 'package:word_english_game/flyInAnimation.dart';
import 'package:word_english_game/progressBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _words = allWords.toList();
  late String _word, _dropWord;



  _generateWord() {
    final r = Random().nextInt(_words.length);
    _word = _words[r];
    _dropWord = _word;
    // remover da lista após ser utilizada
    _words.removeAt(r);
    // embaralhar as letras com afunção shuffle
    final s = _word.characters.toList()..shuffle();
    _word = s.join();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<Controller>(context, listen: false)
          .setUp(total: _word.length);
      Provider.of<Controller>(context, listen: false)
          .requestWord(request: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Selector<Controller, bool>(
      selector: (_, controller) => controller.generateWord,
      builder: (_, generate, __) {
        if(generate){
          if(_words.isNotEmpty)
          _generateWord();
        }
        return SafeArea(
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(60) 
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                              
                              padding: const EdgeInsets.fromLTRB(
                                18,2,2,2
                              ),
                              child: FittedBox(child: Text('Word Test',style: Theme.of(context).textTheme.displayLarge,)),
                            )),
                            const Expanded(
                              flex: 1,
                              child: 
                              // Image.asset('assets/images/bee.png')
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(),
                              ))
                          ],
                        ),
                      ),
                    ),
                  )),
              Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.blue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: _dropWord.characters
                          .map((e) => FlyInAnimation(
                            animate: true,
                            child: Drop(
                                  letter: e,
                                ),
                          ))
                          .toList(),
                    ),
                  )),
              Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.green,
                    child: FlyInAnimation(
                      animate: true,
                      child: Image.asset('assets/images/$_dropWord.jpg')),
                  )),
              Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.yellow,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: _word.characters
                          .map((e) => FlyInAnimation(
                            animate: true,
                            child: Drag(
                                  letter: e,
                                ),
                          ))
                          .toList(),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.pink,
                    child: ProgressBar(),
                  ))
            ],
          ),
        );
      },
    );
  }
}
