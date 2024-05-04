import 'package:flutter/material.dart';

class Routly extends PageRouteBuilder {
  final Widget route;

  Routly({required this.route})
      : super(
    pageBuilder: (context, animation, secondaryAnimation) => route,
    transitionDuration: const Duration(milliseconds: 450),
    reverseTransitionDuration: const Duration(milliseconds: 450),
    maintainState: false,
    opaque: false,
  );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}