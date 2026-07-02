import 'dart:io';
import 'package:bem_estar/providers/splash_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;

  @override
  void initState() {
    super.initState();

    // Configura a tela cheia
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    // Inicializa a animação visual de 3 segundos
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _iniciarFluxo();
    });
  }

  Future<void> _iniciarFluxo() async {
    final splashProvider = Provider.of<SplashProvider>(context, listen: false);

    // Aguarda a lógica de verificação rodar no Provider
    await splashProvider.initializeApp();
    if (!mounted) return;

    if (splashProvider.status == SplashStatus.success) {
      Navigator.pushReplacementNamed(context, '/login');
    } else if (splashProvider.status == SplashStatus.error) {
      _exibirPopupErro();
    }
  }

  void _exibirPopupErro() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erro de Conexão'),
          content: const Text(
            'Não foi possível estabelecer conexão com o servidor.',
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Platform.isAndroid ? SystemNavigator.pop() : exit(0),
              child: const Text('Fechar Aplicativo'),
            ),
          ],
        );
      },
    );
  }
  
  //Liberação de recursos
  @override
  void dispose() {
    _progressController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              width: MediaQuery.of(context).size.width * 0.6,
            ),

            SizedBox(height: 40),

            AnimatedBuilder(
              animation: _progressController,
              builder: (context, child) {
                return Container(
                  width: 200,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 200 * _progressController.value,
                        decoration: BoxDecoration(
                          color: const Color(0xFF6C9BCF),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
