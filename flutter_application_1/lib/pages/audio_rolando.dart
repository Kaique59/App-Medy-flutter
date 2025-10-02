import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_application_1/Config/app_colors.dart';

class AudioRolando extends StatefulWidget {
  final String url;
  final String nome;

  const AudioRolando({super.key, required this.url, required this.nome});

  @override
  State<AudioRolando> createState() => _AudioRolandoState();
}

class _AudioRolandoState extends State<AudioRolando> {
  final AudioPlayer _player = AudioPlayer();
  bool tocando = false;
  Duration duracao = Duration.zero;
  Duration posicao = Duration.zero;

  @override
  void initState() {
    super.initState();
    _iniciar();
  }

  Future<void> _iniciar() async {
    _player.onDurationChanged.listen((d) {
      setState(() => duracao = d);
    });
    _player.onPositionChanged.listen((p) {
      setState(() => posicao = p);
    });
    await _player.play(UrlSource(widget.url));
    setState(() => tocando = true);
  }

  Future<void> _playPause() async {
    if (tocando) {
      await _player.pause();
    } else {
      await _player.resume();
    }
    setState(() => tocando = !tocando);
  }

  String formatarTempo(Duration d) {
    String doisDigitos(int n) => n.toString().padLeft(2, '0');
    final min = doisDigitos(d.inMinutes.remainder(60));
    final sec = doisDigitos(d.inSeconds.remainder(60));
    return "$min:$sec";
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 224, 240, 224),
          image: DecorationImage(
            image: AssetImage("assets/fundo.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80, left: 30),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Natureza",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            // Nome do áudio
            Text(
              widget.nome,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Card player
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              decoration: BoxDecoration(
                color: AppColors.azulMenu,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Slider
                  Slider(
                    value: posicao.inSeconds.toDouble(),
                    max: duracao.inSeconds.toDouble() > 0
                        ? duracao.inSeconds.toDouble()
                        : 1,
                    activeColor: AppColors.amareloMenu,
                    inactiveColor: Colors.white54,
                    onChanged: (value) async {
                      final pos = Duration(seconds: value.toInt());
                      await _player.seek(pos);
                    },
                  ),
                  // Tempo
                  Text(
                    formatarTempo(posicao),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Botões
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 70),
                      IconButton(
                        icon: Icon(
                          tocando ? Icons.pause : Icons.play_arrow,
                          size: 70,
                          color: Colors.white,
                        ),
                        onPressed: _playPause,
                      ),
                      const SizedBox(width: 70), // círculo vazio da direita
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Botão voltar
                  TextButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 24,
                    ),
                    label: const Text(
                      "voltar",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
