import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../services/cep_service.dart';
import '../widgets/custom_button.dart';
import '../controllers/user_controller.dart';
import '../models/user_model.dart';
import '../utils/hash_util.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();

  final nomeController = TextEditingController();
  final telefoneController = TextEditingController();
  final cepController = TextEditingController();
  final ruaController = TextEditingController();
  final numeroController = TextEditingController();
  final bairroController = TextEditingController();
  final cidadeController = TextEditingController();
  final usernameController = TextEditingController();
  final senhaController = TextEditingController();

  final controller = UserController();

  String tipoUsuario = "aluno";

  // MÁSCARAS
  final cepMask = MaskTextInputFormatter(mask: '#####-###');
  final telefoneMask =
      MaskTextInputFormatter(mask: '(##) #####-####');

  void buscarCep(String cep) async {
    if (cep.length == 9) {
      final endereco = await CepService.getEndereco(cep.replaceAll("-", ""));
      final partes = endereco.split("-");
      ruaController.text = partes[0];
      cidadeController.text = partes.last;
    }
  }

  void cadastrar() async {
    if (_formKey.currentState!.validate()) {
      User user = User(
        nome: nomeController.text,
        telefone: telefoneController.text,
        cep: cepController.text,
        endereco:
            "${ruaController.text}, ${numeroController.text} - ${bairroController.text} - ${cidadeController.text}",
        username: usernameController.text,
        senha: HashUtil.gerarHash(senhaController.text),
        tipo: tipoUsuario,
      );

      bool sucesso = await controller.inserir(user);

      if (sucesso) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Cadastro realizado com sucesso!")),
        );

        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Usuário já existe")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastro")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // DADOS PESSOAIS
                Text("Dados Pessoais",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                TextFormField(
                  controller: nomeController,
                  decoration: InputDecoration(hintText: "Nome completo"),
                  validator: (v) =>
                      v!.length < 3 ? "Nome inválido" : null,
                ),

                TextFormField(
                  controller: telefoneController,
                  inputFormatters: [telefoneMask],
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(hintText: "Telefone"),
                  validator: (v) =>
                      v!.length < 14 ? "Telefone inválido" : null,
                ),

                SizedBox(height: 20),

                // ENDEREÇO
                Text("Endereço",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                TextFormField(
                  controller: cepController,
                  inputFormatters: [cepMask],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: "CEP"),
                  onChanged: buscarCep,
                  validator: (v) =>
                      v!.length < 9 ? "CEP inválido" : null,
                ),

                TextFormField(
                  controller: ruaController,
                  decoration: InputDecoration(hintText: "Rua"),
                ),

                TextFormField(
                  controller: numeroController,
                  decoration: InputDecoration(hintText: "Número"),
                ),

                TextFormField(
                  controller: bairroController,
                  decoration: InputDecoration(hintText: "Bairro"),
                ),

                TextFormField(
                  controller: cidadeController,
                  decoration: InputDecoration(hintText: "Cidade"),
                ),

                SizedBox(height: 20),

                // LOGIN
                Text("Acesso",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(hintText: "Usuário"),
                  validator: (v) =>
                      v!.length < 4 ? "Usuário inválido" : null,
                ),

                TextFormField(
                  controller: senhaController,
                  obscureText: true,
                  decoration: InputDecoration(hintText: "Senha"),
                  validator: (v) =>
                      v!.length < 4 ? "Senha muito curta" : null,
                ),

                SizedBox(height: 20),

                CustomButton(text: "Cadastrar", onPressed: cadastrar),
              ],
            ),
          ),
        ),
      ),
    );
  }
}