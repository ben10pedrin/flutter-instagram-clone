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
  var posts;

  void initState() {
    super.initState();
    getPosts();
  }

  void getPosts() {
    db
        .collection('posts')
        .get()
        .then((querySnapshot) async =>
            await Future.wait(querySnapshot.docs.map((doc) async {
              var mydoc = doc.data();
              mydoc['reference'] = doc.reference;
              mydoc['creator'] =
                  await mydoc['creator'].get().then((doc) => doc.data());
              mydoc['commentAmount'] = await doc.reference
                  .collection('comments')
                  .get()
                  .then((querySnapshot) => querySnapshot.size);
              return mydoc;
            })))
        .then((newPosts) => newPosts.toList())
        .then((newPosts) {
      setState(() {
        posts = newPosts;
      });
    });
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
                    username: posts[idx]['creator']['username'],
                    profileImage: posts[idx]['creator']['profileImage'],
                    content: posts[idx]['content'],
                    image: posts[idx]['image'],
                    likes: posts[idx]['likes'].length,
                    commentAmount: posts[idx]['commentAmount'],
                    date: posts[idx]['date'],
                    reference: posts[idx]['reference'],
                  );
                },
              ));
  }
}
