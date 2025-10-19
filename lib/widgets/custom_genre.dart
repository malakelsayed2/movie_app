import 'package:flutter/material.dart';

class CustomGenre extends StatelessWidget {
  const CustomGenre({super.key, required this.genre});

  final String genre;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.withOpacity(0.3),
      ),
      child: Text(genre, style: TextStyle(fontSize: 15)),
    );
  }
}
