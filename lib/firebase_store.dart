import 'package:chatsalasaula/sala.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'mensagem.dart';

class FirebaseStore {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  static Future<void> signOut() async {
    return await _auth.signOut();
  }

  static Future<DocumentReference> getUsuarioRef() async {
    return _firestore.collection('usuarios').doc(_auth.currentUser!.uid);
  }

  static Future<void> salvarUsuario(UsuarioModel usuario) async {
    await _firestore
        .collection('usuarios')
        .doc(usuario.id)
        .set(usuario.toMap());
  }

  static Future<List<Sala>> getSalas() async {
    final salasRef = _firestore.collection('salas');
    final snapshots = await salasRef.get();
    return snapshots.docs.map((doc) => Sala.fromFirestore(doc)).toList();
  }

  static Future<Sala> getSala(String id) async {
    final sala = _firestore.collection('salas').doc(id);
    final snapshot = await sala.get();
    return Sala.fromFirestore(snapshot);
  }

  static Future<void> criarNovaSala(String nome) async {
    final sala = Sala(
      id: '',
      nome: nome,
      usuarios: [],
    );

    await _firestore.collection('salas').doc().set(sala.toMap());
  }

  static Future<void> entrarNaSala(String salaId) async {
    final sala = _firestore.collection('salas').doc(salaId);
    final usuarios = sala.get().data()['usuarios'] as List<String>;
    usuarios.add(_auth.currentUser!.uid);
    await sala.update({
      'usuarios': usuarios,
    });
  }

  static Future<void> sairDaSala(String salaId) async {
    final sala = _firestore.collection('salas').doc(salaId);
    final usuarios = sala.get().data()['usuarios'] as List<String>;
    usuarios.remove(_auth.currentUser!.uid);
    await sala.update({
      'usuarios': usuarios,
    });
  }

  static Future<List<Mensagem>> getMensagens(String salaId) async {
    final mensagensRef =
        _firestore.collection('salas').doc(salaId).collection('mensagens');
    final snapshots = await mensagensRef.get();
    return snapshots.docs.map((doc) => Mensagem.fromFirestore(doc)).toList();
  }

  static Future<void> enviarNovaMensagem(String salaId, String texto) async {
    final mensagem = Mensagem(
      id: '',
      salaId: salaId,
      usuario: _auth.currentUser!.uid,
      texto: texto,
      data: DateTime.now(),
    );

    await _firestore
        .collection('salas')
        .doc(salaId)
        .collection('mensagens')
        .add(mensagem.toMap());
  }
}
