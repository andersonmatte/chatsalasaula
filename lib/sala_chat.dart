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
            // Lista de mensagens
            StreamBuilder<List<Mensagem>>(
              stream: MensagensStore.of(context).mensagens(sala.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final mensagem = snapshot.data![index];

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
                return const Center(
                  child: Text('Nenhuma mensagem encontrada'),
                );
              },
            ),
            // Input para enviar mensagem
            TextField(
              decoration: const InputDecoration(
                hintText: 'Digite uma mensagem aqui!',
              ),
              onChanged: (texto) {
                MensagensStore.of(context).enviarMensagem(
                  sala.id,
                  texto,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
