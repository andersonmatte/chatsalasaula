import 'package:chatsalasaula/sala.dart';
import 'package:flutter/material.dart';

import 'mensagem.dart';
import 'mensagens_store.dart';

class SalaChat extends StatelessWidget {
  final Sala sala;

  SalaChat({required this.sala});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sala.nome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<Mensagem>>(
                stream: MensagensStore.of(context).mensagens(sala.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    final mensagens = snapshot.data;
                    if (mensagens!.isNotEmpty) {
                      return ListView.builder(
                        itemCount: mensagens.length,
                        itemBuilder: (context, index) {
                          final mensagem = mensagens[index];
                          return ListTile(
                            leading: CircleAvatar(
                              child: Text(mensagem.usuario[0]),
                            ),
                            title: Text(mensagem.texto),
                            subtitle: Text(mensagem.data.toString()),
                          );
                        },
                      );
                    }
                  }
                  return const Center(
                    child: Text('Nenhuma mensagem encontrada'),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Digite uma mensagem aqui!',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                ),
                onChanged: (texto) {
                  MensagensStore.of(context).enviarMensagem(
                    sala.id,
                    texto,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
