import 'package:bem_estar/componentes/custom_header.dart';
import 'package:flutter/material.dart';

class DesafiosScreen extends StatelessWidget {
  const DesafiosScreen({super.key});

@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Header(title: 'Desafios Concluídos',)
          ],
        ),
      ),
    );
  }
}