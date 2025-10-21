import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Config/app_scroll_card.dart';
import 'package:flutter_application_1/Config/video_play_list.dart';
import 'package:flutter_application_1/pages/Audiopage.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_application_1/pages/home_page.dart';

// Classe para cada etapa
class EtapaMenteCorpo {
  final String titulo;
  final String descricao;

  EtapaMenteCorpo({required this.titulo, required this.descricao});
}

class PagMenteCorpo extends StatefulWidget {
  const PagMenteCorpo({super.key});

  @override
  State<PagMenteCorpo> createState() => _PagMenteCorpoState();
}

class _PagMenteCorpoState extends State<PagMenteCorpo> {
  final List<EtapaMenteCorpo> instrucoes = [
    EtapaMenteCorpo(
      titulo: "O Corpo como Porta de Entrada",
      descricao:
          "Tudo começa no corpo. Ele é o primeiro mestre, o primeiro espelho da mente. Cada respiração, cada batida do coração, cada tensão guardada revela algo sobre o que se passa dentro. Quando o corpo é ouvido com atenção, a mente começa a se aquietar.",
    ),
    EtapaMenteCorpo(
      titulo: "A Energia que Flui",
      descricao:
          "Na respiração consciente, a energia se move livremente. O ar não é apenas ar — é vida, é presença. Ao inspirar, o corpo se renova; ao expirar, ele se purifica. A harmonia entre mente e corpo nasce dessa dança invisível entre movimento e quietude.",
    ),
    EtapaMenteCorpo(
      titulo: "O Olhar Interno",
      descricao:
          "Quando você observa o corpo com serenidade, sem julgamento, a mente aprende a ver com clareza. Surge uma nova percepção: o corpo não é um obstáculo, mas um canal. Cada sensação é uma mensagem, cada desconforto, um convite à escuta.",
    ),
    EtapaMenteCorpo(
      titulo: "A Unidade Silenciosa",
      descricao:
          "No estado avançado de meditação, não há separação entre o que sente e o que pensa. O corpo respira, a mente observa, e ambos se tornam um só fluxo de consciência. É como se a vida inteira se movesse dentro de você, em perfeita harmonia.",
    ),
    EtapaMenteCorpo(
      titulo: "O Templo Interior",
      descricao:
          "Quando mente e corpo se unem, nasce o verdadeiro equilíbrio. O corpo se torna o templo da presença, e a mente, o altar do silêncio. Nesse espaço sagrado, não há esforço nem busca — apenas o simples e profundo ato de existir plenamente desperto.",
    ),
  ];

  // Cores padrão
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
                    "Cultive o equilíbrio entre mente e corpo através da respiração e da consciência plena.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
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
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AudioPage(),
                                  ),
                                );
                              },
                              child: _actionButton(
                                icon: CupertinoIcons.music_note_2,
                                text: "Sons Relaxantes",
                                backgroundColor: verdeBotao,
                                borderColor: verdeContorno,
                                iconTextColor: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      // PASSOS
                      Text(
                        "Passos para integrar mente e corpo",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: verdePrincipal,
                        ),
                      ),
                      const SizedBox(height: 20),

                      AppScrollCard<EtapaMenteCorpo>(
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

                      ...VideoPlayList.videoListMenteCorpo.map((video) {
                        return YoutubeVideoCard(
                          videoUrl: video["videoUrl"]!,
                          title: video["title"]!,
                          subtitle: video["subtitle"]!,
                        );
                      }),

                      const SizedBox(height: 20),
                      const Center(
                        child: Text(
                          "Corpo e mente caminham juntos. Quando você acalma um, o outro se harmoniza naturalmente.",
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
