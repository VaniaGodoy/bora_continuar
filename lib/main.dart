import 'package:flutter/material.dart';

// Importando a tela principal
import 'screens/todolist.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bora Continuar',

      // ESSA LINHA REMOVE A TARJA VERMELHA DE DEBUG:
      debugShowCheckedModeBanner: false,

      home: new TodoList(),
    );
  }
}