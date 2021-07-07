import 'package:flutter/material.dart';

class Bodytext extends StatelessWidget {
  final String heading;
  final Color color;
  Bodytext(this.heading, this.color);
  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      textAlign: TextAlign.center,
      softWrap: true,
      style: TextStyle(
        color: color,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
