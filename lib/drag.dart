import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_english_game/controller.dart';

class Drag extends StatefulWidget {
  const Drag({
    required this.letter,
    super.key,
  });

  final String letter;

  @override
  State<Drag> createState() => _DragState();
}

class _DragState extends State<Drag> {
  bool _accepted = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // o que irá ser movido
    return Selector<Controller, bool>(
        selector: (_, controller) => controller.generateWord,
        builder: (_, generate, __) {
          if(generate){
            _accepted = false;
          }
          return SizedBox(
            width: size.width * 0.15,
            height: size.height * 0.15,
            child: Center(
              child: _accepted
                  ? SizedBox()
                  : Draggable(
                      data: widget.letter,
                      onDragEnd: (details) {
                        if (details.wasAccepted) {
                          _accepted = true;
                          setState(() {});
                          Provider.of<Controller>(context, listen: false)
                              .incrementLetters(context: context);
                        }
                      },
                      childWhenDragging: SizedBox(),
                      feedback: Text(
                        widget.letter,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(shadows: [
                          Shadow(
                              offset: Offset(3, 3),
                              color: Colors.black.withOpacity(0.40),
                              blurRadius: 5)
                        ]),
                      ),
                      child: Text(
                        widget.letter,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
            ),
          );
        });
  }
}
