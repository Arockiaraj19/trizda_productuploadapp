import 'package:flutter/material.dart';

class Bodytext1 extends StatelessWidget {
  final String heading;
  final Color color;
  Bodytext1(this.heading, this.color);
  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      softWrap: true,
      style: TextStyle(
        color: color,
        fontSize: 9,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class Bodytext0 extends StatelessWidget {
  final String heading;
  final Color color;
  Bodytext0(this.heading, this.color);
  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      softWrap: true,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
