import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pagmeditar.dart'; // <-- Import da sua página de meditação

void main() {
  runApp(MyApp());
}

class Alarme {
  String nome;
  Duration duracao;

  Alarme({required this.nome, required this.duracao});
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

class HomePage extends StatefulWidget {
  final bool temaEscuro;
  final VoidCallback onTrocarTema;

  HomePage({required this.temaEscuro, required this.onTrocarTema});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? _timer;
  Duration _tempoRestante = Duration.zero;
  bool _timerAtivo = false;

  int horasSelecionadas = 0;
  int minutosSelecionados = 0;
  int segundosSelecionados = 0;

  final TextEditingController _nomeController = TextEditingController();

  List<Alarme> alarmesSalvos = [];

  void _iniciarTimer(Duration duracao) {
    _timer?.cancel();
    setState(() {
      _tempoRestante = duracao;
      _timerAtivo = true;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_tempoRestante.inSeconds == 0) {
        timer.cancel();
        setState(() {
          _timerAtivo = false;
        });
        _mostrarAlerta();
      } else {
        setState(() {
          _tempoRestante = _tempoRestante - Duration(seconds: 1);
        });
      }
    });
  }

  void _pararTimer() {
    if (_timer != null && _timerAtivo) {
      _timer!.cancel();
      setState(() {
        _timerAtivo = false;
      });
    }
  }

  void _apagarTimer() {
    _pararTimer();
    setState(() {
      _tempoRestante = Duration.zero;
    });
  }

