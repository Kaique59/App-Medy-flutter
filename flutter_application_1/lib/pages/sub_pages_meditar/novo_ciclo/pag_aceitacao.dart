import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Config/app_scroll_card.dart';
import 'package:flutter_application_1/Config/video_play_list.dart';
import 'package:flutter_application_1/pages/hub_page_view.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class EtapaMeditacao {
  final String titulo;
  final String descricao;

  EtapaMeditacao({required this.titulo, required this.descricao});
}

class PagAceitacao extends StatefulWidget {
  const PagAceitacao({super.key});

  @override
  State<PagAceitacao> createState() => _PagAceitacaoState();
}

class _PagAceitacaoState extends State<PagAceitacao> {
  final List<EtapaMeditacao> instrucoes = [
    EtapaMeditacao(
      titulo: "O Ato de Acolher",
      descricao:
          "Aceitar é abrir os braços para o que é — sem resistência, sem pressa. É olhar para dentro e reconhecer o que existe, mesmo que doa. A aceitação não muda o que aconteceu, mas muda a forma como você caminha a partir daí.",
    ),
    EtapaMeditacao(
      titulo: "O Fardo que se Dissolve",
      descricao:
          "Quando deixamos de lutar contra as circunstâncias, algo se desfaz dentro de nós. O peso da negação se transforma em leveza. A mente para de buscar justificativas, e o coração encontra espaço para simplesmente ser.",
    ),
    EtapaMeditacao(
      titulo: "A Paz no Presente",
      descricao:
          "Aceitar é um gesto silencioso de amor-próprio. É dizer: “eu me permito estar aqui, exatamente como estou”. Nesse instante, o presente deixa de ser um obstáculo e se torna um lar — o único lugar onde a vida realmente acontece.",
    ),
    EtapaMeditacao(
      titulo: "O Fluxo Natural da Vida",
      descricao:
          "Tudo muda, e a aceitação é o que nos mantém em harmonia com esse movimento. Quando confiamos no ritmo da existência, não precisamos mais forçar o que não está pronto. Aprendemos a esperar com serenidade, sabendo que tudo tem seu tempo.",
    ),
    EtapaMeditacao(
      titulo: "Transformar Sem Resistir",
      descricao:
          "Da aceitação nasce a verdadeira transformação. Não porque forçamos a mudança, mas porque paramos de bloqueá-la. Ao dizer “sim” ao momento presente, abrimos espaço para o novo — e nele, encontramos o equilíbrio que sempre buscamos.",
    ),
  ];

  final Color fundoClaro = const Color(0xFFEBE8E0);
  final Color verdePrincipal = const Color(0xFF7A9591);
  final Color verdeBotao = Colors.grey[400]!;
  final Color verdeContorno = const Color(0xFFA4A4A4);

  @override
  void initState() {
    super.initState();
    // 🔒 Bloqueia a rotação (modo retrato)
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void dispose() {
    // 🔄 Restaura a orientação ao sair da página
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

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
                    "Aprenda a acolher a si mesmo e as circunstâncias da vida, encontrando serenidade e harmonia através da aceitação.",
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

                      // PASSOS
                      Text(
                        "Passos para cultivar a aceitação e viver em harmonia consigo mesmo",
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
                      ...VideoPlayList.videoListAceitacao.map((video) {
                        return YoutubeVideoCard(
                          videoUrl: video["videoUrl"]!,
                          title: video["title"]!,
                          subtitle: video["subtitle"]!,
                        );
                      }),

                      const SizedBox(height: 20),
                      const Center(
                        child: Text(
                          "Respire profundamente, acolha-se e permita que a aceitação traga paz e equilíbrio à sua vida.",
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
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
    _controller = YoutubePlayerController(
      initialVideoId: videoId ?? "",
      flags: const YoutubePlayerFlags(autoPlay: false, enableCaption: true),
    );

    // 🔁 Detecta quando entra e sai do modo tela cheia
    _controller.addListener(() async {
      if (_controller.value.isFullScreen) {
        // 👉 Permite rotação livre no modo tela cheia
        await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      } else {
        // 🔒 Bloqueia novamente no modo retrato
        await SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                controller: _controller,
                showVideoProgressIndicator: true,
              ),
              const SizedBox(height: 8),
              Text(
                widget.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.subtitle,
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
