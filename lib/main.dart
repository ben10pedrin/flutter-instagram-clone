import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './LoginPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.black, brightness: Brightness.dark),
      home: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Something went wrong with firebase :('),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return LoginPage();
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
