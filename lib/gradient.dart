import 'package:flutter/material.dart';

Color startColor=const Color.fromARGB(100,134,0,0);
Color centerColor=const Color.fromARGB(100,191,54,12);
Color endColor=const Color.fromARGB(100,134,0,0);


LinearGradient getGradient()
{
  return new LinearGradient(begin: FractionalOffset.bottomCenter,end: FractionalOffset.topLeft,
  colors: [startColor,centerColor,endColor]);
}


class GrowTransition extends StatelessWidget {
  GrowTransition({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  Widget build(BuildContext context) {
    return new Center(
      child: new AnimatedBuilder(
          animation: animation,

          builder: (BuildContext context, Widget child) {
            return new Container(
                height: animation.value, width: animation.value, child: child);
          },
          child: child),
    );
  }
}