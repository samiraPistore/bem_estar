import 'package:bem_estar/componentes/custom_header.dart';
import 'package:bem_estar/providers/desafio_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Carrega o ID do desafio salvo localmente assim que a tela abre
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DesafiosProvider>().carregarProgresso();
    });
  }

  @override
  Widget build(BuildContext context) {
    final desafiosProvider = context.watch<DesafiosProvider>();

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Header(title: 'Desafio ${desafiosProvider.desafioAtualId} de 5'),
                const SizedBox(height: 20),
                
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    // Agora que gravamos no passo 1, este token existirá!
                    final token = prefs.getString('token_jwt') ?? '';
                    
                    final sucesso = await desafiosProvider.buscarDesafio(token);
                    if (!sucesso && context.mounted) {
                      await prefs.clear();
                      Navigator.pushReplacementNamed(context, '/login');
                    }
                  }, 
                  child: const Text('Ver desafio do dia')
                ),
                
                if (desafiosProvider.textoDesafioExibido != null)
                  Text(desafiosProvider.textoDesafioExibido!),

                ElevatedButton(
                  onPressed: desafiosProvider.textoDesafioExibido != null 
                      ? desafiosProvider.concluirDesafio 
                      : null, 
                  child: const Text('Concluir desafio')
                ),
                ElevatedButton(
                  onPressed: desafiosProvider.proximoDesafio, 
                  child: const Text('Próximo desafio')
                ),
              ],
            ),
          ),
          
          if (desafiosProvider.isLoading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}