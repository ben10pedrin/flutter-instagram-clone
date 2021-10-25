import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  var controller = TextEditingController();
  var errorText;
  bool errorImg = false;
  PickedFile? imageFile;

  Future<void> pickImage(ImageSource source) async {
    PickedFile? selected = await ImagePicker()
        .getImage(source: source, maxWidth: 720, maxHeight: 720);

    setState(() {
      imageFile = selected;
    });
  }

  void resetError() {
    setState(() {
      errorText = null;
    });
  }

  void resetImgError() {
    setState(() {
      errorImg = false;
    });
  }

  void close() {
    Navigator.of(context).pop();
  }

  void addImg() {
    setState(() {
      errorImg = false;
    });
    pickImage(ImageSource.gallery);
  }

  void submitPost() {
    if (controller.text.trim() == '') {
      setState(() {
        errorText = 'Caption cannot be empty';
      });
    } else if (imageFile == null) {
      setState(() {
        errorImg = true;
      });
    } else {
      close();
    }
  }

  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.white,
                size: 36,
              ),
              onPressed: close,
            ),
            title: Text('New Post'),
            backgroundColor: Colors.black),
        body: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: imageFile == null
                    ? Center(
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          TextButton.icon(
                            onPressed: addImg,
                            icon: Icon(Icons.add_a_photo),
                            label: Text('Add a photo'),
                          ),
                          if (errorImg)
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text(
                                'Upload a photo',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.red[600]),
                              ),
                            ),
                        ]),
                      )
                    : Image.file(
                        File(imageFile!.path),
                        fit: BoxFit.cover,
                      ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: controller,
                  onChanged: (_) => resetError(),
                  minLines: 1,
                  maxLines: 4,
                  maxLength: 140,
                  textCapitalization: TextCapitalization.sentences,
                  cursorColor: Colors.lightBlue[100],
                  decoration: InputDecoration(
                      errorText: errorText,
                      hintText: 'Write a caption...',
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      fillColor: Colors.grey[900]),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: ElevatedButton(
                  onPressed: submitPost,
                  child: Text('Done'),
                ),
              )
            ],
          ),
        ));
  }
}
