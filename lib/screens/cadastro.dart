import 'package:flutter/material.dart';

import '../model/exercicio.dart';
import '../util/dbhelper.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<StatefulWidget> createState() => CadastroState();
}

class CadastroState extends State<Cadastro> {
  DbHelper helper = DbHelper();

  // Controllers para pegar os dados digitados
  TextEditingController nomeController = TextEditingController();
  TextEditingController grupoMuscularController = TextEditingController();
  TextEditingController seriesController = TextEditingController();
  TextEditingController repeticoesController = TextEditingController();
  TextEditingController duracaoController = TextEditingController();

  String nivel = "Iniciante";

  void salvarExercicio() {
    // Cria o objeto Exercicio com os dados da tela
    Exercicio exercicio = Exercicio(
      nomeController.text,
      grupoMuscularController.text,
      int.parse(seriesController.text),
      int.parse(repeticoesController.text),
      int.parse(duracaoController.text),
      nivel,
    );

    // Grava o exercício no banco de dados
    helper.insertExercicio(exercicio);

    // Volta para a tela anterior
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Novo exercicio",
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

        child: SingleChildScrollView(
          child: Column(
            children: [

              TextField(
                controller: nomeController,
                decoration: const InputDecoration(
                  labelText: "Nome do exercício",
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: grupoMuscularController,
                decoration: const InputDecoration(
                  labelText: "Grupo muscular",
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: seriesController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Número de séries",
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: repeticoesController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Número de repetições",
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: duracaoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Duração em segundos",
                ),
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: nivel,
                decoration: const InputDecoration(
                  labelText: "Nível",
                ),
                items: const [
                  DropdownMenuItem(
                    value: "Iniciante",
                    child: Row(
                      children: [
                        // Círculo Verde para Iniciante
                        Icon(Icons.circle, color: Color(0xFF2E7D32), size: 14),
                        SizedBox(width: 10),
                        Text("Iniciante"),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: "Intermediário",
                    child: Row(
                      children: [
                        // Círculo Azul para Intermediário
                        Icon(Icons.circle, color: Color(0xFF1976D2), size: 14),
                        SizedBox(width: 10),
                        Text("Intermediário"),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: "Avançado",
                    child: Row(
                      children: [
                        // Círculo Cinza para Avançado
                        Icon(Icons.circle, color: Color(0xFF616161), size: 14),
                        SizedBox(width: 10),
                        Text("Avançado"),
                      ],
                    ),
                  ),
                ],
                onChanged: (String? novoNivel) {
                  setState(() {
                    nivel = novoNivel!;
                  });
                },
              ),


              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: salvarExercicio,
                child: const Text("SALVAR"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nomeController.dispose();
    grupoMuscularController.dispose();
    seriesController.dispose();
    repeticoesController.dispose();
    duracaoController.dispose();

    super.dispose();
  }
}