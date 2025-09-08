import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ChatPage.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/pagmeditar.dart';
import 'package:flutter_application_1/pages/Audiopage.dart';

class HubPageView extends StatefulWidget {
  const HubPageView({super.key});

  @override
  State<HubPageView> createState() => _HubPageViewState();
}

class _HubPageViewState extends State<HubPageView> {
  final PageController _controller = PageController();
  int paginaAtual = 0;

  final List<Widget> listPage = [
    HomePage(),
    PagMeditar(),
    AudioPage(),
    ChatPage(),
  ];

  void _mudarPagina(int index) {
    setState(() {
      paginaAtual = index;
    });
    _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              paginaAtual = index;
            });
          },
          children: listPage,
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.blue[400],
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            currentIndex: paginaAtual,
            onTap: _mudarPagina,
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
