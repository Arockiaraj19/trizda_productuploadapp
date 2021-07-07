import 'package:flutter/material.dart';

class Heading2 extends StatelessWidget {
  final String heading;
  final Color color;
  Heading2(this.heading, this.color);
  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      softWrap: true,
      style: TextStyle(
        color: color,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

