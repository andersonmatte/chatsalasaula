import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mensagem.g.dart';

@JsonSerializable()
class Mensagem {
  String id;
  String salaId;
  String usuario;
  String texto;
  DateTime data;

  Mensagem({
    required this.id,
    required this.salaId,
    required this.usuario,
    required this.texto,
    required this.data,
  });

  factory Mensagem.fromFirestore(DocumentSnapshot doc) {
    return Mensagem(
      id: doc.id,
      salaId: doc['salaId'],
      usuario: doc['usuario'],
      texto: doc['texto'],
      data: (doc['data'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'salaId': salaId,
      'usuario': usuario,
      'texto': texto,
      'data': data,
    };
  }
}
