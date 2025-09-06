import 'package:flutter/material.dart';

class NovoCicloPage extends StatelessWidget {
  const NovoCicloPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Meditação Novo Ciclo")),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          "Aqui você poderá praticar a meditação do Novo Ciclo. "
          "Esse espaço será desenvolvido para aprofundar seus exercícios de respiração e foco.",
          style: TextStyle(fontSize: 18, height: 1.6),
        ),
      ),
    );
  }
}
