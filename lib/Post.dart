import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:posts/CommentPage.dart';

class Post extends StatefulWidget {
  final String profileImage;
  final String content;
  final String username;
  final String image;
  final int likes;
  final int commentAmount;
  final date;
  final reference;

  const Post(
      {Key? key,
      required this.profileImage,
      required this.content,
      required this.username,
      required this.image,
      required this.likes,
      required this.commentAmount,
      required this.date,
      this.reference})
      : super(key: key);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> with TickerProviderStateMixin {
  bool isLiked = false;
  bool isHeartVisible = false;
  late int likes;

  void like() {
    setState(() {
      likes = widget.likes + 1;
      isLiked = true;
    });
  }

  void unlike() {
    setState(() {
      likes = widget.likes;
      isLiked = false;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      likes = widget.likes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Row(children: [
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: CircleAvatar(
                radius: 20, backgroundImage: NetworkImage(widget.profileImage)),
          ),
          Text(
            widget.username,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ]),
        GestureDetector(
            child: Stack(
              alignment: Alignment.center,
              children: [
                AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(widget.image, fit: BoxFit.cover)),
                AnimatedOpacity(
                  opacity: isHeartVisible ? 1 : 0,
                  onEnd: () {
                    setState(() {
                      isHeartVisible = false;
                    });
                  },
                  duration: Duration(milliseconds: 300),
                  child: Icon(
                    Icons.favorite_rounded,
                    size: 120,
                  ),
                )
              ],
            ),
            onDoubleTap: () {
              setState(() {
                isHeartVisible = true;
                like();
              });
            }),
        Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Row(children: [
                Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: GestureDetector(
                      child: Icon(
                        isLiked
                            ? Icons.favorite_rounded
                            : Icons.favorite_outline_rounded,
                        color: isLiked ? Colors.red : Colors.white,
                        size: 30,
                      ),
                      onTap: () {
                        setState(() {
                          isLiked ? unlike() : like();
                        });
                      },
                    )),
                GestureDetector(
                  child: Icon(Icons.chat_bubble_outline,
                      size: 30, color: Colors.white),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CommentPage(
                                autofocus: true,
                                primary: widget,
                              )),
                    );
                  },
                )
              ]),
              Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        likes.toString() + ' likes',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CommentPage(
                                autofocus: false,
                                primary: widget,
                              )),
                    );
                  },
                  child: Container(
                      color: Colors.black,
                      child: Column(children: [
                        Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Pedro ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(text: widget.content),
                                    ],
                                  ),
                                ))),
                        Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    'View all ' +
                                        widget.commentAmount.toString() +
                                        ' comments.',
                                    style:
                                        TextStyle(color: Colors.grey[500])))),
                        Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    DateFormat.yMMMMd('en_US')
                                        .format(widget.date.toDate()),
                                    style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: 12))))
                      ]))),
            ],
          ),
        )
      ],
    ));
  }
}
