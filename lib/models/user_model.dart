class User {
  int? id;
  String nome;
  String cep;
  String endereco;
  int vai;

  User({
    this.id,
    required this.nome,
    required this.cep,
    required this.endereco,
    this.vai = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'cep': cep,
      'endereco': endereco,
      'vai': vai,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      nome: map['nome'],
      cep: map['cep'],
      endereco: map['endereco'],
      vai: map['vai'],
    );
  }
}