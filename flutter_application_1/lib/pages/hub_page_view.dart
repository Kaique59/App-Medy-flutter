import 'package:circle_bottom_navigation/circle_bottom_navigation.dart';
import 'package:circle_bottom_navigation/widgets/tab_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/chat_page.dart';
import 'package:flutter_application_1/Config/app_colors.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/pagmeditar.dart';
import 'package:flutter_application_1/pages/Audiopage.dart';

class HubPageView extends StatefulWidget {
  const HubPageView({super.key});

  @override
  State<HubPageView> createState() => _HubPageViewState();
}

class _HubPageViewState extends State<HubPageView> {
  // final PageController _controller = PageController();

  int currentPage = 0;

  final List<Widget> listPage = [
    HomePage(),
    PagMeditar(),
    AudioPage(),
    ChatPage(),
  ];

  // void _mudarPagina(int index) {
  //   setState(() {
  //     paginaAtual = index;
  //   });
  //   _controller.animateToPage(
  //     index,
  //     duration: const Duration(milliseconds: 300),
  //     curve: Curves.easeInOut,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: listPage[currentPage],

        bottomNavigationBar: CircleBottomNavigation(
          circleColor: AppColors.azulEscuroMenu,
          barBackgroundColor: AppColors.azulMenu,
          barHeight: 70,
          circleSize: 40,
          initialSelection: currentPage,
          inactiveIconColor: Colors.white,
          activeIconColor: AppColors.amareloMenu,
          textColor: AppColors.amareloMenu,
          hasElevationShadows: false,
          tabs: [
            TabData(
              icon: Icons.home,
              iconSize: 25,
              title: 'Home',
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            TabData(
              icon: Icons.self_improvement,
              iconSize: 29,
              title: 'Meditar',
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            TabData(
              icon: CupertinoIcons.music_note_2,
              iconSize: 25,
              title: 'Audios',
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            TabData(
              icon: Icons.chat,
              iconSize: 25,
              title: 'Chat',
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ],
          onTabChangedListener: (index) => setState(() => currentPage = index),
        ),
      ),
    );
  }
}
