import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String title;
  final VoidCallback onpress;

  const CustomBtn({super.key, required this.title, required this.onpress});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.76;
    final height = MediaQuery.of(context).size.height * 0.08;
    return ElevatedButton(
      onPressed: onpress,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: Theme.of(context).colorScheme.primary,
        fixedSize: Size(width, height),
    
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20,
          ), // Define o raio do arredondamento
        ),
      ),
      child: Text(
        title,
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.height * 0.0280,
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
