import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black, // TEXTO PRETO
          textStyle: TextStyle(fontWeight: FontWeight.bold),
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}