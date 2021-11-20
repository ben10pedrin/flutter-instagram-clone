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
  var controller = TextEditingController();
  var errorText;
  PickedFile? imageFile;

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
      Navigator.pushReplacement(
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
