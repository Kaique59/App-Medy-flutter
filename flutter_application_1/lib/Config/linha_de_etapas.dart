import 'package:flutter/material.dart';

class LinhaDeEtapas extends StatelessWidget {
  final int etapaAtual;
  final Function(int) onTap;
  final double altura;
  final int totalEtapas;

  const LinhaDeEtapas({
    super.key,
    required this.etapaAtual,
    required this.onTap,
    required this.altura,
    this.totalEtapas = 3,
  });

  @override
  Widget build(BuildContext context) {
    final double circuloTamanho = 55; // diminuído de 60 para 55
    final double espacamentoEntreCirculos =
        (altura * 0.55 - circuloTamanho) / (totalEtapas - 1);

    // altura da linha ativa até o centro do círculo atual
    final double linhaAtivaAltura =
        etapaAtual * espacamentoEntreCirculos + circuloTamanho / 2;

    return SizedBox(
      height: altura * 0.55,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                // Linha base
                Positioned(
                  left: 15, // movido da esquerda de 20 para 15
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: 12,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                // Linha ativa
                Positioned(
                  left: 15, // alinhado com a linha base
                  top: 0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    width: 12,
                    height: linhaAtivaAltura,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blueAccent, Colors.lightBlueAccent],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                // Círculos numerados
                Positioned(
                  left: 45, // movido um pouco para a esquerda
                  top: 0,
                  bottom: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(totalEtapas, (index) {
                      final ativo = index <= etapaAtual;
                      return GestureDetector(
                        onTap: () => onTap(index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          width: circuloTamanho,
                          height: circuloTamanho,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ativo ? Colors.blueAccent : Colors.white,
                            border: Border.all(
                              color: ativo
                                  ? Colors.blueAccent
                                  : Colors.blueAccent.withOpacity(0.4),
                              width: 3,
                            ),
                            boxShadow: ativo
                                ? [
                                    BoxShadow(
                                      color: Colors.blueAccent.withOpacity(0.4),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    ),
                                  ]
                                : [],
                          ),
                          child: Center(
                            child: Text(
                              "${index + 1}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: ativo ? Colors.white : Colors.blueAccent,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
