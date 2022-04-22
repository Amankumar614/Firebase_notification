import 'package:flutter/material.dart';

class DemoScreen extends StatelessWidget {
  final String id;
  DemoScreen({required this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Demo screen $id"),),
    );
  }
}