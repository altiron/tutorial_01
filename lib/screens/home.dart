import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget showAppName() {
    return Text("ACare Mall");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(mainAxisSize: MainAxisSize.min,
          children: [showAppName(), showAppName(), showAppName()],
        )),
      ),
    );
  }
}
