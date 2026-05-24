import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../controllers/auth_controller.dart';
import '../../services/firebase_service.dart';
import '../../services/viacep_service.dart';
import '../../utils/constants.dart';
import '../../utils/validators.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _formKey = GlobalKey<FormState>();

  final nomeController = TextEditingController();
  final celularController = TextEditingController();
  final cepController = TextEditingController();
  final ruaController = TextEditingController();
  final bairroController = TextEditingController();
  final cidadeController = TextEditingController();
  final numeroController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final confirmarSenhaController = TextEditingController();

  final authController = AuthController();
  final firebaseService = FirebaseService();

  bool obscureSenha = true;
  bool obscureConfirmar = true;
  bool loading = false;

  String tipoUsuario = 'Aluno';

  // MÁSCARAS
  final celularMask = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final cepMask = MaskTextInputFormatter(
    mask: '#####-###',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Criar Conta'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),

        child: Form(
          key: _formKey,

          child: Column(

            children: [

              const Icon(
                Icons.person_add,
                size: 80,
                color: AppColors.primary,
              ),

              const SizedBox(height: 20),

              DropdownButtonFormField(
                value: tipoUsuario,
                decoration: const InputDecoration(
                  labelText: 'Tipo de Usuário',
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Aluno',
                    child: Text('Aluno'),
                  ),
                  DropdownMenuItem(
                    value: 'Motorista',
                    child: Text('Motorista'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    tipoUsuario = value!;
                  });
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome Completo',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: Validators.validarCampo,
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: celularController,
                keyboardType: TextInputType.phone,
                inputFormatters: [celularMask],
                decoration: const InputDecoration(
                  labelText: 'Celular',
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: Validators.validarCampo,
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: cepController,
                keyboardType: TextInputType.number,
                inputFormatters: [cepMask],
                decoration: const InputDecoration(
                  labelText: 'CEP',
                  prefixIcon: Icon(Icons.location_on),
                ),
                validator: Validators.validarCampo,

                onChanged: (value) async {

                  final cepLimpo = value.replaceAll('-', '');

                  if (cepLimpo.length == 8) {

                    final dados =
                    await ViaCepService.buscarCEP(cepLimpo);

                    ruaController.text =
                        dados?['logradouro'] ?? '';

                    bairroController.text =
                        dados?['bairro'] ?? '';

                    cidadeController.text =
                        dados?['localidade'] ?? '';
                  }
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: ruaController,
                decoration: const InputDecoration(labelText: 'Rua'),
                validator: Validators.validarCampo,
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: numeroController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Número'),
                validator: Validators.validarCampo,
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: bairroController,
                decoration: const InputDecoration(labelText: 'Bairro'),
                validator: Validators.validarCampo,
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: cidadeController,
                decoration: const InputDecoration(labelText: 'Cidade'),
                validator: Validators.validarCampo,
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: Validators.validarEmail,
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: senhaController,
                obscureText: obscureSenha,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscureSenha
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureSenha = !obscureSenha;
                      });
                    },
                  ),
                ),
                validator: Validators.validarSenha,
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: confirmarSenhaController,
                obscureText: obscureConfirmar,
                decoration: InputDecoration(
                  labelText: 'Confirmar Senha',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscureConfirmar
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureConfirmar = !obscureConfirmar;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirme a senha';
                  }
                  if (value != senhaController.text) {
                    return 'As senhas não coincidem';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(

                  onPressed: () async {

                    if (!_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Preencha todos os campos corretamente'),
                        ),
                      );
                      return;
                    }

                    setState(() {
                      loading = true;
                    });

                    try {

                      final erro = await authController.cadastrar(
                        emailController.text.trim(),
                        senhaController.text.trim(),
                      );

                      if (erro != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(erro),
                          ),
                        );
                        return;
                      }

                      final uid =
                      FirebaseAuth.instance.currentUser!.uid;

                      await firebaseService.salvarUsuario(
                        uid: uid,
                        nome: nomeController.text,
                        celular: celularController.text,
                        endereco:
                        '${ruaController.text}, '
                            '${numeroController.text}, '
                            '${bairroController.text}, '
                            '${cidadeController.text}',
                        email: emailController.text,
                        tipoUsuario: tipoUsuario,
                      );

                      if (!mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('Conta criada com sucesso!'),
                        ),
                      );

                      // 🔥 volta para login
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/login',
                        (route) => false,
                      );

                    } catch (e) {

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Erro inesperado: $e'),
                        ),
                      );

                    } finally {
                      setState(() {
                        loading = false;
                      });
                    }
                  },

                  child: loading
                      ? const SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  )
                      : const Text(
                    'Cadastrar',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}