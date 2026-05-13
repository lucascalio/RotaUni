import 'package:flutter/material.dart';
import 'register_view.dart';

class LoginView extends StatelessWidget {
  final TextEditingController nome = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("RotaUni")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nome,
              decoration: InputDecoration(labelText: "Nome"),
            ),
            ElevatedButton(
              child: Text("Entrar"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => RegisterView()),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}