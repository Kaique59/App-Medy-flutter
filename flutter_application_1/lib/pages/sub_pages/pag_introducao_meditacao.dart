import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PagIntroducaoMeditacao extends StatelessWidget {
  const PagIntroducaoMeditacao({super.key});

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: SafeArea(
        child: Column(
          children: [
            // TOPO COM BOTÃO VOLTAR + FRASE
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              color: Colors.blue[800],
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
                    "Nem tudo que é enfrentado pode ser mudado, "
                    "mas nada pode ser mudado até que seja enfrentado.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: largura * 0.05,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // ÁREA BRANCA ARREDONDADA
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    // BOTÕES DE AÇÃO
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: _actionButton(
                              icon: Icons.air,
                              text: "Exercício de respiração",
                              color: Colors.purple[100]!,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _actionButton(
                              icon: Icons.music_note,
                              text: "Sons relaxantes",
                              color: Colors.purple[100]!,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // CONTEÚDO COM VÍDEOS E TEXTO
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Aqui está o seu programa do dia!",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Conteúdo escolhido a dedo para você",
                              style: TextStyle(color: Colors.black54),
                            ),
                            SizedBox(height: 16),

                            // Primeiro vídeo
                            YoutubeVideoCard(
                              videoUrl:
                                  "https://www.youtube.com/watch?v=1MrQPZuSs7A",
                              title: "Comece sua jornada",
                              subtitle:
                                  "Uma introdução guiada à respiração consciente.",
                            ),

                            SizedBox(height: 16),

                            // Segundo vídeo
                            YoutubeVideoCard(
                              videoUrl:
                                  "https://www.youtube.com/watch?v=32UM11dSves",
                              title: "Respire e desacelere",
                              subtitle:
                                  "Exercício de respiração para clarear a mente.",
                            ),

                            SizedBox(height: 16),

                            // Texto que eu peguei do GPT
                            Text(
                              "Introdução à Meditação",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "A meditação é uma prática simples, mas poderosa, que nos ajuda a encontrar calma, foco e equilíbrio no dia a dia. "
                              "Não importa sua experiência ou idade: qualquer pessoa pode começar, mesmo dedicando apenas alguns minutos por dia.\n\n"
                              "Meditar é aprender a observar seus pensamentos e sentimentos sem julgamento, respirando de forma consciente e se conectando com o momento presente. "
                              "É um espaço seguro para desacelerar, aliviar o estresse e cultivar uma sensação de bem-estar interior.\n\n"
                              "Ao iniciar, você pode perceber que a mente se dispersa com facilidade, mas isso é natural. "
                              "A prática constante ajuda a aumentar a atenção, reduzir a ansiedade e desenvolver uma relação mais gentil consigo mesmo.\n\n"
                              "A meditação não exige equipamentos especiais nem locais sofisticados — apenas um lugar tranquilo, postura confortável e disposição para se conectar consigo mesmo. "
                              "Comece hoje e descubra como alguns minutos de atenção plena podem transformar seu dia.",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // BOTÃO DE AÇÃO RÁPIDA
  static Widget _actionButton({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.purple),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

// CARD DE VÍDEO YOUTUBE
class YoutubeVideoCard extends StatefulWidget {
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
  State<YoutubeVideoCard> createState() => _YoutubeVideoCardState();
}

class _YoutubeVideoCardState extends State<YoutubeVideoCard> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl)!;
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.blue,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.subtitle,
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
