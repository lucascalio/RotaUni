import 'package:flutter/material.dart';
import '../controllers/user_controller.dart';
import '../models/user_model.dart';
import '../widgets/custom_button.dart';
import 'home_view.dart';

class ConfirmView extends StatelessWidget {
  final User user;
  final controller = UserController();

  ConfirmView({required this.user});

  void responder(BuildContext context, int vai) async {
    if (user.id != null) {
      await controller.atualizarVai(user.id!, vai);
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomeView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Confirmação")),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.help_outline, size: 80, color: Colors.blue),

              SizedBox(height: 20),

              Text(
                "Você vai para a faculdade hoje?",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 30),

              CustomButton(
                text: "SIM",
                onPressed: () => responder(context, 1),
              ),

              SizedBox(height: 10),

              CustomButton(
                text: "NÃO",
                onPressed: () => responder(context, 0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}