import 'package:flutter/material.dart';
import 'package:posts/CommentInput.dart';
import './Comment.dart';

class CommentList extends StatefulWidget {
  final autofocus;
  final primary;

  const CommentList({Key? key, required this.autofocus, required this.primary})
      : super(key: key);

  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  var comments;

  String daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    var difference = (to.difference(from).inHours / 24).round();
    if (difference <= 6) {
      return "${difference}d";
    } else {
      return "${difference ~/ 7}w";
    }
  }

  void getPosts() async {
    var querySnapshot =
        await widget.primary.reference.collection('comments').get();
    var newComments = querySnapshot.docs.map((doc) => doc.data()).toList();
    for (var i = 0; i < newComments.length; i++) {
      newComments[i]['creator'] = await newComments[i]['creator'].get();
      newComments[i]['creator'] = newComments[i]['creator'].data();
      newComments[i]['date'] =
          daysBetween(newComments[i]['date'].toDate(), DateTime.now());
    }
    setState(() {
      comments = newComments;
    });
  }

  @override
  void initState() {
    super.initState();
    getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: comments != null
              ? ListView.builder(
                  itemCount: comments.length + 1,
                  itemBuilder: (context, idx) {
                    if (idx == 0) {
                      return Comment(
                        isPrimary: true,
                        content: widget.primary.content,
                        profileImage: widget.primary.profileImage,
                        username: widget.primary.username,
                        date: daysBetween(
                            widget.primary.date.toDate(), DateTime.now()),
                      );
                    }
                    return Comment(
                      isPrimary: false,
                      content: comments[idx - 1]['content'],
                      likes: comments[idx - 1]['likes'].length,
                      profileImage: comments[idx - 1]['creator']
                          ['profileImage'],
                      username: comments[idx - 1]['creator']['username'],
                      date: comments[idx - 1]['date'],
                    );
                  })
              : Text('Loading...'),
        ),
        CommentInput(
          autofocus: widget.autofocus,
        )
      ],
    );
  }
}
