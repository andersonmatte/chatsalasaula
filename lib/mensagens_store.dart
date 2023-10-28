import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';

import 'mensagem.dart';

part 'mensagens_store.g.dart';

class MensagensStore extends ChangeNotifier {
  @observable
  List<Mensagem> mensagens = [];

  @action
  Future<void> atualizarMensagens(String salaId) async {
    final mensagensRef = FirebaseFirestore.instance
        .collection('salas')
        .doc(salaId)
        .collection('mensagens');
    final snapshots = await mensagensRef.get();
    mensagens = snapshots.docs.map((doc) => Mensagem.fromFirestore(doc)).toList();
  }

  @action
  Future<void> enviarNovaMensagem(String salaId, String texto) async {
    final mensagem = Mensagem(
      id: '',
      salaId: salaId,
      usuario: FirebaseAuth.instance.currentUser!.uid,
      texto: texto,
      data: DateTime.now(),
    );

    await FirebaseFirestore.instance
        .collection('salas')
        .doc(salaId)
        .collection('mensagens')
        .add(mensagem.toMap());
    atualizarMensagens(salaId);
  }
}
