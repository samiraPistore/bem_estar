import 'package:bem_estar/componentes/custom_header.dart';
import 'package:flutter/material.dart';

class SobreScreen extends StatelessWidget {
  const SobreScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              Header(title: 'Sobre o Aplicativo'),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      'Este aplicativo foi criado para ajudar você a desenvolver hábitos mais saudáveis, melhorar seu bem-estar emocional e estimular o Cada ação proposta foi pensada para trazer mais equilíbrio, foco e leveza para a sua rotina. Cuide de você um passo de cada vez.',
                    ),
                    SizedBox(height: 40,),
                    Text('COMO FUNCIONA'),
                    SizedBox(height: 40,),
                    Text('O aplicativo possui 5 desafios rotativos que são disponibilizados progressivamente para você'),
                    SizedBox(height: 40,),
                    Text('"Equilíbiro e Saúde Mental ao seu alcance""'),
                    SizedBox(height: 40,),
                    ElevatedButton(onPressed: (){ Navigator.pushReplacementNamed(context, '/home');}, child: Text('Voltar para home'))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
