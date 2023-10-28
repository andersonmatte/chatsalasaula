import 'package:chatsalasaula/salas_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/firebase_store.dart';
import 'package:flutter_chat_app/stores/salas_store.dart';
import 'package:flutter_chat_app/stores/mensagens_store.dart';
import 'package:provider/provider.dart';

import 'firebase_store.dart';
import 'home.dart';
import 'mensagens_store.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseStore.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SalasStore()),
        ChangeNotifierProvider(create: (_) => MensagensStore()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat com salas',
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: Home(),
      ),
    ),
  );
}
