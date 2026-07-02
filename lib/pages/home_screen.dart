import 'package:bem_estar/componentes/btn_shape.dart';
import 'package:bem_estar/componentes/custom_header.dart';
import 'package:bem_estar/providers/auth_provider.dart';
import 'package:bem_estar/providers/desafio_provider.dart';
import 'package:bem_estar/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _verDesafioDoDia(String? token) async {
    if (token == null) {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
      return;
    }

    final desafiosProvider = context.read<DesafiosProvider>();
    final sucesso = await desafiosProvider.buscarDesafio(token);

    if (!sucesso && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível buscar o desafio')),
      );
    }
  }

  Future<void> _concluirDesafio() async {
    await context.read<DesafiosProvider>().concluirDesafio();
  }

  Future<void> _proximoDesafio(int desafioId, String? token) async {
    if (desafioId >= 5) return;

    final desafiosProvider = context.read<DesafiosProvider>();
    await desafiosProvider.proximoDesafio();

    if (token == null) {
      if (context.mounted)
        Navigator.of(context).pushReplacementNamed(AppRoutes.login);
      return;
    }
    await desafiosProvider.buscarDesafio(token);
  }

  void _irParaDesafiosConcluidos() {
    Navigator.of(context).pushReplacementNamed(AppRoutes.desafiosC);
  }

  void _irParaSobre() {
    Navigator.of(context).pushReplacementNamed('/sobre');
  }

  @override
  Widget build(BuildContext context) {
    // Escutando apenas as variáveis necessárias para reconstruir a UI
    final desafioId = context.select((DesafiosProvider p) => p.desafioAtualId);
    final isLoading = context.select((DesafiosProvider p) => p.isLoading);
    final textoDesafio = context.select(
      (DesafiosProvider p) => p.textoDesafioExibido,
    );
    final token = context.select((AuthProvider a) => a.usuarioLogado?.token);

    final width = MediaQuery.of(context).size.width * 0.8;
    final height = MediaQuery.of(context).size.height * 0.1;
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Header(title: 'Resumo de progresso'),
              Text('Desafio $desafioId de 5', style: TextStyle( fontSize: MediaQuery.of(context).size.height * 0.02,),),
              const SizedBox(height: 20),
        
              // Botão principal
              ElevatedButton(
                onPressed: isLoading ? null : () => _verDesafioDoDia(token),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: theme.primary,
                  fixedSize: Size(width, height),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Ver desafio do dia',
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: theme.onSurface, fontSize: 30),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container( color: theme.surface,height: 100, child: Text(textoDesafio.toString(),  style: TextStyle(color: theme.onSurface, fontSize: 20),)),
              ),
              SizedBox(height: 80),
              Column(
                children: [
                  CustomBtn(
                    title: 'Concluir desafio',
                    onpress:
                        _concluirDesafio, // Passado diretamente pois não precisa de parâmetros
                  ),
                  SizedBox(height: 12),
                  CustomBtn(
                    title: 'Próximo desafio',
                    onpress: () {
                      if (desafioId < 5) {
                        _proximoDesafio(desafioId, token);
                      } else {
                        return null;
                      }
                    }, // Desabilita visualmente o botão se passar de 5
                  ),
                  SizedBox(height: 12),
                  CustomBtn(
                    title: 'Desafios concluídos',
                    onpress: _irParaDesafiosConcluidos,
                  ),
                ],
              ),
        
              TextButton(
                onPressed: _irParaSobre,
                child: Text(
                  'Sobre',
        
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: theme.onSecondary,
                    fontSize: MediaQuery.of(context).size.height * 0.028,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
