import 'package:flutter/material.dart';

class helloWorld extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          color: Colors.cyanAccent,
          height: 400.0,
          width: 300.0,
          child: Center(
              child: Text(
                'Hello Scarlett!',
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w700),
              )),
        ));
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('Hello World!'),
      ),
      body: helloWorld(),
    ),
  ));
}
