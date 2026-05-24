class Validators {

  static String? validarEmail(String? value) {

    if(value == null || value.isEmpty) {
      return 'Digite um email';
    }

    if(!value.contains('@')) {
      return 'Email inválido';
    }

    return null;
  }

  static String? validarSenha(String? value) {

    if(value == null || value.length < 6) {
      return 'Senha mínima de 6 caracteres';
    }

    return null;
  }

  static String? validarCampo(String? value) {

    if(value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }

    return null;
  }
}