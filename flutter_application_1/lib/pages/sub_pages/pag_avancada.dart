import 'package:flutter/material.dart';

class AvancadaPage extends StatelessWidget {
  const AvancadaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Meditação Avançada")),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          "Nesta seção você encontrará práticas avançadas de meditação. "
          "São técnicas mais longas e profundas, indicadas para quem já tem experiência.",
          style: TextStyle(fontSize: 18, height: 1.6),
        ),
      ),
    );
  }
}
