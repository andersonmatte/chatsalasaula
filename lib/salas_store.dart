import 'package:chatsalasaula/sala.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';

part 'salas_store.g.dart';

class SalasStore extends ChangeNotifier {

  @observable
  List<Sala> salas = [];

  @action
  Future<void> criarNovaSala(String nome) async {
    final sala = Sala(
      id: '',
      nome: nome,
      usuarios: [],
    );
    await FirebaseFirestore.instance.collection('salas').doc().set(sala.toMap());
    salas.add(sala);
  }

  @action
  Future<void> atualizarSala() async {
    final salasRef = FirebaseFirestore.instance.collection('salas');
    final snapshots = await salasRef.get();
    salas = snapshots.docs.map((doc) => Sala.fromFirestore(doc)).toList();
  }

  @action
  Future<void> entrarNaSala(String salaId) async {
    final sala = FirebaseFirestore.instance.collection('salas').doc(salaId);
    final usuarios = sala.get().data()['usuarios'] as List<String>;
    usuarios.add(FirebaseAuth.instance.currentUser!.uid);
    await sala.update({
      'usuarios': usuarios,
    });
  }

  @action
  Future<void> sairDaSala(String salaId) async {
    final sala = FirebaseFirestore.instance.collection('salas').doc(salaId);
    final usuarios = sala.get().data()['usuarios'] as List<String>;
    usuarios.remove(FirebaseAuth.instance.currentUser!.uid);
    await sala.update({
      'usuarios': usuarios,
    });
  }
}
