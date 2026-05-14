class User {
  int? id;
  String nome;
  String telefone;
  String cep;
  String endereco;
  String username;
  String senha;
  String tipo; // aluno ou motorista
  int vai;

  User({
    this.id,
    required this.nome,
    required this.telefone,
    required this.cep,
    required this.endereco,
    required this.username,
    required this.senha,
    required this.tipo,
    this.vai = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'telefone': telefone,
      'cep': cep,
      'endereco': endereco,
      'username': username,
      'senha': senha,
      'tipo': tipo,
      'vai': vai,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      nome: map['nome'],
      telefone: map['telefone'],
      cep: map['cep'],
      endereco: map['endereco'],
      username: map['username'],
      senha: map['senha'],
      tipo: map['tipo'],
      vai: map['vai'],
    );
  }
}