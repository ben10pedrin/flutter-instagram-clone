import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import './PostPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var db = FirebaseFirestore.instance;
  var st = FirebaseStorage.instance;
  var controller = TextEditingController();
  var errorText;
  PickedFile? imageFile;

  Future<void> createUser() async {
    File file;
    var url;

    if (imageFile != null) {
      file = File(imageFile!.path);
      var ref = st.ref('profileImages/${file.path.split('/').last}');
      await ref.putFile(file);
      url = await ref.getDownloadURL();
    } else {
      url =
          'https://firebasestorage.googleapis.com/v0/b/instaclone-9cc81.appspot.com/o/profileImages%2FdefaultProfile.png?alt=media&token=526d3075-7bcf-4150-bfb3-6e60a5df7fb9';
    }

    try {
      await db.collection('users').add({
        'username': controller.text,
        'profileImage': url,
      });
    } catch (e) {
      setState(() {
        errorText = 'Something failed :(';
      });
    }
  }

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

  void handleSubmit() async {
    resetError();
    if (controller.text.trim() == '') {
      setState(() {
        errorText = 'Username cannot be empty';
      });
    } else {
      await createUser();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PostPage()),
      );
    }
  }

  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: FractionallySizedBox(
            widthFactor: 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Image(
                      width: 200,
                      image: AssetImage('assets/instagramTitle.png'),
                    )),
                TextField(
                  onChanged: (_) => resetError(),
                  controller: controller,
                  textCapitalization: TextCapitalization.sentences,
                  cursorColor: Colors.lightBlue[100],
                  decoration: InputDecoration(
                      errorText: errorText,
                      hintText: 'Choose a username',
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
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  TextButton.icon(
                    onPressed: imageFile == null
                        ? () {
                            resetError();
                            pickImage(ImageSource.gallery);
                          }
                        : null,
                    style: TextButton.styleFrom(primary: Colors.blue),
                    icon: Icon(Icons.add_a_photo),
                    label: Text('Add a profile photo'),
                  ),
                  Text(
                    '(Optional)',
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                ]),
                Container(
                  child: ElevatedButton(
                    onPressed: handleSubmit,
                    child: Text('Log In'),
                  ),
                  width: double.infinity,
                )
              ],
            )),
      ),
    ));
  }
}
