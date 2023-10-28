import 'package:chatsalasaula/sala.dart';
import 'package:chatsalasaula/sala_chat.dart';
import 'package:chatsalasaula/salas_store.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Salas de Chat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            StreamBuilder<List<Sala>>(
              stream: SalasStore.of(context).atualizarSalas(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  final salas = snapshot.data;
                  if (salas!.isNotEmpty) {
                    return ListView.builder(
                      itemCount: salas!.length,
                      itemBuilder: (context, index) {
                        final sala = salas[index];
                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            title: Text(
                              sala.nome,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.pink,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: const Icon(Icons.arrow_forward, color: Colors.pink),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SalaChat(sala: sala),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('Nenhuma sala encontrada'),
                    );
                  }
                }
                return const Center(
                  child: Text('Ocorreu um erro ao carregar as salas'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
