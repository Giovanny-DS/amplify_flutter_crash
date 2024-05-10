import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Widget that show hello world
class HelloWorld extends StatefulWidget {
  /// Constructor
  const HelloWorld({super.key});

  /// User login view path naming
  static const String routeName = '/hellow-world';

  @override
  State<HelloWorld> createState() => _HelloWorldState();
}

class _HelloWorldState extends State<HelloWorld> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations(<DeviceOrientation>[DeviceOrientation.portraitUp]);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 100,
          title: const Text('Hello World'),
        ),
        backgroundColor: Colors.grey,
        body: const Center(child: Text('hello world')),
      ),
    );
  }
}
