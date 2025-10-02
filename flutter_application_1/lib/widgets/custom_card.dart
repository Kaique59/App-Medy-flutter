import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const CustomCard({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 130,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 114, 103, 103),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            text,
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
  }
}
