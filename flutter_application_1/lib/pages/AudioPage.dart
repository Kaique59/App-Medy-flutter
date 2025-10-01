import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';

class AudioPage extends StatefulWidget {
  final bool temaEscuro;
  final VoidCallback? onTrocarTema;

  const AudioPage({
    super.key,
    this.temaEscuro = false,
    this.onTrocarTema,
  });

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? audioTocando;

  bool carregandoNatureza = true;
  bool carregandoMusicas = true;

  List<Map<String, String>> naturezaList = [];
  List<Map<String, String>> musicasList = [];

  // Substitua pela sua chave quando tiver a conta validada
  final String apiKey = "WvLWfKxWrfdWfnp9r4vS4Vwj14uJ7FQxPlzz3eYd";

  @override
  void initState() {
    super.initState();
    _initBuscas();
  }

  Future<void> _initBuscas() async {
    // não bloqueia a UI — buscamos ambas
    buscarSonsNatureza();
    buscarSonsMusicas();
  }

  /// Faz a chamada para o Freesound de forma genérica (usa header Authorization)
  Future<List<Map<String, String>>> _buscarSons(String query) async {
    final encoded = Uri.encodeComponent(query);
    final url = Uri.parse('https://freesound.org/apiv2/search/text/?query=$encoded&page_size=10');
    final headers = {
      'Authorization': 'Token $apiKey',
      // User-Agent customizado pode ajudar em alguns servidores
      'User-Agent': 'FlutterApp/1.0',
    };

    final resp = await http.get(url, headers: headers).timeout(const Duration(seconds: 15));
    if (resp.statusCode != 200) {
      throw Exception('HTTP ${resp.statusCode}: ${resp.body}');
    }

    final decoded = json.decode(resp.body);
    final List<Map<String, String>> results = [];

    if (decoded is Map && decoded['results'] is List) {
      for (final item in decoded['results']) {
        final name = (item['name'] ?? 'Áudio').toString();
        final previews = item['previews'];
        String? previewUrl;
        if (previews is Map) {
          previewUrl = previews['preview-hq-mp3'] ?? previews['preview-lq-mp3'];
        }
        if (previewUrl != null) {
          results.add({'text': name, 'url': previewUrl.toString()});
        }
      }
    }

    return results;
  }

  Future<void> buscarSonsNatureza() async {
    try {
      final res = await _buscarSons('rain nature');
      if (!mounted) return;
      setState(() {
        naturezaList = res.take(10).toList();
        carregandoNatureza = false;
      });
    } catch (e) {
      if (!mounted) return;
      // fallback local para desenvolvimento
      setState(() {
        naturezaList = [
          {
            'text': 'Chuva (fallback)',
            'url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3'
          },
          {
            'text': 'Pássaros (fallback)',
            'url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3'
          },
        ];
        carregandoNatureza = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao buscar sons (natureza): $e')),
      );
    }
  }

  Future<void> buscarSonsMusicas() async {
    try {
      final res = await _buscarSons('relaxing music');
      if (!mounted) return;
      setState(() {
        musicasList = res.take(10).toList();
        carregandoMusicas = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        musicasList = [
          {
            'text': 'Trilha (fallback)',
            'url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3'
          },
        ];
        carregandoMusicas = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao buscar sons (músicas): $e')),
      );
    }
  }

  /// Tocar / parar
  Future<void> _tocarOuPausar(String url) async {
    try {
      if (audioTocando == url) {
        await _audioPlayer.stop();
        if (!mounted) return;
        setState(() => audioTocando = null);
      } else {
        await _audioPlayer.stop();
        await _audioPlayer.play(UrlSource(url));
        if (!mounted) return;
        setState(() => audioTocando = url);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao tocar áudio: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;
    final altura = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCabecalho(largura),
            SizedBox(height: altura * 0.01),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: largura * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      carregandoNatureza
                          ? const Center(child: CircularProgressIndicator())
                          : _buildCategoria("Natureza", naturezaList),
                      SizedBox(height: altura * 0.03),
                      carregandoMusicas
                          ? const Center(child: CircularProgressIndicator())
                          : _buildCategoria("Músicas", musicasList),
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

  /// Cabeçalho (mantive seus textos)
  Widget _buildCabecalho(double largura) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: largura * 0.06,
        vertical: largura * 0.05,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: largura * 0.07,
            backgroundColor: Colors.transparent,
          ),
          SizedBox(width: largura * 0.1),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Silencie o mundo.",
                style: TextStyle(
                  color: widget.temaEscuro ? Colors.grey[300] : Colors.blueGrey[400],
                  fontSize: largura * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Ouça a si mesmo.",
                style: TextStyle(
                  color: widget.temaEscuro ? Colors.white : Colors.blue[800],
                  fontSize: largura * 0.06,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: const Offset(1.5, 1.5),
                      blurRadius: 3,
                      color: widget.temaEscuro ? Colors.black54 : Colors.blue[200]!,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoria(String titulo, List<Map<String, String>> lista) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 150,
          child: lista.isEmpty
              ? const Center(child: Text('Nenhum som encontrado'))
              : ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: lista.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final item = lista[index];
                    final isPlaying = audioTocando == item["url"];

                    return GestureDetector(
                      onTap: () => _tocarOuPausar(item["url"]!),
                      child: Container(
                        width: 130,
                        decoration: BoxDecoration(
                          color: isPlaying ? Colors.blueGrey[600] : Colors.grey[400],
                          borderRadius: BorderRadius.circular(10),
                          border: isPlaying ? Border.all(color: Colors.blue, width: 2) : null,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            item["text"] ?? "Áudio",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
