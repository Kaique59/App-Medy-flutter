import 'package:flutter/material.dart';
import 'package:flutter_application_1/Config/linha_de_etapas.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_application_1/pages/Audiopage.dart'; // Import da página de áudio

// Classe para cada etapa
class EtapaMeditacao {
  final String titulo;
  final String descricao;

  EtapaMeditacao({required this.titulo, required this.descricao});
}

class PagProposito extends StatefulWidget {
  const PagProposito({super.key});

  @override
  State<PagProposito> createState() => _PagPropositoState();
}

class _PagPropositoState extends State<PagProposito>
    with SingleTickerProviderStateMixin {
  int etapaAtual = 0;

  final List<EtapaMeditacao> instrucoes = [
    EtapaMeditacao(
      titulo: "Conectando-se com o Propósito",
      descricao:
          "Descobrir o próprio propósito é perceber aquilo que realmente dá sentido à vida e nos faz sentir vivos. Ao nos conectarmos com nossos valores, paixões e talentos, nossas ações se tornam mais conscientes e alinhadas com quem realmente somos. Essa clareza transforma decisões diárias, direciona esforços de maneira significativa e promove uma sensação profunda de realização, permitindo que cada passo seja um reflexo do que valorizamos.",
    ),
    EtapaMeditacao(
      titulo: "A Força da Intenção",
      descricao:
          "Cada ação nasce de uma intenção, mesmo que inconsciente. Quando dedicamos momentos à meditação ou reflexão profunda, podemos definir claramente nossas intenções, tornando mente e coração aliados de nossos objetivos mais importantes. Intenção consciente nos ajuda a agir com foco, a superar distrações e a canalizar nossa energia para aquilo que realmente importa, criando resultados que ressoam com nosso verdadeiro eu.",
    ),
    EtapaMeditacao(
      titulo: "Alinhando Paixão e Propósito",
      descricao:
          "O propósito floresce quando está intimamente ligado à nossa paixão. Identificar aquilo que amamos fazer e combiná-lo com nossas metas pessoais cria um caminho cheio de motivação, satisfação e realização. Esse alinhamento nos impulsiona a seguir adiante mesmo diante de desafios, transformando obstáculos em oportunidades de aprendizado, crescimento e evolução contínua, fortalecendo nossa confiança e determinação.",
    ),
    EtapaMeditacao(
      titulo: "Propósito e Transformação Interior",
      descricao:
          "Viver com propósito é permitir que cada dia seja uma oportunidade de evolução e autoconhecimento. Quando nossas ações refletem nossas intenções mais profundas, transformamos hábitos, pensamentos e emoções, tornando-nos mais conscientes, resilientes e alinhados com nosso verdadeiro eu. O propósito atua como um guia silencioso, orientando decisões, fortalecendo a autoestima e nos incentivando a buscar uma vida mais equilibrada e significativa.",
    ),
    EtapaMeditacao(
      titulo: "Ação com Significado",
      descricao:
          "Não basta apenas definir metas; é essencial agir com intenção, consciência e comprometimento. Cada gesto, escolha e decisão pode ser direcionado para aquilo que realmente importa, transformando pequenas ações em grandes passos de crescimento pessoal. Quando vivemos alinhados ao nosso propósito, cada dia se torna uma oportunidade de construir uma vida mais plena, significativa e conectada com nossos valores, despertando satisfação e realização interior.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;
    final altura = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.blue[700],
      body: SafeArea(
        child: Column(
          children: [
            // TOPO
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              color: Colors.blue[700],
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Descubra seu propósito e alinhe-se com o novo ciclo de sua vida através desta meditação.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: largura * 0.04,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // CORPO
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // BOTÕES DE AÇÃO
                      Row(
                        children: [
                          Expanded(
                            child: _actionButton(
                              icon: Icons.track_changes,
                              text: "Guia do Propósito",
                              color: Colors.blue[100]!,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AudioPage(),
                                  ),
                                );
                              },
                              child: _actionButton(
                                icon: Icons.music_note,
                                text: "Sons para concentração",
                                color: Colors.blue[100]!,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),

                      // VÍDEOS
                      const YoutubeVideoCard(
                        videoUrl: "https://www.youtube.com/watch?v=CxDS3MlvwZE",
                        title: "Você sabe o que quer da Vida?",
                        subtitle:
                            "Aprenda a alinhar seu propósito com o próximo ciclo da sua vida.",
                      ),
                      const YoutubeVideoCard(
                        videoUrl: "https://www.youtube.com/watch?v=77vqMkV2QT0",
                        title: "Encontre o seu Propósito de Vida",
                        subtitle:
                            "Descubra o seu propósito e desperte para uma vida plena e significativa.",
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        "Passos para se alinhar com seu propósito e viver plenamente o novo ciclo",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // LINHA DE ETAPAS
                      SizedBox(
                        height: altura * 0.7,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 2,
                              child: LinhaDeEtapas(
                                etapaAtual: etapaAtual,
                                altura: altura,
                                totalEtapas: instrucoes.length,
                                onTap: (index) {
                                  setState(() {
                                    etapaAtual = index;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              flex: 5,
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 400),
                                transitionBuilder: (child, animation) =>
                                    FadeTransition(
                                      opacity: animation,
                                      child: SlideTransition(
                                        position: Tween<Offset>(
                                          begin: const Offset(0.2, 0),
                                          end: Offset.zero,
                                        ).animate(animation),
                                        child: child,
                                      ),
                                    ),
                                child: Column(
                                  key: ValueKey(etapaAtual),
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      instrucoes[etapaAtual].titulo,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      instrucoes[etapaAtual].descricao,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        height: 1.5,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      // FRASE FINAL
                      const Center(
                        child: Text(
                          "Respire profundamente, conecte-se com seu propósito e permita que o novo ciclo floresça.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            color: Colors.blue,
                            height: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.blue, size: 30),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              color: Colors.blue[700],
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class YoutubeVideoCard extends StatelessWidget {
  final String videoUrl;
  final String title;
  final String subtitle;

  const YoutubeVideoCard({
    super.key,
    required this.videoUrl,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              YoutubePlayer(
                controller: YoutubePlayerController(
                  initialVideoId: videoId ?? "",
                  flags: const YoutubePlayerFlags(autoPlay: false),
                ),
                showVideoProgressIndicator: true,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[700]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
