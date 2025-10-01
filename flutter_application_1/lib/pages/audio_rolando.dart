import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

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
          image: DecorationImage(
            image: AssetImage("assets/fundo.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Natureza", style: const TextStyle(color: Colors.white, fontSize: 16)),
            const SizedBox(height: 10),
            Text(widget.nome, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            Slider(
              value: posicao.inSeconds.toDouble(),
              max: duracao.inSeconds.toDouble() > 0 ? duracao.inSeconds.toDouble() : 1,
              onChanged: (value) async {
                final pos = Duration(seconds: value.toInt());
                await _player.seek(pos);
              },
            ),
            Text(
              posicao.toString().split('.').first,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            IconButton(
              icon: Icon(tocando ? Icons.pause_circle : Icons.play_circle, size: 64, color: Colors.white),
              onPressed: _playPause,
            ),
            const SizedBox(height: 20),
            TextButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              label: const Text("voltar", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
