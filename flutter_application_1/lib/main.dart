import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool temaEscuro = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: temaEscuro ? ThemeData.dark() : ThemeData.light(),
      home: HomePage(
        temaEscuro: temaEscuro,
        onTrocarTema: () {
          setState(() {
            temaEscuro = !temaEscuro;
          });
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final bool temaEscuro;
  final VoidCallback onTrocarTema;

  HomePage({required this.temaEscuro, required this.onTrocarTema});

  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    double altura = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: temaEscuro ? Colors.black : Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(largura * 0.10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Botão para trocar tema (com ícone)
                  GestureDetector(
                    onTap: onTrocarTema,
                    child: CircleAvatar(
                      radius: largura * 0.07,
                      backgroundColor: Colors.transparent,
                      child: Icon(
                        temaEscuro ? Icons.dark_mode : Icons.light_mode,
                        color: temaEscuro ? Colors.white : Colors.black,
                        size: largura * 0.07,
                      ),
                    ),
                  ),
                  SizedBox(width: largura * 0.03),

                  Padding(
                    padding: EdgeInsets.only(left: largura * 0.1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Silencie o mundo.",
                          style: TextStyle(
                            color: temaEscuro
                                ? Colors.grey[300]
                                : Colors.blueGrey[400],
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
                                offset: Offset(1.5, 1.5),
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
                  ),
                ],
              ),
            ),

            SizedBox(height: altura * 0.05),

            Center(
              child: Container(
                width: largura * 0.7,
                height: altura * 0.14,
                decoration: BoxDecoration(
                  color: temaEscuro ? Colors.grey[800] : Colors.blue[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    "Navegar",
                    style: TextStyle(
                      fontSize: largura * 0.055,
                      fontWeight: FontWeight.bold,
                      color: temaEscuro ? Colors.white : Colors.blue[800],
                      shadows: [
                        Shadow(
                          offset: Offset(1.5, 1.5),
                          blurRadius: 3,
                          color: temaEscuro
                              ? Colors.black54
                              : Colors.blue[200]!,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // Barra inferior
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: temaEscuro ? Colors.grey[900] : Colors.blue[400],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            currentIndex: 0,
            onTap: (index) {},
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
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: "Desabafo",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
