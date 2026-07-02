import 'package:bem_estar/componentes/btn_shape.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bem_estar/providers/desafio_provider.dart';
import 'package:bem_estar/componentes/custom_header.dart';

class DesafiosCScreen extends StatelessWidget {
  const DesafiosCScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final desafioAtualId = context.select(
      (DesafiosProvider p) => p.desafioAtualId,
    );
    final textoDesafio = context.select(
      (DesafiosProvider p) => p.textoDesafioExibido,
    );

    final theme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Header(title: 'Desafios Concluídos'),
            Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border.all(color: theme.onSurface),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            height: size.height * 0.05,
            width: size.width * 0.7,
            child: Center(
              child: Text(
                'Resumo do progresso geral',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.02,
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
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
                    color:isConcluido ? theme.surface : theme.secondary ,
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        tileColor: isConcluido ? theme.surface : theme.secondary,
                        leading: isConcluido
                            ? Icon(
                                isConcluido ? Icons.check_circle : null,
                                color: theme.onSurface,
                              )
                            : null,
                        title: Text(
                          'Desafio $numeroDesafio: $textoDesafio - ${isConcluido ? 'Concluído' : 'Em aberto'}',
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          
            Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: CustomBtn(
                title: 'Voltar para home',
                onpress: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
