import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Config/app_colors.dart';
import 'package:flutter_application_1/chat_page.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/pagmeditar.dart';
import 'package:flutter_application_1/pages/Audiopage.dart';

class HubPageView extends StatefulWidget {
  final int initialIndex; // ← ADICIONADO

  const HubPageView({super.key, this.initialIndex = 0}); // ← PADRÃO = 0 (Home)

  @override
  State<HubPageView> createState() => _HubPageViewState();
}

class _HubPageViewState extends State<HubPageView> {
  late int currentPage;

  final List<Widget> listPage = [
    HomePage(),
    PagMeditar(),
    AudioPage(),
    ChatPage(),
  ];

  final List<_MenuData> menuItems = const [
    _MenuData(icon: Icons.home, label: 'Home'),
    _MenuData(icon: Icons.self_improvement, label: 'Meditação'),
    _MenuData(icon: CupertinoIcons.music_note_2, label: 'Áudios'),
    _MenuData(icon: Icons.chat, label: 'Desabafo'),
  ];

  @override
  void initState() {
    super.initState();
    currentPage = widget.initialIndex; // ← usa o índice inicial
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          listPage[currentPage],
          // Oculta o BottomNavBar na ChatPage (índice 3)
          if (currentPage != 3)
            Positioned(
              left: 16,
              right: 16,
              bottom: 24,
              child: _BottomNavBar(
                items: menuItems,
                currentIndex: currentPage,
                onItemSelected: (index) => setState(() => currentPage = index),
              ),
            ),
        ],
      ),
    );
  }
}

class _MenuData {
  final IconData icon;
  final String label;

  const _MenuData({required this.icon, required this.label});
}

class _BottomNavBar extends StatelessWidget {
  final List<_MenuData> items;
  final int currentIndex;
  final ValueChanged<int> onItemSelected;

  const _BottomNavBar({
    required this.items,
    required this.currentIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: AppColors.verdePrincipal,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          items.length,
          (index) => _MenuItem(
            data: items[index],
            isActive: currentIndex == index,
            onTap: () => onItemSelected(index),
          ),
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final _MenuData data;
  final bool isActive;
  final VoidCallback onTap;

  const _MenuItem({
    required this.data,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color activeColor = AppColors.amareloMenu;
    final Color inactiveColor = Colors.white;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            data.icon,
            size: 38,
            color: isActive ? activeColor : inactiveColor,
            shadows: isActive
                ? [
                    const Shadow(
                      color: Colors.black54,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ]
                : [],
          ),
          const SizedBox(height: 4),
          Text(
            data.label,
            style: TextStyle(
              color: isActive ? activeColor : inactiveColor,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              fontSize: 15,
              shadows: isActive
                  ? [
                      Shadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : [],
            ),
          ),
        ],
      ),
    );
  }
}
