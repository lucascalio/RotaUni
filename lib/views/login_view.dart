import 'package:flutter/material.dart';
import '../controllers/user_controller.dart';
import '../utils/hash_util.dart';
import '../widgets/custom_button.dart';
import 'register_view.dart';
import 'home_view.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final usernameController = TextEditingController();
  final senhaController = TextEditingController();
  final controller = UserController();

  String tipoUsuario = "aluno";

  void login() async {
    if (usernameController.text.isEmpty ||
        senhaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Preencha todos os campos")),
      );
      return;
    }

    final senhaHash = HashUtil.gerarHash(senhaController.text);

    final user = await controller.login(
      usernameController.text,
      senhaHash,
      tipoUsuario,
    );

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeView()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login inválido")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.directions_bus, size: 80, color: Colors.blue),

            SizedBox(height: 20),

            Text("RotaUni",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),

            SizedBox(height: 30),

            // TIPO USUÁRIO
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: Text("Aluno"),
                  selected: tipoUsuario == "aluno",
                  onSelected: (_) =>
                      setState(() => tipoUsuario = "aluno"),
                ),
                SizedBox(width: 10),
                ChoiceChip(
                  label: Text("Motorista"),
                  selected: tipoUsuario == "motorista",
                  onSelected: (_) =>
                      setState(() => tipoUsuario = "motorista"),
                ),
              ],
            ),

            SizedBox(height: 20),

            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                hintText: "Digite seu usuário",
                prefixIcon: Icon(Icons.person),
              ),
            ),

            SizedBox(height: 15),

            TextField(
              controller: senhaController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Digite sua senha",
                prefixIcon: Icon(Icons.lock),
              ),
            ),

            SizedBox(height: 20),

            CustomButton(text: "Entrar", onPressed: login),

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => RegisterView()),
                );
              },
              child: Text("Criar conta"),
            )
          ],
        ),
      ),
    );
  }
}