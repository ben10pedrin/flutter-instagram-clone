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
  List<Comment> comments = [
    new Comment(
      content: "cool photo",
      date: new DateTime.now(),
      isPrimary: false,
      username: "Jorge",
      likes: 1,
      profileImage:
          "https://www.photoshopessentials.com/newsite/wp-content/uploads/2018/08/resize-images-print-photoshop-f.jpg",
    ),
    new Comment(
      content: "that's a nice photo",
      date: new DateTime.now(),
      isPrimary: false,
      username: "Alex",
      likes: 1,
      profileImage:
          "https://cdn.jpegmini.com/user/images/slider_puffin_before_mobile.jpg",
    ),
    new Comment(
      content: "Very Cool",
      date: new DateTime.now(),
      isPrimary: false,
      username: "Bill",
      likes: 1,
      profileImage:
          "https://upload.wikimedia.org/wikipedia/commons/9/9a/Gull_portrait_ca_usa.jpg",
    ),
    new Comment(
      content: "love you pedro",
      date: new DateTime.now(),
      isPrimary: false,
      username: "Maria",
      likes: 1,
      profileImage: "https://tinypng.com/images/social/website.jpg",
    )
  ];

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

  @override
  void initState() {
    super.initState();
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
                      content: comments[idx - 1].content,
                      likes: comments[idx - 1].likes,
                      profileImage: comments[idx - 1].profileImage,
                      username: comments[idx - 1].username,
                      date: daysBetween(comments[idx - 1].date, DateTime.now()),
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
