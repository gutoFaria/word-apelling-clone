import 'package:flutter/material.dart';

class Drop extends StatelessWidget {
  const Drop({
    required this.letter,
    super.key,
  });

  final String letter;

  @override
  Widget build(BuildContext context) {
    bool accepted = false;
    final size = MediaQuery.of(context).size;
    // o que irá receber o que será movido
    return SizedBox(
      width: size.width * 0.15,
      height: size.height * 0.15,
      child: Center(
        child: DragTarget(
          onWillAcceptWithDetails: (data) {
            if (data.data == letter) {
              print('accepted');
              return true;
            } else {
              print('rejected');
              return false;
            }
          },
          onAcceptWithDetails: (data) {
            accepted = true;
          },
          builder: (context, candidateData, rejectedData) {
            if (accepted) {
              return Text(
                letter,
                style: Theme.of(context).textTheme.displayLarge,
              );
            }else{
              return Container(
                color: Colors.amber, width: 50,height: 50,
              );
            }
          },
        ),
      ),
    );
  }
}
