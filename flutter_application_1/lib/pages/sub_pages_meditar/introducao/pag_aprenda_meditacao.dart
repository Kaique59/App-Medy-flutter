import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Config/app_scroll_card.dart';
import 'package:flutter_application_1/Config/video_play_list.dart';
import 'package:flutter_application_1/pages/hub_page_view.dart'; // ← Importante
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class EtapaMeditacao {
  final String titulo;
  final String descricao;

  EtapaMeditacao({required this.titulo, required this.descricao});
}

class PagAprendaMeditacao extends StatefulWidget {
  const PagAprendaMeditacao({super.key});

  @override
  State<PagAprendaMeditacao> createState() => _PagAprendaMeditacaoState();
}

class _PagAprendaMeditacaoState extends State<PagAprendaMeditacao> {
  final List<EtapaMeditacao> instrucoes = [
    EtapaMeditacao(
      titulo: "O Início da Jornada",
      descricao:
          "Meditar começa com o simples ato de parar. Sentar, fechar os olhos e permitir-se estar. Não é sobre “fazer certo”, mas sobre se aproximar de si mesmo. Cada respiração é um convite para voltar ao presente — e o presente é onde tudo começa.",
    ),
    EtapaMeditacao(
      titulo: "O Encontro com o Silêncio",
      descricao:
          "Nos primeiros momentos, a mente pode parecer barulhenta. Pensamentos correm, lembranças surgem, distrações aparecem. Não lute contra isso. Observe. O silêncio não chega de repente — ele nasce da aceitação.",
    ),
    EtapaMeditacao(
      titulo: "O Tempo e a Paciência",
      descricao:
          "Comece devagar. Um minuto, depois três, depois cinco. O tempo se ajusta ao seu ritmo. O importante é a constância, não a duração. Cada pequeno instante de presença é uma semente que, com o tempo, floresce em serenidade.",
    ),
    EtapaMeditacao(
      titulo: "A Mente que Aprende a Observar",
      descricao:
          "Com a prática, os pensamentos deixam de ser inimigos e passam a ser visitantes. Você aprende a observá-los com leveza, sem se prender a nenhum. Essa é a essência da meditação: ser o espaço onde tudo acontece, e nada se perde.",
    ),
    EtapaMeditacao(
      titulo: "O Momento de Clareza",
      descricao:
          "Em algum ponto da jornada, você percebe que não está mais buscando paz — você é a paz. A vida continua igual por fora, mas por dentro há calma, leveza e compreensão. Meditar é isso: viver desperto em cada respiração.",
    ),
  ];

  final Color fundoClaro = const Color(0xFFEBE8E0);
  final Color verdePrincipal = const Color(0xFF7A9591);
  final Color verdeBotao = Colors.grey[400]!;
  final Color verdeContorno = const Color(0xFFA4A4A4);

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;
    final altura = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: verdePrincipal,
      body: SafeArea(
        child: Column(
          children: [
            // TOPO
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
              color: verdePrincipal,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: fundoClaro),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "A meditação é a arte de acalmar a mente e harmonizar corpo e espírito.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: fundoClaro,
                      fontSize: largura * 0.040,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),

            // CORPO
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: fundoClaro,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // BOTÕES DE AÇÃO
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                // ✅ Volta para a Home com menu
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const HubPageView(initialIndex: 0),
                                  ),
                                  (route) => false,
                                );
                              },
                              child: _actionButton(
                                icon: CupertinoIcons.house_fill,
                                text: "Home",
                                backgroundColor: verdeBotao,
                                borderColor: verdeContorno,
                                iconTextColor: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                // ✅ Vai para aba "Áudios" com menu
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const HubPageView(initialIndex: 2),
                                  ),
                                  (route) => false,
                                );
                              },
                              child: _actionButton(
                                icon: CupertinoIcons.music_note_2,
                                text: "Sons relaxantes",
                                backgroundColor: verdeBotao,
                                borderColor: verdeContorno,
                                iconTextColor: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // PASSOS PARA MEDITAÇÃO
                      Text(
                        "Passos para aprender meditação",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: verdePrincipal,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // 🔽 CARD MAIOR
                      AppScrollCard<EtapaMeditacao>(
                        items: instrucoes,
                        height: altura * 0.35,
                        activeDotColor: verdePrincipal,
                        inactiveDotColor: Colors.grey[400]!,
                        itemBuilder: (etapa) {
                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  etapa.titulo,
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: verdePrincipal,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  etapa.descricao,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    height: 1.4,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 30),

                      // VÍDEOS
                      ...VideoPlayList.videoListAprendaMetidacao.map((video) {
                        return YoutubeVideoCard(
                          videoUrl: video["videoUrl"]!,
                          title: video["title"]!,
                          subtitle: video["subtitle"]!,
                        );
                      }),

                      const SizedBox(height: 20),
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
    required Color backgroundColor,
    required Color borderColor,
    required Color iconTextColor,
  }) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconTextColor, size: 26),
          const SizedBox(width: 15),
          Text(
            text,
            style: TextStyle(
              color: iconTextColor,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

// --- CARD DE VÍDEO ---
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
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              YoutubePlayer(
                controller: YoutubePlayerController(
                  initialVideoId: videoId ?? "",
                  flags: const YoutubePlayerFlags(autoPlay: false),
                ),
                showVideoProgressIndicator: true,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[700], fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
