import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/custom_card.dart';

// importa suas páginas
import 'package:flutter_application_1/pages/sub_pages/pag_introducao_meditacao.dart';
import 'package:flutter_application_1/pages/sub_pages/pag_novo_ciclo.dart';
import 'package:flutter_application_1/pages/sub_pages/pag_avancada.dart';

class PagMeditar extends StatelessWidget {
  final bool temaEscuro;
  final VoidCallback? onTrocarTema;

  PagMeditar({super.key, this.temaEscuro = false, this.onTrocarTema});

  // Cada card tem uma página associada
  final List<Map<String, dynamic>> cardList = [
    {
      "icon": Icons.self_improvement,
      "text": "Introdução - Meditação",
      "page": const PagIntroducaoMeditacao(),
    },
    {
      "icon": Icons.access_alarm,
      "text": "Meditação Novo Ciclo",
      "page": const NovoCicloPage(),
    },
    {
      "icon": Icons.spa,
      "text": "Meditação Avançada",
      "page": const AvancadaPage(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;
    final altura = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: temaEscuro ? Colors.black : Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCabecalho(largura),
            SizedBox(height: altura * 0.03),
            _buildCards(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCabecalho(double largura) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: largura * 0.06,
        vertical: largura * 0.05,
      ),
      child: Row(
        children: [
          SizedBox(width: largura * 0.18),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Silencie o mundo.",
                style: TextStyle(
                  color: temaEscuro ? Colors.grey[300] : Colors.blueGrey[400],
                  fontSize: largura * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Ouça a si mesmo.",
                style: TextStyle(
                  color: temaEscuro ? Colors.white : Colors.blue[800],
                  fontSize: largura * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCards(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: cardList.map((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => item["page"]),
                  );
                },
                child: CustomCard(icon: item["icon"], text: item["text"]),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
