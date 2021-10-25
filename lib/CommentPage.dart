import 'package:flutter/material.dart';
import './CommentList.dart';

class CommentPage extends StatelessWidget {
  final autofocus;
  final primary;

  const CommentPage({Key? key, required this.autofocus, required this.primary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Comments'), backgroundColor: Colors.black),
        body: CommentList(
          autofocus: autofocus,
          primary: primary,
        ));
  }
}
