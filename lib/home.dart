import 'package:chatsalasaula/sala.dart';
import 'package:chatsalasaula/sala_chat.dart';
import 'package:chatsalasaula/salas_store.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de salas de chat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            StreamBuilder<List<Sala>>(
              stream: SalasStore.of(context).atualizarSalas(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      final sala = snapshot.data[index];

                      return ListTile(
                        title: Text(sala.nome),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SalaChat(sala: sala),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
                return const Center(
                  child: Text('Nenhuma sala encontrada'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
