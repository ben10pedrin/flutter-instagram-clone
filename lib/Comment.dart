import 'package:flutter/material.dart';

class Comment extends StatefulWidget {
  final bool isPrimary;
  final String content;
  final username;
  final profileImage;
  final date;
  final likes;

  const Comment(
      {Key? key,
      required this.isPrimary,
      required this.content,
      required this.username,
      required this.profileImage,
      required this.date,
      this.likes})
      : super(key: key);

  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  bool isLiked = false;

  void like() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
          child: CircleAvatar(
              radius: 20, backgroundImage: NetworkImage(widget.profileImage)),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: '${widget.username} ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: widget.content),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 20),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.grey[500],
                      ),
                      children: <TextSpan>[
                        TextSpan(text: widget.date.toString()),
                        TextSpan(
                            text: widget.isPrimary
                                ? ''
                                : '       ${widget.likes} likes'),
                        TextSpan(text: widget.isPrimary ? '' : '       Reply'),
                      ],
                    ),
                  ))
            ],
          ),
        ),
        Wrap(
          children: [
            Container(
                width: 70,
                child: Center(
                    child: widget.isPrimary
                        ? null
                        : GestureDetector(
                            child: Container(
                              width: 50,
                              height: 50,
                              color: Colors.black,
                              child: Icon(
                                isLiked
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_outline_rounded,
                                color: isLiked ? Colors.red : Colors.grey[500],
                                size: 16,
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                like();
                              });
                            },
                          )))
          ],
        )
      ],
    );
  }
}
