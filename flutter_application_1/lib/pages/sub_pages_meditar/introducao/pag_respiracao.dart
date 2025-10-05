import 'package:flutter/material.dart';
import 'package:flutter_application_1/Config/linha_de_etapas.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_application_1/pages/Audiopage.dart'; // Import da página de áudio

// Classe para cada etapa
class EtapaRespiracao {
  final String titulo;
  final String descricao;

  EtapaRespiracao({required this.titulo, required this.descricao});
}

class PagRespiracao extends StatefulWidget {
  const PagRespiracao({super.key});

  @override
  State<PagRespiracao> createState() => _PagRespiracaoState();
}

class _PagRespiracaoState extends State<PagRespiracao>
    with SingleTickerProviderStateMixin {
  int etapaAtual = 0;

  final List<EtapaRespiracao> instrucoes = [
    EtapaRespiracao(
      titulo: "Encontre a calma",
      descricao:
          "Escolha um local silencioso, livre de distrações, onde você se sinta seguro e confortável. Sente-se ou deite-se mantendo a coluna ereta, mas sem rigidez. Feche suavemente os olhos se quiser e solte os ombros, permitindo que cada músculo do corpo relaxe. Respire naturalmente por alguns instantes, apenas percebendo o ar entrar e sair, criando um momento de presença consigo mesmo.",
    ),
    EtapaRespiracao(
      titulo: "Inspire profundamente",
      descricao:
          "Respire devagar pelo nariz, enchendo os pulmões de ar gradualmente. Sinta a barriga expandir suavemente, depois o peito, sem forçar. Imagine que está levando oxigênio para cada célula do corpo. Conte mentalmente até 4 durante a inspiração, mantendo o ritmo calmo e constante. Concentre-se na sensação do ar entrando, sentindo frescor e energia.",
    ),
    EtapaRespiracao(
      titulo: "Segure o ar",
      descricao:
          "Segure a respiração por um momento confortável, cerca de 2 a 3 segundos. Evite tensionar o corpo; apenas mantenha a atenção na sensação de plenitude do ar nos pulmões. Esse breve intervalo ajuda a equilibrar o sistema nervoso e traz sensação de estabilidade interna. Perceba como o corpo se acalma naturalmente enquanto mantém o ar dentro.",
    ),
    EtapaRespiracao(
      titulo: "Expire lentamente",
      descricao:
          "Solte o ar suavemente pela boca, como se estivesse soprando devagar através de um canudo imaginário. Conte até 6 durante a expiração, prolongando a saída do ar. Imagine que cada respiração leva embora a tensão, o estresse e pensamentos pesados. Sinta o relaxamento se espalhar pelo corpo, da cabeça aos pés, enquanto libera tudo que não precisa mais.",
    ),
    EtapaRespiracao(
      titulo: "Repita e concentre-se",
      descricao:
          "Continue o ciclo de inspiração, retenção e expiração de 5 a 10 vezes, ou pelo tempo que desejar. Mantenha o foco na respiração e nas sensações do corpo. Se pensamentos surgirem, observe-os sem julgamento e suavemente retorne a atenção ao ar entrando e saindo. Permita que cada respiração aprofunde seu estado de calma, tranquilidade e presença no momento.",
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
                    "Nem tudo que é enfrentado pode ser mudado,\nmas nada pode ser mudado até que seja enfrentado.",
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
                              icon: Icons.air,
                              text: "Exercício de respiração",
                              color: Colors.purple[100]!,
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
                                text: "Sons relaxantes",
                                color: Colors.purple[100]!,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),

                      // VÍDEOS
                      const YoutubeVideoCard(
                        videoUrl: "https://www.youtube.com/watch?v=kiEmbhvv7Fo",
                        title: "Comece sua jornada com uma boa ",
                        subtitle:
                            "Uma introdução guiada à respiração consciente.",
                      ),
                      const YoutubeVideoCard(
                        videoUrl: "https://www.youtube.com/watch?v=Q2Idcwo4DCU",
                        title: "Acalme sua mente",
                        subtitle:
                            "Um exercício para relaxar e aliviar o estresse.",
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        "Guia de respiração",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // LINHA DE ETAPAS COM TEXTO AO LADO
                      SizedBox(
                        height: altura * 0.55,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Linha de etapas
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

                            const SizedBox(
                              width: 20,
                            ), // Espaço entre linha e texto
                            // Texto das instruções com título
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