  void _mostrarAlerta() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Alarme'),
        content: Text('O tempo acabou!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Ok'),
          ),
        ],
      ),
    );
  }

  String _formatarDuration(Duration duracao) {
    String doisDigitos(int n) => n.toString().padLeft(2, '0');
    final horas = doisDigitos(duracao.inHours);
    final minutos = doisDigitos(duracao.inMinutes.remainder(60));
    final segundos = doisDigitos(duracao.inSeconds.remainder(60));
    return '$horas:$minutos:$segundos';
  }

  void _salvarAlarme(String nome, Duration duracao) {
    if (duracao.inSeconds > 0 && nome.trim().isNotEmpty) {
      bool existe = alarmesSalvos.any((a) =>
          a.nome.toLowerCase() == nome.toLowerCase() &&
          a.duracao == duracao);
      if (!existe) {
        setState(() {
          alarmesSalvos.add(Alarme(nome: nome.trim(), duracao: duracao));
        });
      }
    }
  }

  Widget _buildPicker({
    required int value,
    required int max,
    required ValueChanged<int> onChanged,
    required String label,
  }) {
    return Column(
      children: [
        SizedBox(
          width: 80,
          height: 120,
          child: CupertinoPicker(
            scrollController: FixedExtentScrollController(initialItem: value),
            itemExtent: 32,
            onSelectedItemChanged: onChanged,
            children: List.generate(
              max + 1,
              (index) => Center(
                child: Text(
                  index.toString().padLeft(2, '0'),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: widget.temaEscuro ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: widget.temaEscuro ? Colors.white : Colors.black),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _nomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    double altura = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: widget.temaEscuro ? Colors.black : Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(largura * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: widget.onTrocarTema,
                    child: CircleAvatar(
                      radius: largura * 0.07,
                      backgroundColor: Colors.transparent,
                      child: Icon(
                        widget.temaEscuro ? Icons.dark_mode : Icons.light_mode,
                        color: widget.temaEscuro ? Colors.white : Colors.black,
                        size: largura * 0.07,
                      ),
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
                            color: widget.temaEscuro
                                ? Colors.grey[300]
                                : Colors.blueGrey[400],
                            fontSize: largura * 0.045,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Ouça a si mesmo.",
                          style: TextStyle(
                            color: widget.temaEscuro
                                ? Colors.white
                                : Colors.blue[800],
                            fontSize: largura * 0.06,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                offset: Offset(1.5, 1.5),
                                blurRadius: 3,
                                color: widget.temaEscuro
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

              SizedBox(height: altura * 0.05),

              Center(
                child: Container(
                  width: largura * 0.7,
                  height: altura * 0.14,
                  decoration: BoxDecoration(
                    color:
                        widget.temaEscuro ? Colors.grey[850] : Colors.blue[100],
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: widget.temaEscuro
                            ? Colors.black54
                            : Colors.blue.shade200,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "Navegar",
                      style: TextStyle(
                        fontSize: largura * 0.055,
                        fontWeight: FontWeight.bold,
                        color: widget.temaEscuro
                            ? Colors.white
                            : Colors.blue[800],
                        shadows: [
                          Shadow(
                            offset: Offset(1.5, 1.5),
                            blurRadius: 3,
                            color: widget.temaEscuro
                                ? Colors.black54
                                : Colors.blue[200]!,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: altura * 0.04),

              Text(
                "Nome do Alarme:",
                style: TextStyle(
                  fontSize: largura * 0.045,
                  fontWeight: FontWeight.w600,
                  color: widget.temaEscuro ? Colors.white : Colors.black87,
                ),
              ),
              SizedBox(height: 6),
              TextField(
                controller: _nomeController,
                maxLength: 20,
                style: TextStyle(
                    color: widget.temaEscuro ? Colors.white : Colors.black),
                decoration: InputDecoration(
                  counterText: '',
                  filled: true,
                  fillColor:
                      widget.temaEscuro ? Colors.grey[850] : Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Ex: Meditação matinal',
                  hintStyle: TextStyle(
                      color: widget.temaEscuro ? Colors.white54 : Colors.black45),
                  prefixIcon: Icon(Icons.label,
                      color: widget.temaEscuro ? Colors.white54 : Colors.black45),
                ),
              ),

              SizedBox(height: 20),

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildPicker(
                      value: horasSelecionadas,
                      max: 23,
                      onChanged: (val) => setState(() => horasSelecionadas = val),
                      label: "h",
                    ),
                    SizedBox(width: 12),
                    _buildPicker(
                      value: minutosSelecionados,
                      max: 59,
                      onChanged: (val) => setState(() => minutosSelecionados = val),
                      label: "m",
                    ),
                    SizedBox(width: 12),
                    _buildPicker(
                      value: segundosSelecionados,
                      max: 59,
                      onChanged: (val) => setState(() => segundosSelecionados = val),
                      label: "s",
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    icon: Icon(Icons.alarm),
                    label: Text('Iniciar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[600],
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: _timerAtivo
                        ? null
                        : () {
                            final duracao = Duration(
                              hours: horasSelecionadas,
                              minutes: minutosSelecionados,
                              seconds: segundosSelecionados,
                            );
                            final nome = _nomeController.text;
                            if (duracao.inSeconds > 0 && nome.trim().isNotEmpty) {
                              _iniciarTimer(duracao);
                              _salvarAlarme(nome, duracao);
                              FocusScope.of(context).unfocus();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Informe nome e duração válidos!'),
                                ),
                              );
                            }
                          },
                  ),
                  ElevatedButton.icon(
                    icon: Icon(Icons.pause),
                    label: Text('Parar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[600],
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: _timerAtivo ? _pararTimer : null,
                  ),
                  ElevatedButton.icon(
                    icon: Icon(Icons.clear),
                    label: Text('Apagar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[600],
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: _tempoRestante > Duration.zero ? _apagarTimer : null,
                  ),
                ],
              ),

              SizedBox(height: 25),

              Center(
                child: Text(
                  _tempoRestante > Duration.zero
                      ? 'Tempo restante: ${_formatarDuration(_tempoRestante)}'
                      : 'Nenhum timer ativo',
                  style: TextStyle(
                    fontSize: largura * 0.07,
                    fontWeight: FontWeight.bold,
                    color: widget.temaEscuro ? Colors.white : Colors.blue[800],
                  ),
                ),
              ),

              SizedBox(height: 30),

              Text(
                "Alarmes Salvos",
                style: TextStyle(
                  fontSize: largura * 0.05,
                  fontWeight: FontWeight.bold,
                  color: widget.temaEscuro ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 12),

              alarmesSalvos.isEmpty
                  ? Text(
                      "Nenhum alarme salvo.",
                      style: TextStyle(
                          color:
                              widget.temaEscuro ? Colors.white54 : Colors.black54),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: alarmesSalvos.length,
                      itemBuilder: (context, index) {
                        final alarme = alarmesSalvos[index];
                        return Card(
                          color:
                              widget.temaEscuro ? Colors.grey[850] : Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                          margin: EdgeInsets.symmetric(vertical: 6),
                          elevation: 4,
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            title: Text(
                              alarme.nome,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: largura * 0.045,
                                color: widget.temaEscuro ? Colors.white : Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              _formatarDuration(alarme.duracao),
                              style: TextStyle(
                                color: widget.temaEscuro
                                    ? Colors.white70
                                    : Colors.black54,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.redAccent),
                              onPressed: () {
                                setState(() {
                                  alarmesSalvos.removeAt(index);
                                });
                              },
                              tooltip: 'Apagar alarme',
                            ),
                            onTap: () {
                              if (!_timerAtivo) {
                                setState(() {
                                  _nomeController.text = alarme.nome;
                                  horasSelecionadas = alarme.duracao.inHours;
                                  minutosSelecionados =
                                      alarme.duracao.inMinutes.remainder(60);
                                  segundosSelecionados =
                                      alarme.duracao.inSeconds.remainder(60);
                                });
                                _iniciarTimer(alarme.duracao);
                              }
                            },
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor:
              widget.temaEscuro ? Colors.grey[900] : Colors.blue[400],
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          currentIndex: 0,
          onTap: (index) {
            if (index == 1) { // Meditação
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PagMeditar(
                    temaEscuro: widget.temaEscuro,
                    onTrocarTema: widget.onTrocarTema,
                  ),
                ),
              );
            }
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
        ),
      ),
    );
  }
}
