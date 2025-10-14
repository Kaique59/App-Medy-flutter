import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String text;
  final String? img;
  final VoidCallback onTap;

  const CustomCard({
    super.key,
    required this.text,
    this.img,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 130,
        height: 130, // define altura fixa para o card
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: img != null && img!.isNotEmpty
              ? DecorationImage(
                  image: NetworkImage(img!),
                  fit: BoxFit.cover, // cobre todo o card
                )
              : null,
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5), // fundo semi-transparente para o texto
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
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
      ),
    );
  }
}
