import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './Post.dart';

class PostList extends StatefulWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  var db = FirebaseFirestore.instance;
  var posts = ['1'];

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: posts == null
            ? Text('Loading...')
            : ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, idx) {
                  return Post(
                    username: "Pedro",
                    profileImage:
                        "https://im0-tub-ru.yandex.net/i?id=e67c20f98bdc512c5d3bc20c140f8fac&n=27&h=480&w=480",
                    content: "Hello from flutter-instagram",
                    image:
                        "https://assets-global.website-files.com/6019e43dcfad3c059841794a/6019e43dcfad3ccc674179cf_Hero-Image.jpg",
                    likes: 5,
                    commentAmount: 4,
                    date: new Timestamp.now(),
                  );
                },
              ));
  }
}
