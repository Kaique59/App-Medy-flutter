import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/custom_card.dart';

// ignore: must_be_immutable
class AudioPage extends StatelessWidget {
  bool temaEscuro = false;
  final VoidCallback? onTrocarTema;

  AudioPage({super.key, this.temaEscuro = false, this.onTrocarTema});

  final List<dynamic> cardList = [
    {"icon": Icons.nature, "text": "Som da Natureza"},
    {"icon": Icons.water_drop, "text": "Chuva Relaxante"},
    {"icon": Icons.waves, "text": "Ondas do Mar"},
    {"icon": Icons.local_florist, "text": "Floresta ao Amanhecer"},
  ];

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;
    final altura = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCabecalho(largura),
            SizedBox(height: altura * 0.03),
            _buildCards(largura, altura),
          ],
        ),
      ),
    );
  }

  /// Cabeçalho
  Widget _buildCabecalho(double largura) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: largura * 0.06,
        vertical: largura * 0.05,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: largura * 0.07,
            backgroundColor: Colors.transparent,
          ),
          SizedBox(width: largura * 0.1),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Relaxe sua mente.",
                style: TextStyle(
                  color: temaEscuro ? Colors.grey[300] : Colors.blueGrey[400],
                  fontSize: largura * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Escute e sinta a paz.",
                style: TextStyle(
                  color: temaEscuro ? Colors.white : Colors.blue[800],
                  fontSize: largura * 0.06,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: const Offset(1.5, 1.5),
                      blurRadius: 3,
                      color: temaEscuro ? Colors.black54 : Colors.blue[200]!,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Cards de conteúdo
  Widget _buildCards(double largura, double altura) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...cardList.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CustomCard(icon: item["icon"], text: item["text"]),
              );
            }),
          ],
        ),
      ),
    );
  }
}
