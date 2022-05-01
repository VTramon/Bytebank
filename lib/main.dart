// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, no_logic_in_create_state

import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ByteBank());
}

class ByteBank extends StatefulWidget {
  ByteBank({Key? key}) : super(key: key);

  @override
  State<ByteBank> createState() {
    return _ByteBankState();
  }
}

class _ByteBankState extends State<ByteBank> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ByteBank',
      theme: ThemeData(
        fontFamily: 'Work Sans',
        primaryColor: Colors.deepPurple,
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: Colors.deepPurple),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                textStyle:
                    MaterialStateProperty.all(TextStyle(color: Colors.white70)),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.deepPurple))),
        buttonTheme: ButtonThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.deepPurple,
          ),
        ),
      ),
      home: Dashboard(),
    );
  }
}
