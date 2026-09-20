import 'package:flutter/material.dart';

import '../model/exercicio.dart';
import '../util/dbhelper.dart';

class Detalhes extends StatelessWidget {
  final Exercicio exercicio;

  const Detalhes({
    super.key,
    required this.exercicio,
  });

  void excluirExercicio(BuildContext context) async {

    // Mostra uma confirmação antes de excluir
    bool? confirmar = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Excluir exercício"),
          content: const Text(
            "Deseja realmente excluir este exercício?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("CANCELAR"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text("EXCLUIR"),
            ),
          ],
        );
      },
    );

    // Se confirmou a exclusão
    if (confirmar == true) {
      DbHelper helper = DbHelper();

      await helper.deleteExercicio(exercicio.id!);

      // Volta para a lista
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detalhes do exercicio",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              exercicio.nome,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            Text(
              "Grupo muscular: ${exercicio.grupoMuscular}",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 12),

            Text(
              "Séries: ${exercicio.series}",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 12),

            Text(
              "Repetições: ${exercicio.repeticoes}",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 12),

            Text(
              "Duração: ${exercicio.duracao} segundos",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 12),

            Text(
              "Nível: ${exercicio.nivel}",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  excluirExercicio(context);
                },
                child: const Text("EXCLUIR EXERCÍCIO"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}