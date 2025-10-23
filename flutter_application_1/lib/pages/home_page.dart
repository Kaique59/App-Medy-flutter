import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Config/play_list.dart';
import '../widgets/custom_card.dart';
import 'audio_rolando.dart';

class HomePage extends StatefulWidget {
  bool temaEscuro;
  VoidCallback? onTrocarTema;
  HomePage({this.temaEscuro = false, this.onTrocarTema});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    double altura = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFEBE8E0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabeçalho
              Padding(
                padding: EdgeInsets.all(largura * 0.05),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: widget.onTrocarTema,
                      child: CircleAvatar(
                        radius: largura * 0.07,
                        backgroundColor: Colors.transparent,
                        backgroundImage: const AssetImage('assets/logo.png'),
                      ),
                    ),
                    SizedBox(width: largura * 0.03),
                    Padding(
                      padding: EdgeInsets.only(left: largura * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Silencie o mundo.",
                            style: TextStyle(
                              color: const Color(0xFFA0C8C0),
                              fontSize: largura * 0.045,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Ouça a si mesmo.",
                            style: TextStyle(
                              color: const Color(0xFF748D88),
                              fontSize: largura * 0.06,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  offset: const Offset(1.5, 1.5),
                                  blurRadius: 3,
                                  color: Colors.blue[200]!,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: altura * 0.02),

              // Imagem principal
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.zero,
                    child: Image.network(
                      'https://img.freepik.com/fotos-premium/uma-rosa-esta-florescendo-no-jardim_553012-2774.jpg',
                      width: double.infinity,
                      height: altura * 0.25,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: double.infinity,
                          height: altura * 0.25,
                          color: Colors.grey[300],
                          alignment: Alignment.center,
                          child: const Text(
                            'Erro ao carregar imagem',
                            style: TextStyle(color: Colors.black54),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 105,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "AWQQQIOQHIOI",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: largura * 0.06,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: altura * 0.04),

              // Categoria: Ruídos Terapêuticos
              Padding(
                padding: EdgeInsets.symmetric(horizontal: largura * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Ruídos terapêuticos",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 150,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: PlayList.musicasList.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final item = PlayList.musicasList[index];
                          return CustomCard(
                            text: item["text"]!,
                            img: item["img"],
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AudioRolando(
                                    url: item["url"]!,
                                    nome: item["text"]!,
                                    categoria: "Ruídos terapêuticos",
                                    img: item["img"],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: altura * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}
