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

class PagEquilibrio extends StatefulWidget {
  const PagEquilibrio({super.key});

  @override
  State<PagEquilibrio> createState() => _PagEquilibrioState();
}

class _PagEquilibrioState extends State<PagEquilibrio>
    with SingleTickerProviderStateMixin {
  int etapaAtual = 0;

  final List<EtapaMeditacao> instrucoes = [
    EtapaMeditacao(
      titulo: "Conexão Corpo e Mente",
      descricao:
          "O equilíbrio interno começa ao reconhecer a conexão profunda entre corpo e mente. Ao respirar conscientemente, prestando atenção às sensações físicas e ao ritmo do coração, percebemos que cada pensamento, emoção e gesto impacta nosso estado geral. Quando harmonizamos essas duas dimensões, sentimos serenidade e clareza, abrindo espaço para decisões mais conscientes e atitudes mais equilibradas diante dos desafios diários.",
    ),
    EtapaMeditacao(
      titulo: "Aceitação e Fluidez",
      descricao:
          "Encontrar equilíbrio é aprender a aceitar a vida como ela é, sem resistência ou julgamento. Nem tudo precisa ser controlado; há beleza na fluidez dos acontecimentos e nos ciclos naturais do dia a dia. Ao liberar o que não podemos mudar e acolher o presente, nosso coração se aquece, a mente encontra paz duradoura e nos tornamos capazes de agir com mais clareza, deixando que cada momento se revele com sua própria sabedoria.",
    ),
    EtapaMeditacao(
      titulo: "Centro da Paz Interior",
      descricao:
          "Nosso centro interno é como um refúgio silencioso dentro de nós, um espaço que permanece calmo mesmo quando o mundo ao redor parece agitado. Quando nos afastamos do ruído externo e nos voltamos para a quietude interna, descobrimos força, estabilidade e clareza. É nesse ponto sereno que conseguimos lidar com situações desafiadoras, tomar decisões equilibradas e manter a harmonia entre emoções e pensamentos, cultivando bem-estar contínuo.",
    ),
    EtapaMeditacao(
      titulo: "Harmonia Emocional",
      descricao:
          "Equilíbrio interno envolve também a regulação das emoções, reconhecendo e acolhendo cada sentimento sem permitir que nos domine. A prática da atenção plena e da auto-observação nos permite observar emoções intensas como nuvens passando pelo céu, sem perturbar nosso centro sereno. Essa consciência fortalece nossa capacidade de responder à vida com sabedoria, paciência e compaixão, transformando conflitos internos em oportunidades de crescimento.",
    ),
    EtapaMeditacao(
      titulo: "Renovação Constante",
      descricao:
          "Manter o equilíbrio interno é um processo contínuo, semelhante a cuidar de um jardim que precisa de atenção e carinho diários. Cada respiração consciente, cada pausa para reflexão ou meditação, é uma oportunidade de renovar energia, limpar pensamentos dispersos e fortalecer o foco. A cada dia podemos cultivar estabilidade, serenidade e resiliência, lembrando que o equilíbrio não é um estado estático, mas sim uma prática constante de presença e atenção plena.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;
    final altura = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: SafeArea(
        child: Column(
          children: [
            // TOPO
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
                    "Encontre a harmonia entre corpo, mente e espírito através da meditação do equilíbrio.",
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
                              icon: Icons.balance,
                              text: "Guia de equilíbrio",
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
                                text: "Sons para relaxar",
                                color: Colors.blue[100]!,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),

                      // VÍDEOS
                      const YoutubeVideoCard(
                        videoUrl: "https://www.youtube.com/watch?v=I0YUoDp2MAc",
                        title: "Recupere o seu Equilíbrio Interno",
                        subtitle:
                            "Um guia prático para alinhar mente e corpo e encontrar serenidade.",
                      ),
                      const YoutubeVideoCard(
                        videoUrl: "https://www.youtube.com/watch?v=URaOBBnG4CA",
                        title: "Energia e Harmonia",
                        subtitle:
                            "Aprenda a respirar e movimentar sua energia interna de forma consciente.",
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        "Passos para alcançar o equilíbrio interior e ter uma vida mais harmoniosa",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
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
                                        color: Colors.blueAccent,
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
                          "Permaneça em equilíbrio, respirando com leveza e deixando a paz fluir através de cada instante.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            color: Colors.blueGrey,
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
          Icon(icon, color: Colors.blueAccent, size: 30),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(
              color: Colors.blueAccent,
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
