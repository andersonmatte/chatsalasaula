import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sala.g.dart';

@JsonSerializable()
class Sala {
  String id;
  String nome;
  List<String> usuarios;

  Sala({
    required this.id,
    required this.nome,
    required this.usuarios,
  });

  factory Sala.fromFirestore(DocumentSnapshot doc) {
    return Sala(
      id: doc.id,
      nome: doc['nome'],
      usuarios: List<String>.from(doc['usuarios']),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'nome': nome,
      'usuarios': usuarios,
    };
  }
}
