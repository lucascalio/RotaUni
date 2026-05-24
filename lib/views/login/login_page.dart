import 'package:flutter/material.dart';

import '../../controllers/auth_controller.dart';
import '../../utils/constants.dart';
import '../../utils/validators.dart';

import '../home/home_page.dart';
import '../register/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() =>
      _LoginPageState();
}

class _LoginPageState
    extends State<LoginPage> {

  final _formKey =
  GlobalKey<FormState>();

  final emailController =
  TextEditingController();

  final senhaController =
  TextEditingController();

  final authController =
  AuthController();

  bool obscureSenha = true;

  bool loading = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        width: double.infinity,

        decoration: const BoxDecoration(

          gradient: LinearGradient(

            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,

            colors: [
              Color(0xFF0D1B2A),
              Color(0xFF1B263B),
            ],
          ),
        ),

        child: Center(

          child: SingleChildScrollView(

            padding:
            const EdgeInsets.all(24),

            child: Container(

              padding:
              const EdgeInsets.all(24),

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                BorderRadius.circular(28),

                boxShadow: const [

                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ],
              ),

              child: Form(

                key: _formKey,

                child: Column(

                  children: [

                    const Icon(
                      Icons.directions_bus,
                      size: 90,
                      color: AppColors.primary,
                    ),

                    const SizedBox(height: 16),

                    const Text(

                      'RotaUni',

                      style: TextStyle(
                        fontSize: 34,
                        fontWeight:
                        FontWeight.bold,
                        color:
                        AppColors.primary,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(

                      'Transporte Universitário',

                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 40),

                    TextFormField(

                      controller:
                      emailController,

                      keyboardType:
                      TextInputType.emailAddress,

                      decoration:
                      const InputDecoration(

                        labelText: 'Email',

                        prefixIcon:
                        Icon(Icons.email),
                      ),

                      validator:
                      Validators.validarEmail,
                    ),

                    const SizedBox(height: 20),

                    TextFormField(

                      controller:
                      senhaController,

                      obscureText:
                      obscureSenha,

                      decoration:
                      InputDecoration(

                        labelText: 'Senha',

                        prefixIcon:
                        const Icon(Icons.lock),

                        suffixIcon:
                        IconButton(

                          icon: Icon(

                            obscureSenha
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),

                          onPressed: () {

                            setState(() {
                              obscureSenha =
                              !obscureSenha;
                            });
                          },
                        ),
                      ),

                      validator:
                      Validators.validarSenha,
                    ),

                    const SizedBox(height: 30),

                    SizedBox(

                      width: double.infinity,

                      child: ElevatedButton(

                        onPressed: () async {

                          if(_formKey.currentState!
                              .validate()) {

                            setState(() {
                              loading = true;
                            });

                            final erro =
                            await authController.login(

                              emailController.text
                                  .trim(),

                              senhaController.text
                                  .trim(),
                            );

                            setState(() {
                              loading = false;
                            });

                            if(erro == null) {

                              Navigator.pushReplacement(

                                context,

                                MaterialPageRoute(
                                  builder: (_) =>
                                  const HomePage(),
                                ),
                              );

                            } else {

                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(

                                SnackBar(

                                  backgroundColor:
                                  Colors.red,

                                  content: Text(
                                    erro,
                                  ),
                                ),
                              );
                            }
                          }
                        },

                        child: loading

                            ? const SizedBox(

                          height: 22,
                          width: 22,

                          child:
                          CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )

                            : const Text(

                          'Entrar',

                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextButton(

                      onPressed: () {

                        Navigator.push(

                          context,

                          MaterialPageRoute(
                            builder: (_) =>
                            const RegisterPage(),
                          ),
                        );
                      },

                      child: const Text(

                        'Criar Conta',

                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}