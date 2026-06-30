import 'dart:io';

import 'package:bem_estar/providers/splash_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _start();
    });
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }
  
  //chama o provider
  Future<void> _start() async {
    final splashProvider = Provider.of<SplashProvider>(context, listen: false);

    // Aguarda checagem da api e verifica se tem token salvo
    await splashProvider.startApp();

    if (!mounted) return;

    if (splashProvider.status == SplashStatus.success) {
     
      // Se tiver login salvo vai para home
      if (splashProvider.usuarioJaLogado) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.png',
                width: size.width * 0.6,
              ),
        
              SizedBox(height: size.height * 0.04),
              SizedBox(
                width: size.width * 0.6,
                child: LinearProgressIndicator())
            ],
          ),
        ),
      ),
    );
  }
}
