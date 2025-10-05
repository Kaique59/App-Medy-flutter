import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/custom_card_meditar.dart';

// importa suas páginas de destino
import 'package:flutter_application_1/pages/sub_pages_meditar/introducao/pag_respiracao.dart';
import 'package:flutter_application_1/pages/sub_pages_meditar/pag_novo_ciclo.dart';
import 'package:flutter_application_1/pages/sub_pages_meditar/introducao/pag_relaxar.dart';

class PagMeditar extends StatelessWidget {
  final bool temaEscuro;
  final VoidCallback? onTrocarTema;

  const PagMeditar({super.key, this.temaEscuro = false, this.onTrocarTema});

  // Seções e seus cards
  final Map<String, List<Map<String, dynamic>>> sections = const {
    "Introdução-Meditação": [
      {"text": "Respiração Guiada", "page": PagRespiracao()},
      {"text": "Relaxamento", "page": NovoCicloPage()},
      {"text": "Mindfulness", "page": PagRelaxar()},
    ],
    "Meditação Novo Ciclo": [
      {"text": "Equilíbrio Interior", "page": PagRespiracao()},
      {"text": "Harmonia da mente", "page": NovoCicloPage()},
      {"text": "Despertar da alma", "page": PagRelaxar()},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            _buildCabecalho(largura),
            const SizedBox(height: 20),
            ...sections.entries.map((section) {
              return _buildSection(context, section.key, section.value);
            }).toList(),
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
          CircleAvatar(
            radius: largura * 0.07,
            backgroundColor: Colors.transparent,
          ),
          SizedBox(width: largura * 0.03),
          Padding(
            padding: EdgeInsets.only(left: largura * 0.05),
            child: Column(
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
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String sectionTitle,
    List<Map<String, dynamic>> items,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sectionTitle,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 0.7,
            children: items.map((item) {
              return CustomCardMeditar(
                text: item["text"],
                imagePath: "assets/images/exemplo.png",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => item["page"]),
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
