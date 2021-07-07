import 'package:flutter/material.dart';

class Heading3 extends StatelessWidget {
  final String heading;
  final Color color;
  Heading3(this.heading, this.color);
  @override
  Widget build(BuildContext context) {
    return Text(
      heading.toUpperCase(),
      softWrap: true,
      style: TextStyle(
        color: color,
        fontSize: 15,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}
