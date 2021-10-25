import 'package:flutter/material.dart';
import './PostList.dart';
import './AddPage.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(11),
              child: Image.asset(
                'assets/instagramTitle.png',
                alignment: Alignment.centerLeft,
                fit: BoxFit.contain,
                height: 20,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddPage()),
              );
            },
            icon: Icon(
              Icons.add,
            ),
          )
        ], backgroundColor: Colors.black),
        body: PostList());
  }
}
