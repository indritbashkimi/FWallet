import 'dart:async';
import 'package:flutter/material.dart';

import 'home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        title: 'Wallet',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          primarySwatch: Colors.pink,
          brightness: Brightness.dark,
        ),
        home: Material(
          child: HomeScreen(title: "Wallet",),
        ));
  }

}
