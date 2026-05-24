import 'dart:async';

import 'package:flutter/material.dart';

import '../login/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() =>
      _SplashPageState();
}

class _SplashPageState
    extends State<SplashPage> {

  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 3),

          () {

        Navigator.pushReplacement(

          context,

          MaterialPageRoute(
            builder: (_) =>
            const LoginPage(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        width: double.infinity,

        decoration: const BoxDecoration(

          gradient: LinearGradient(

            colors: [
              Color(0xFF0D1B2A),
              Color(0xFF1B263B),
            ],

            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: const Column(

          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [

            Icon(
              Icons.directions_bus,
              size: 120,
              color: Colors.white,
            ),

            SizedBox(height: 20),

            Text(

              'RotaUni',

              style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}