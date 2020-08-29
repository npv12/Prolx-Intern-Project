import 'package:flutter/material.dart';

class TextFieldForAll extends StatelessWidget {
  final String text;
  final double fsize;
  const TextFieldForAll({
    Key key,
    @required this.text,
    this.fsize = 17,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
      child: Text(
        text,
        style: TextStyle(fontSize: fsize),
      ),
    );
  }
}
