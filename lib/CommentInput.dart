import 'package:flutter/material.dart';

class CommentInput extends StatefulWidget {
  final autofocus;

  const CommentInput({Key? key, required this.autofocus}) : super(key: key);

  @override
  _CommentInputState createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  var controller = TextEditingController();
  var textJustForButton = '';

  List<Widget> renderEmojis() {
    var emojis = ['♥', '👐', '🔥', '👏', '😢', '😍', '😮', '😂'];
    List<Widget> icons = [];
    for (var i = 0; i < emojis.length; i++) {
      icons.add(
        GestureDetector(
          onTap: () {
            var newOffset = controller.selection.base.offset + emojis[i].length;
            var newText = controller.text + emojis[i];
            controller.value = TextEditingValue(
              text: newText,
              selection:
                  TextSelection.fromPosition(TextPosition(offset: newOffset)),
            );
            setState(() {
              textJustForButton = newText;
            });
          },
          child: Container(
            child: Text(
              emojis[i],
              style: TextStyle(fontSize: 24),
            ),
            padding: EdgeInsets.fromLTRB(3, 8, 3, 5),
            color: Colors.grey[900],
          ),
        ),
      );
    }
    return icons;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.grey[900],
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: renderEmojis(),
          ),
        ),
        Container(
          color: Colors.grey[900],
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 18, right: 18),
                child: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                        'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg')),
              ),
              Expanded(
                child: TextField(
                  onChanged: (newText) {
                    setState(() {
                      textJustForButton = newText;
                    });
                  },
                  controller: controller,
                  autofocus: widget.autofocus,
                  minLines: 1,
                  maxLines: 7,
                  textCapitalization: TextCapitalization.sentences,
                  cursorColor: Colors.lightBlue[100],
                  style: TextStyle(fontSize: 15, color: Colors.white),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Add a comment...',
                  ),
                ),
              ),
              TextButton(
                onPressed: textJustForButton.length > 0 ? () {} : null,
                child: Text('Post'),
              )
            ],
          ),
        )
      ],
    );
  }
}
