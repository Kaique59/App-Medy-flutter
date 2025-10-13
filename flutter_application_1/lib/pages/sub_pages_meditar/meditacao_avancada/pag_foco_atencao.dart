import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Config/app_scroll_card.dart';
import 'package:flutter_application_1/Config/video_play_list.dart';
import 'package:flutter_application_1/pages/Audiopage.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// Classe para cada etapa
class EtapaMeditacao {
  final String titulo;
  final String descricao;

  EtapaMeditacao({required this.titulo, required this.descricao});
}

class PagFocoAtencao extends StatefulWidget {
  const PagFocoAtencao({super.key});

  @override
  State<PagFocoAtencao> createState() => _PagFocoAtencaoState();
}

class _PagFocoAtencaoState extends State<PagFocoAtencao> {
  final List<EtapaMeditacao> instrucoes = [
    EtapaMeditacao(
      titulo: "Preparação Mental",
      descricao:
          "Antes de iniciar, libere distrações externas. Sente-se confortavelmente e feche os olhos para preparar a mente para concentração profunda.",
    ),
    EtapaMeditacao(
      titulo: "Respiração Consciente",
      descricao:
          "A atenção plena começa na respiração. Observe cada inspiração e expiração, percebendo o fluxo do ar e o ritmo natural do corpo.",
    ),
    EtapaMeditacao(
      titulo: "Foco no Momento Presente",
      descricao:
          "Direcione toda a sua atenção ao momento presente. Sempre que pensamentos surgirem, reconheça-os sem julgamento e volte ao foco da meditação.",
    ),
    EtapaMeditacao(
      titulo: "Ancorando a Atenção",
      descricao:
          "Escolha um ponto de referência, como uma sensação corporal, som ou imagem mental, e use-o para manter a atenção estável durante a prática.",
    ),
    EtapaMeditacao(
      titulo: "Expansão da Consciência",
      descricao:
          "Após dominar a concentração, expanda sua atenção para incluir pensamentos, emoções e ambiente de forma consciente, mantendo a calma e o equilíbrio interno.",
    ),
  ];

  // CORES PADRÃO DO APP (sem azul)
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
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Aprofunde sua atenção e melhore sua capacidade de foco com esta prática de meditação avançada.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: largura * 0.035,
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
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ),
                                );
                              },
                              child: _actionButton(
                                icon: Icons.home,
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AudioPage(),
                                  ),
                                );
                              },
                              child: _actionButton(
                                icon: CupertinoIcons.music_note_2,
                                text: "Sons para concentração",
                                backgroundColor: verdeBotao,
                                borderColor: verdeContorno,
                                iconTextColor: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // PASSOS PARA FOCO E ATENÇÃO
                      Text(
                        "Passos para desenvolver foco e atenção plena",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: verdePrincipal,
                        ),
                      ),
                      const SizedBox(height: 20),

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
                      ...VideoPlayList.videoListFocoAtencao.map((video) {
                        return YoutubeVideoCard(
                          videoUrl: video["videoUrl"]!,
                          title: video["title"]!,
                          subtitle: video["subtitle"]!,
                        );
                      }),

                      const SizedBox(height: 20),
                      const Center(
                        child: Text(
                          "Mantenha sua atenção no presente, respire com consciência e permita que seu foco se fortaleça a cada instante.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            color: Colors.blueGrey,
                            height: 1.4,
                          ),
                        ),
                      ),
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

  // BOTÃO PERSONALIZADO
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
          const SizedBox(width: 8), // 👈 espaço entre ícone e texto
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
