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

class PagAprendaMeditacao extends StatefulWidget {
  const PagAprendaMeditacao({super.key});

  @override
  State<PagAprendaMeditacao> createState() => _PagAprendaMeditacaoState();
}

class _PagAprendaMeditacaoState extends State<PagAprendaMeditacao>
    with SingleTickerProviderStateMixin {
  int etapaAtual = 0;

  final List<EtapaMeditacao> instrucoes = [
    EtapaMeditacao(
      titulo: "Respire e Esteja Presente",
      descricao:
          "Feche os olhos e inspire profundamente."
          "Sinta o ar entrando e saindo, levando embora as tensões do corpo."
          "Você não precisa estar em outro lugar, nem ser outra pessoa — apenas esteja aqui e agora.",
    ),
    EtapaMeditacao(
      titulo: "O Silêncio que Cura",
      descricao:
          "Sente-se confortavelmente e observe o silêncio ao seu redor."
          "Não lute contra os pensamentos, apenas veja-os passar como nuvens no céu."
          "No fundo do silêncio, mora a paz que você sempre buscou.",
    ),
    EtapaMeditacao(
      titulo: "O Corpo e a Respiração",
      descricao:
          "Sinta o peso do seu corpo apoiado no chão."
          "Perceba o ar entrando pelo nariz, enchendo seus pulmões, e saindo suavemente."
          "A cada respiração, o corpo relaxa, e a mente se torna mais leve.",
    ),
    EtapaMeditacao(
      titulo: "Aceitação",
      descricao:
          "Aceitar é compreender que a vida tem seu próprio ritmo e que nem tudo precisa ser controlado."
          "Há momentos em que o melhor que podemos fazer é respirar fundo e permitir que as coisas simplesmente aconteçam."
          "Quando soltamos o peso das expectativas e acolhemos o presente como ele é, o coração se torna leve e a mente encontra paz."
          "Na aceitação, descobrimos que o agora é suficiente e que tudo está exatamente onde deveria estar.",
    ),
    EtapaMeditacao(
      titulo: "Um Novo Começo",
      descricao:
          "Toda respiração é uma porta aberta para recomeçar."
          "Ao inspirar, você convida a calma, e ao expirar, libera o que já não faz parte de você."
          "Cada ciclo de ar é uma chance de se renovar, de deixar o passado ir e acolher o novo com serenidade."
          "Não importa quantas vezes você tenha caído, o momento presente sempre oferece uma nova oportunidade de florescer com mais força e clareza.",
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
                    "A meditação é a arte de acalmar a mente e harmonizar corpo e espírito.",
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
                              icon: Icons.spa,
                              text: "Guia de meditação",
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
                                text: "Sons para meditar",
                                color: Colors.purple[100]!,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),

                      // VÍDEOS
                      const YoutubeVideoCard(
                        videoUrl: "https://www.youtube.com/watch?v=1MrQPZuSs7A",
                        title: "Meditação Simples",
                        subtitle:
                            "Aprenda técnicas para acalmar a mente e relaxar o corpo.",
                      ),
                      const YoutubeVideoCard(
                        videoUrl: "https://www.youtube.com/watch?v=32UM11dSves",
                        title: "O começo de uma Meditação mais Serena",
                        subtitle:
                            "Movimentos simples para relaxar o corpo e a mente para meditar.",
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        "Passos para aprender meditação",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // LINHA DE ETAPAS COM TEXTO AO LADO
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
                          "Respire fundo, sinta a paz envolver você e leve consigo a serenidade deste momento.",
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
