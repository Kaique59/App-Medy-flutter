import 'package:flutter/material.dart';

class PagMeditar extends StatelessWidget {
  final bool temaEscuro;
  final VoidCallback onTrocarTema;

  const PagMeditar({
    Key? key,
    required this.temaEscuro,
    required this.onTrocarTema,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;
    final altura = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: temaEscuro ? Colors.black : Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCabecalho(largura),
            SizedBox(height: altura * 0.03),
            _buildCards(largura, altura),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  /// Cabeçalho kaique 100% gay 
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
            backgroundImage: AssetImage(temaEscuro ? "" : ""),
          ),
          SizedBox(width: largura * 0.1),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Silencie o mundo.",
                style: TextStyle(
                  color: temaEscuro ? Colors.grey[300] : Colors.blueGrey[400],
                  fontSize: largura * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Ouça a si mesmo.",
                style: TextStyle(
                  color: temaEscuro ? Colors.white : Colors.blue[800],
                  fontSize: largura * 0.06,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: const Offset(1.5, 1.5),
                      blurRadius: 3,
                      color: temaEscuro
                          ? Colors.black54
                          : Colors.blue[200]!,
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

  /// Cards de conteúdo
  Widget _buildCards(double largura, double altura) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _card(
              largura,
              altura,
              temaEscuro,
              icon: Icons.self_improvement,
              text: "Introdução - Meditação",
            ),
            SizedBox(height: altura * 0.03),
            _card(
              largura,
              altura,
              temaEscuro,
              icon: Icons.motion_photos_on,
              text: "Meditação Novo Ciclo",
            ),
          ],
        ),
      ),
    );
  }

  /// Barra inferior
  Widget _buildBottomBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: temaEscuro ? Colors.grey[900] : Colors.blue[400],
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      currentIndex: 1,
      onTap: (index) {
        if (index == 0) Navigator.pop(context);
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
          icon: Icon(Icons.self_improvement),
          label: "Meditação",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.headphones),
          label: "Audios",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Desabafo"),
      ],
    );
  }

  /// Card genérico
  Widget _card(
    double largura,
    double altura,
    bool temaEscuro, {
    required IconData icon,
    required String text,
  }) {
    return Container(
      width: largura * 0.7,
      height: altura * 0.12,
      decoration: BoxDecoration(
        color: temaEscuro ? Colors.grey[800] : Colors.blue[100],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: temaEscuro ? Colors.black26 : Colors.blue.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: largura * 0.12, color: Colors.blue[700]),
          SizedBox(height: altura * 0.01),
          Text(
            text,
            style: TextStyle(
              fontSize: largura * 0.05,
              fontWeight: FontWeight.bold,
              color: temaEscuro ? Colors.white : Colors.blue[800],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
