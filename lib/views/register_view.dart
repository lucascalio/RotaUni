import 'package:flutter/material.dart';
import '../controllers/user_controller.dart';
import '../models/user_model.dart';
import '../services/cep_service.dart';
import '../widgets/custom_button.dart';
import 'confirm_view.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final nomeController = TextEditingController();
  final cepController = TextEditingController();

  String endereco = "";
  final controller = UserController();

  void buscarCep() async {
    endereco = await CepService.getEndereco(cepController.text);
    setState(() {});
  }

  void cadastrar() async {
    User user = User(
      nome: nomeController.text,
      cep: cepController.text,
      endereco: endereco,
    );

    await controller.inserir(user);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ConfirmView(user: user)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastro")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(labelText: "Nome"),
            ),

            TextField(
              controller: cepController,
              decoration: InputDecoration(labelText: "CEP"),
            ),

            SizedBox(height: 10),

            CustomButton(
              text: "Buscar CEP",
              onPressed: buscarCep,
            ),

            SizedBox(height: 10),

            Text(endereco),

            SizedBox(height: 20),

            CustomButton(
              text: "Cadastrar",
              onPressed: cadastrar,
            ),
          ],
        ),
      ),
    );
  }
}