import 'package:flutter/material.dart';
import 'views/login_view.dart';

void main() {
  runApp(RotaUniApp());
}

class RotaUniApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RotaUni',
      debugShowCheckedModeBanner: false,
      home: LoginView(),
    );
  }
}