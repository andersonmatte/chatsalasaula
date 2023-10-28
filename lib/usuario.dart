import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  final String id;
  final String nome;
  final String email;

  const Usuario({
    required this.id,
    required this.nome,
    required this.email,
  });

  @override
  List<Object?> get props => [id, nome, email];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
    };
  }

  static Usuario fromFirestore(DocumentSnapshot snapshot) {
    return Usuario(
      id: snapshot.id,
      nome: snapshot['nome'] as String,
      email: snapshot['email'] as String,
    );
  }
}
