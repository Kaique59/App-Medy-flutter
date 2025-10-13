import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/sub_pages_meditar/meditacao_avancada/pag_mente_corpo.dart';
import 'package:flutter_application_1/widgets/custom_card_meditar.dart';
import 'package:flutter_application_1/pages/sub_pages_meditar/introducao/pag_respiracao.dart';
import 'package:flutter_application_1/pages/sub_pages_meditar/introducao/pag_aprenda_meditacao.dart';
import 'package:flutter_application_1/pages/sub_pages_meditar/introducao/pag_relaxar.dart';
import 'package:flutter_application_1/pages/sub_pages_meditar/novo_ciclo/pag_equilibrio.dart';
import 'package:flutter_application_1/pages/sub_pages_meditar/novo_ciclo/pag_proposito.dart';
import 'package:flutter_application_1/pages/sub_pages_meditar/novo_ciclo/pag_aceitacao.dart';
import 'package:flutter_application_1/pages/sub_pages_meditar/meditacao_avancada/pag_foco_atencao.dart';
import 'package:flutter_application_1/pages/sub_pages_meditar/meditacao_avancada/pag_calma_interior.dart';

class PagMeditar extends StatelessWidget {
  final bool temaEscuro;
  final VoidCallback? onTrocarTema;

  const PagMeditar({super.key, this.temaEscuro = false, this.onTrocarTema});

  final Map<String, List<Map<String, dynamic>>> sections = const {
    "Introdução-Meditação": [
      {"text": "Respiração", "page": PagRespiracao()},
      {"text": "Relaxamento", "page": PagRelaxar()},
      {"text": "Comece a Meditar", "page": PagAprendaMeditacao()},
    ],
    "Meditação Novo Ciclo": [
      {"text": "Equilíbrio", "page": PagEquilibrio()},
      {"text": "Propósito", "page": PagProposito()},
      {"text": "Aceitação", "page": PagAceitacao()},
    ],
    "Meditação Avançada": [
      {"text": "Foco e Atenção", "page": PagFocoAtencao()},
      {"text": "Calma Interior", "page": PagCalmaInterior()},
      {"text": "Mente e Corpo", "page": PagMenteCorpo()},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFEBE8E0),
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
                    color: const Color(0xFFA0C8C0),
                    fontSize: largura * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Ouça a si mesmo.",
                  style: TextStyle(
                    color: const Color(0xFF748D88),
                    fontSize: largura * 0.06,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: const Offset(1.5, 1.5),
                        blurRadius: 3,
                        color: Colors.blue[200]!,
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
