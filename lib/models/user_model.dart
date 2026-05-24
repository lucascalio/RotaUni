class UserModel {
  String nome;
  String celular;
  String endereco;
  String email;
  String tipoUsuario;

  UserModel({
    required this.nome,
    required this.celular,
    required this.endereco,
    required this.email,
    required this.tipoUsuario,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'celular': celular,
      'endereco': endereco,
      'email': email,
      'tipoUsuario': tipoUsuario,
    };
  }
}