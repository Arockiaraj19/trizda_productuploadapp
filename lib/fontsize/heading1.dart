import 'package:flutter/material.dart';

class Heading1 extends StatelessWidget {
  final String heading;
  final Color color;
  Heading1(this.heading, this.color);
  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      softWrap: true,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontSize: 17,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
