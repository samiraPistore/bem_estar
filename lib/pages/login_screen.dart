import 'package:bem_estar/componentes/form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bem_estar/providers/auth_provider.dart'; 

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // Escuta as alterações no AuthProvider 
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
    
              Image.asset(
                'assets/logo.png', 
                width: MediaQuery.of(context).size.width * 0.2, 
              ),
              SizedBox(height: 40),
              
              // Formulário com os parâmetros mapeados
              LoginForm(
                isLoading: authProvider.isLoading,
                onSubmeter: (username, password) async {
                 
                  final sucesso = await authProvider.login(username, password);
                  
                  if (sucesso && context.mounted) {
                    Navigator.pushReplacementNamed(context, '/home');
                  } else if (context.mounted) {
                
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Usuário ou senha incorretos.'),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}