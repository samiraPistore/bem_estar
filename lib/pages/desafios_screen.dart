import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bem_estar/providers/desafio_provider.dart';
import 'package:bem_estar/componentes/custom_header.dart';

class DesafiosCScreen extends StatelessWidget {
  const DesafiosCScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final desafioAtualId = context.select((DesafiosProvider p) => p.desafioAtualId);
    final textoDesafio = context.select((DesafiosProvider p) => p.textoDesafioExibido,
    );
    
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Column(
        children: [
          const Header(title: 'Desafios Concluídos'),
          const SizedBox(height: 10),
          
          // ListView para listar os 5 desafios
          Expanded(
            child: ListView.builder(
              itemCount: 5, 
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemBuilder: (context, index) {
                final numeroDesafio = index + 1;
                
        
                final bool isConcluido = numeroDesafio < desafioAtualId;
              
      
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    tileColor: isConcluido ? theme.surface : theme.secondary,
                    leading: isConcluido ? Icon(
                      isConcluido ? Icons.check_circle : null,
                      color: theme.onSurface,
                    ): null,
                    title: Text(
                      'Desafio $numeroDesafio: $textoDesafio - ${isConcluido ? 'Concluído' : 'Em aberto'}',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        
                      ),
                    ),
                   
                   
                  ),
                );
              },
            ),
          ),
          
          // Botão para voltar para a Home
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/home'); 
              },
              child: const Text('Voltar para o Início', textAlign: TextAlign.justify),
            ),
          ),
        ],
      ),
    );
  }
}