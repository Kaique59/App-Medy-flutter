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

class PagAceitacao extends StatefulWidget {
  const PagAceitacao({super.key});

  @override
  State<PagAceitacao> createState() => _PagAceitacaoState();
}

class _PagAceitacaoState extends State<PagAceitacao>
    with SingleTickerProviderStateMixin {
  int etapaAtual = 0;

  final List<EtapaMeditacao> instrucoes = [
    EtapaMeditacao(
      titulo: "Aceitação do Momento Presente",
      descricao:
          "Aceitar o momento presente é permitir que a vida se desenrole sem resistência ou ansiedade. Cada experiência, seja agradável ou desafiadora, traz aprendizados valiosos que fortalecem nossa maturidade emocional. Ao acolher a realidade como ela é, percebemos que cada instante é único e merece nossa atenção plena. Essa prática nos ajuda a encontrar serenidade, clareza interior e a cultivar uma postura de presença consciente, mesmo diante de situações inesperadas.",
    ),
    EtapaMeditacao(
      titulo: "Fluir com a Vida",
      descricao:
          "Fluir com a vida é a arte de acompanhar os ciclos naturais sem lutar contra eles. Em vez de insistir em controlar resultados ou evitar mudanças, aprendemos a adaptar-nos com leveza, flexibilidade e paciência. Esse estado nos permite reagir às situações com equilíbrio, transformando desafios em oportunidades de aprendizado. A fluidez cria espaço para a criatividade, a espontaneidade e a capacidade de perceber as soluções que surgem de forma natural, sem esforço forçado.",
    ),
    EtapaMeditacao(
      titulo: "Liberação de Resistências",
      descricao:
          "Aceitar não significa resignar-se ou desistir, mas sim liberar a resistência que gera tensão, ansiedade e sofrimento. Ao permitir que pensamentos, emoções e acontecimentos fluam naturalmente, sentimos leveza, clareza e expansão interior. Essa prática fortalece a resiliência, promove maior autoconhecimento e nos ajuda a tomar decisões mais conscientes, criando um espaço interno de paz e liberdade para agir com autenticidade e propósito.",
    ),
    EtapaMeditacao(
      titulo: "Harmonia Interior e Conexão",
      descricao:
          "A aceitação profunda cria uma harmonia real entre mente, corpo e espírito. Quando deixamos de lutar contra o inevitável e acolhemos nossas emoções sem julgamento, abrimos espaço para ouvir nossa intuição e alinhar nossas ações com nossos valores mais profundos. Essa integração fortalece nossa autoconfiança, nos conecta com nossa essência e proporciona estabilidade emocional, promovendo bem-estar, serenidade e a capacidade de enfrentar os desafios da vida com equilíbrio e sabedoria.",
    ),
    EtapaMeditacao(
      titulo: "Transformando Desafios em Crescimento",
      descricao:
          "Cada desafio, mudança inesperada ou momento de dificuldade pode ser recebido como parte do fluxo natural da vida. Ao acolher o que surge sem resistência e sem julgamento, transformamos obstáculos em oportunidades de aprendizado e evolução. A prática da fluidez nos permite seguir em frente com coragem, paciência e serenidade, cultivando resiliência, equilíbrio emocional e realização pessoal. Cada passo consciente se torna um degrau rumo ao crescimento e à vida plena.",
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
                    "Aprenda a acolher a si mesmo e as circunstâncias da vida, encontrando serenidade e harmonia através da aceitação.",
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
                              icon: Icons.self_improvement,
                              text: "Guia da Aceitação",
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
                        videoUrl: "https://www.youtube.com/watch?v=KvXBoFQpNAM",
                        title: "Nem tudo é como a gente quer",
                        subtitle:
                            "Descubra como acolher o presente e viver de forma mais consciente.",
                      ),
                      const YoutubeVideoCard(
                        videoUrl: "https://www.youtube.com/watch?v=ygECi_HxydI",
                        title: "A Arte de Aceitar",
                        subtitle:
                            "Aprenda a lidar com desafios e a transformar sua vida com serenidade.",
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        "Passos para cultivar a aceitação e viver em harmonia consigo mesmo",
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
                          "Respire profundamente, acolha-se e permita que a aceitação traga paz e equilíbrio à sua vida.",
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
