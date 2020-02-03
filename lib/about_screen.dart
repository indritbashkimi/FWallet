import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'About';

    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
      ),
      body: AboutScreenState(),
    );
  }
}

class AboutScreenState extends StatefulWidget {
  @override
  AboutScreenStateState createState() {
    return AboutScreenStateState();
  }
}

class AboutScreenStateState extends State<AboutScreenState> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Build with Flutter"));
  }
}
