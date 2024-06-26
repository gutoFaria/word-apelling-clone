import 'dart:math';

import 'package:flutter/material.dart';

class FlyInAnimation extends StatefulWidget {
  const FlyInAnimation({super.key, required this.child, required this.animate, this.removeScale = false});

  final Widget child;
  final bool animate;
  final bool? removeScale;

  @override
  State<FlyInAnimation> createState() => _FlyInAnimationState();
}

class _FlyInAnimationState extends State<FlyInAnimation> with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this
      );

      double begin = 0, end = 1;
      final flip = Random().nextBool();

      if(flip){
        begin = 1;
        end = 0;
      }

      _rotationAnimation = Tween<double>(begin: begin, end: end).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine)
      );
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FlyInAnimation oldWidget) {
    if(widget.animate && !_controller.isAnimating){
      _controller.reset();
      _controller.forward();
      //_controller.reverse();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => RotationTransition(
        turns: _rotationAnimation,
        child: (widget.removeScale ?? false) ?
        widget.child :
         ScaleTransition(
          scale: _controller,
          child: widget.child,
        ),
        ),
    );
  }
}