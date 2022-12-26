import 'package:flutter/material.dart';

class TestUrl extends StatefulWidget {
  const TestUrl({Key? key}) : super(key: key);
  static const route = "/test";

  @override
  State<TestUrl> createState() => _TestUrlState();
}

class _TestUrlState extends State<TestUrl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.green,
        child: Center(
          child: Container(width: 400, height: 400, color: Colors.red),
        ),
      ),
    );
  }
}
