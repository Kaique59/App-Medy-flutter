import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_application_1/Config/app_colors.dart';

class AudioRolando extends StatefulWidget {
  final String url;
  final String nome;
  final String categoria;
  final String? img;

  const AudioRolando({
    super.key,
    required this.url,
    required this.nome,
    required this.categoria,
    this.img,
  });

  @override
  State<AudioRolando> createState() => _AudioRolandoState();
}

class _AudioRolandoState extends State<AudioRolando> {
  final AudioPlayer _player = AudioPlayer();
  bool tocando = false;
  Duration duracao = Duration.zero;
  Duration posicao = Duration.zero;

  final Color verdePrincipal = const Color(0xFF7A9591);

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
      body: Stack(
        children: [
          // Fundo com imagem (ou padrão se não houver)
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 224, 240, 224),
              image: DecorationImage(
                image: widget.img != null && widget.img!.isNotEmpty
                    ? NetworkImage(widget.img!)
                    : const AssetImage("assets/fundo.jpg") as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Categoria no canto superior esquerdo
          Positioned(
            top: 40,
            left: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                widget.categoria,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          // Nome do áudio centralizado
          Positioned(
            top: MediaQuery.of(context).size.height * 0.42,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  widget.nome,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          // Área inferior (player)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              decoration: BoxDecoration(
                color: verdePrincipal.withOpacity(0.7),
                borderRadius: const BorderRadius.only(
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

                  // Botão play/pause
                  IconButton(
                    icon: Icon(
                      tocando ? Icons.pause : Icons.play_arrow,
                      size: 70,
                      color: Colors.white,
                    ),
                    onPressed: _playPause,
                  ),

                  const SizedBox(height: 10),

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
          ),
        ],
      ),
    );
  }
}
