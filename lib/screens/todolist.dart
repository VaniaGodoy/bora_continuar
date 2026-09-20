import 'package:flutter/material.dart';

import '../model/exercicio.dart';
import '../util/dbhelper.dart';
import 'cadastro.dart';
import 'detalhes.dart';

// Criando o StatefulWidget...
class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<StatefulWidget> createState() => TodoListState();
}

class TodoListState extends State<TodoList> {

  // Atributos...

  DbHelper helper = DbHelper();

  List<Exercicio>? exercicios;

  int count = 0;

  // Metodo para recuperar os dados.
  void getData() {

    // Abre ou cria o banco de dados
    var dbFuture = helper.initializeDb();

    // Quando o banco estiver aberto...
    dbFuture.then((result) {

      // Recupera todos os exercícios
      var exerciciosFuture = helper.getExercicios();

      // Quando os dados chegarem...
      exerciciosFuture.then((result) {

        // Lista temporária de objetos Exercicio
        List<Exercicio> exercicioList = [];

        // Quantidade de registros
        count = result.length;

        // Percorre os registros
        for (int i = 0; i < count; i++) {
          exercicioList.add(
            Exercicio.fromMap(result[i]),
          );

          // Apenas para conferência
          debugPrint(
            exercicioList[i].nome,
          );
        }

        // Atualiza a tela
        setState(() {
          exercicios = exercicioList;
        });

        debugPrint(
          "Exercícios: " + count.toString(),
        );
      });
    });
  }

  // Metodo auxiliar para definir a cor baseada no nível do exercício
  Color _getCorPorNivel(String? nivel) {
    if (nivel == null) return const Color(0xFF2E7D32); // Fallback de segurança (Verde)

    // Normaliza a string eliminando espaços extras e acentos
    switch (nivel.trim().toLowerCase()) {
      case 'iniciante':
        return const Color(0xFF2E7D32); // Verde
      case 'intermediario':
      case 'intermediário':
        return const Color(0xFF1976D2); // Azul
      case 'avancado':
      case 'avançado':
        return const Color(0xFF616161); // Cinza
      default:
        return const Color(0xFF2E7D32); // Cor padrão caso venha nulo ou diferente
    }
  }

  // Build do widget
  @override
  Widget build(BuildContext context) {

    // Primeira vez que a tela é carregada
    if (exercicios == null) {
      exercicios = [];
      getData();
    }

    return Scaffold(

      // Cor de fundo da tela
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        title: const Text(
          "Bora Continuar",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
      ),

      body: exercicioListItems(),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {

          // Abre a tela de cadastro
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Cadastro(),
            ),
          );

          // Quando voltar, atualiza a lista
          setState(() {
            exercicios = null;
          });
        },

        tooltip: "Adicionar exercício",

        backgroundColor: const Color(0xFF2E7D32),

        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  // Corpo do Scaffold: nossa ListView
  ListView exercicioListItems() {

    return ListView.builder(

      padding: const EdgeInsets.all(12),

      itemCount: count,

      itemBuilder: (
          BuildContext context,
          int position,
          ) {

        return Card(

          color: Colors.white,

          elevation: 2.0,

          margin: const EdgeInsets.only(
            bottom: 12,
          ),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),

          child: ListTile(

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),

            // Número de séries
            leading: CircleAvatar(
              radius: 12,
              backgroundColor: _getCorPorNivel(exercicios![position].nivel),
            ),

            // Nome do exercício
            title: Text(
              exercicios![position].nome,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),

            // Outras informações
            subtitle: Padding(
              padding: const EdgeInsets.only(
                top: 6,
              ),
              child: Text(
                '${exercicios![position].grupoMuscular}\n'
                    '${exercicios![position].series} séries • '
                    '${exercicios![position].repeticoes} repetições\n'
                    '${exercicios![position].duracao} segundos • '
                    '${exercicios![position].nivel}',
              ),
            ),

            // Ícone no final
            trailing: const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),

            // Quando clicar no exercício
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Detalhes(
                    exercicio: exercicios![position],
                  ),
                ),
              );

              // Atualiza a lista ao voltar
              setState(() {
                exercicios = null;
              });
            },
          ),
        );
      },
    );
  }
}